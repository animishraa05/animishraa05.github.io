#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"
SOURCES_DIR="$CONTENT_DIR/sources"
AGENTS_FILE="$CONTENT_DIR/AGENTS.md"
INGEST_RULES="$WIKI_DIR/agent-module/INGEST.md"
SCHEMA_FILE="$WIKI_DIR/agent-module/SCHEMA.md"
META_FILE="$WIKI_DIR/.wiki-meta.json"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

usage() {
    echo -e "${CYAN}wiki-ingest${NC} — Ingest a source into the wiki"
    echo ""
    echo "Usage:"
    echo "  ./scripts/wiki-ingest.sh <source-file> [--force] [--dry-run]"
    echo ""
    echo "Arguments:"
    echo "  <source-file>   Filename in sources/ (e.g. 'my-article.md')"
    echo "  --force         Re-ingest even if content hash already exists"
    echo "  --dry-run       Show what would happen without writing"
    echo ""
    echo "Examples:"
    echo "  ./scripts/wiki-ingest.sh Ejb.md"
    echo "  ./scripts/wiki-ingest.sh sources/my-article.md --force"
    echo ""
    echo "Steps:"
    echo "  1. SHA256 dedup check vs wiki/.wiki-meta.json (skip if duplicate)"
    echo "  2. Extracts 25-30 atomic concepts (human teach tone, no LLM fingerprints)"
    echo "  3. Creates/updates concept pages in wiki/[topic]/ (The Problem→Formal Def→2 DOT→Real-World Example)"
    echo "  4. Creates synthesis pages (1-3)"
    echo "  5. Creates hidden source summary (draft:true) + .wiki-meta.json ledger"
    echo "  6. Updates wiki/index.md, wiki/log.md, wiki/open-questions.md, generates MOC, consolidates images, deterministic lint tail"
    echo "  7. Verifies count gate: topic must have 25-30 pages (excl summary/moc), else fail"
    exit 1
}

FORCE=false
DRY_RUN=false
SOURCE_INPUT=""
for arg in "$@"; do
    case "$arg" in
        --force) FORCE=true ;;
        --dry-run) DRY_RUN=true ;;
        --help|-h) usage ;;
        *) if [ -z "$SOURCE_INPUT" ]; then SOURCE_INPUT="$arg"; else echo -e "${RED}Unknown arg: $arg${NC}"; usage; fi ;;
    esac
done

if [ -z "$SOURCE_INPUT" ]; then usage; fi

if [[ "$SOURCE_INPUT" == sources/* ]]; then
    SOURCE_FILE="$SOURCES_DIR/${SOURCE_INPUT#sources/}"
elif [[ "$SOURCE_INPUT" == /* ]]; then
    SOURCE_FILE="$SOURCE_INPUT"
else
    SOURCE_FILE="$SOURCES_DIR/$SOURCE_INPUT"
fi

if [ ! -f "$SOURCE_FILE" ]; then
    echo -e "${RED}Error: Source file not found: $SOURCE_FILE${NC}"
    echo ""
    echo "Available sources:"
    ls -1 "$SOURCES_DIR" 2>/dev/null || echo "  (no files in sources/)"
    exit 1
fi

SOURCE_NAME="$(basename "$SOURCE_FILE")"
SOURCE_TITLE="$(head -1 "$SOURCE_FILE" | sed 's/^#\s*//' | tr -d '\n')"
if [ -z "$SOURCE_TITLE" ]; then SOURCE_TITLE="$SOURCE_NAME"; fi

CONTENT_HASH="$(sha256sum "$SOURCE_FILE" | awk '{print $1}')"
TOPIC_FOLDER="$(basename "$SOURCE_NAME" .md | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')"

echo -e "${GREEN}═══ wiki-ingest ═══${NC}"
echo -e "${CYAN}Source:${NC}     $SOURCE_NAME"
echo -e "${CYAN}Title:${NC}      $SOURCE_TITLE"
echo -e "${CYAN}Topic:${NC}      $TOPIC_FOLDER"
echo -e "${CYAN}Hash:${NC}       ${CONTENT_HASH:0:12}..."
echo -e "${CYAN}AGENTS:${NC}     $AGENTS_FILE"
echo ""

if [ -f "$META_FILE" ] && grep -q "$CONTENT_HASH" "$META_FILE" 2>/dev/null; then
    if [ "$FORCE" = true ]; then
        echo -e "${YELLOW}Hash already exists but --force passed, re-ingesting...${NC}"
    else
        echo -e "${YELLOW}Skip: content hash already ingested (use --force to re-ingest).${NC}"
        grep "$CONTENT_HASH" "$META_FILE" | head -2
        exit 0
    fi
fi

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}Dry run: would ingest $SOURCE_NAME -> wiki/$TOPIC_FOLDER/ (25-30 pages)${NC}"
    exit 0
fi

echo -e "${YELLOW}Starting ingest...${NC}"
echo ""

cd "$CONTENT_DIR"

START_HASH="$(git hash-object wiki/index.md 2>/dev/null || echo "none")"

set +e
opencode run --agent ingest "
You are a wiki maintenance agent. Read ALL of these files first:

1. $AGENTS_FILE — master behavioral rules
2. $INGEST_RULES — ingest-specific process (25-30 hard minimum, Quartz-clean)
3. $SCHEMA_FILE — page format conventions (The Problem → Formal Definition with citation → 2 DOT diagrams → Real-World Example, NO Sources/Active Recall/TODO in body)

Now ingest the source file at $SOURCE_FILE.

Follow the process in $INGEST_RULES step by step.
Follow ALL rules in $AGENTS_FILE strictly.

Critical (Quartz-public, no LLM fingerprints):
- Extract 25-30 atomic concepts minimum — decompose thin sources. Human easy language to teach.
- Every concept page needs TWO Graphviz DOT diagrams: Visual Explanation (internal arch, rankdir=LR/TB, 4-8 nodes, labeled edges) + Semantic Network (graph semantic_*, layout=neato, gold #ffd700 center, blue prereq #cce5ff, green builds-into #d4edda, orange contrasts #ffe5cc, gray related #f0f0f0, 5-10 nodes)
- NO Sources section in body — provenance hidden in draft:true summary + wiki/.wiki-meta.json ledger
- NO Active Recall callouts, NO <!-- TODO --> comments, NO status: stub banners in public body
- Connections: 4+ links with one-line why, bidirectional (resolved by lint tail)
- Formal Definition must have inline citation: Per Tanenbaum / MDN / Wikipedia: \"...\"
- Real-World Example: one runnable cpp/python/bash snippet or short story

Internal:
- Create hidden source summary wiki/[$TOPIC_FOLDER]/[$TOPIC_FOLDER]-summary.md with draft: true + content_hash: $CONTENT_HASH
- Append ledger entry to wiki/.wiki-meta.json: {\"$CONTENT_HASH\": {\"source_path\": \"sources/$SOURCE_NAME\", \"ingested\": \"YYYY-MM-DD\", \"topic\": \"$TOPIC_FOLDER\"}}
- Create/update 1-3 synthesis pages if natural tensions exist
- Append 2-4 open questions to wiki/open-questions.md

NEVER modify sources/
NEVER create fewer than 25 concept/synthesis pages (fail otherwise)
"
INGEST_EXIT=$?
set -e

if [ $INGEST_EXIT -ne 0 ]; then
    echo -e "${RED}Ingest agent failed with exit $INGEST_EXIT${NC}"
    exit $INGEST_EXIT
fi

echo ""
echo -e "${YELLOW}Post-ingest tail: images + MOC + deterministic lint...${NC}"
if ls "$WIKI_DIR/$TOPIC_FOLDER"/*.md >/dev/null 2>&1; then
    python3 "$SCRIPT_DIR/consolidate_images.py" 2>/dev/null | head -20 || true
    bash "$SCRIPT_DIR/generate-wiki-mocs.sh" --topic="$TOPIC_FOLDER" 2>/dev/null || bash "$SCRIPT_DIR/generate_mocs.py" 2>/dev/null | head -5 || true
    bash "$SCRIPT_DIR/wiki-lint-det.sh" --topic="$TOPIC_FOLDER" 2>/dev/null | tail -20 || true
fi

COUNT="$(ls -1 "$WIKI_DIR/$TOPIC_FOLDER"/*.md 2>/dev/null | grep -v summary | grep -v moc | wc -l | tr -d ' ')"
if [ -n "$COUNT" ] && [ "$COUNT" -lt 25 ]; then
    echo -e "${RED}FAIL: Topic wiki/$TOPIC_FOLDER has only $COUNT pages (excl summary/moc), need 25-30. Decompose further or add synthesis pages.${NC}"
    echo -e "${YELLOW}Ingest completed but count gate FAILED — fix before committing.${NC}"
else
    echo -e "${GREEN}Count gate: $COUNT pages in wiki/$TOPIC_FOLDER (ok)${NC}"
fi

END_HASH="$(git hash-object wiki/index.md 2>/dev/null || echo "none")"

echo ""
echo -e "${GREEN}═══ Ingest Complete ═══${NC}"

if [ "$START_HASH" != "$END_HASH" ]; then
    echo -e "${YELLOW}Summary:${NC}"
    echo "  Source: $SOURCE_NAME"
    echo "  Title:  $SOURCE_TITLE"
    echo "  Topic:  $TOPIC_FOLDER"
    echo "  Hash:   $CONTENT_HASH"
    echo ""
    echo -e "${YELLOW}New/updated pages in wiki/:${NC}"
    git diff --name-status HEAD 2>/dev/null | grep 'wiki/' | sed 's/^A/  + Created:/;s/^M/  ~ Updated:/;s/^D/  - Deleted:/' | head -30
    echo ""
    echo -e "${CYAN}Next: review wiki/$TOPIC_FOLDER/*.md then git commit${NC}"
else
    echo -e "${YELLOW}No changes detected in wiki/index.md. Check wiki/log.md for details.${NC}"
fi
