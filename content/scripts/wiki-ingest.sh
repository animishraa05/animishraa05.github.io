#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"
SOURCES_DIR="$CONTENT_DIR/sources"
AGENTS_FILE="$CONTENT_DIR/AGENTS.md"
INGEST_RULES="$WIKI_DIR/agent-module/INGEST.md"
SCHEMA_FILE="$WIKI_DIR/agent-module/SCHEMA.md"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

usage() {
    echo -e "${CYAN}wiki-ingest${NC} — Ingest a source into the wiki"
    echo ""
    echo "Usage:"
    echo "  ./scripts/wiki-ingest.sh <source-file>"
    echo ""
    echo "Arguments:"
    echo "  <source-file>   Filename in sources/ (e.g. 'my-article.md')"
    echo ""
    echo "Examples:"
    echo "  ./scripts/wiki-ingest.sh Ejb.md"
    echo "  ./scripts/wiki-ingest.sh sources/my-article.md"
    echo ""
    echo "Steps:"
    echo "  1. Reads the source from sources/"
    echo "  2. Extracts atomic concepts (min 15)"
    echo "  3. Creates/updates concept pages in wiki/[topic]/"
    echo "  4. Creates synthesis pages"
    echo "  5. Creates source summary"
    echo "  6. Updates wiki/index.md and wiki/log.md"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

SOURCE_INPUT="$1"
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
if [ -z "$SOURCE_TITLE" ]; then
    SOURCE_TITLE="$SOURCE_NAME"
fi

echo -e "${GREEN}═══ wiki-ingest ═══${NC}"
echo -e "${CYAN}Source:${NC}     $SOURCE_NAME"
echo -e "${CYAN}Title:${NC}      $SOURCE_TITLE"
echo -e "${CYAN}AGENTS:${NC}     $AGENTS_FILE"
echo -e "${CYAN}Rules:${NC}      $INGEST_RULES"
echo ""
echo -e "${YELLOW}Starting ingest...${NC}"
echo ""

cd "$CONTENT_DIR"

START_HASH="$(git hash-object wiki/index.md 2>/dev/null || echo "none")"

opencode run "
You are a wiki maintenance agent. Read ALL of these files first:

1. $AGENTS_FILE — master behavioral rules
2. $INGEST_RULES — ingest-specific process
3. $SCHEMA_FILE — page format conventions

Now ingest the source file at $SOURCE_FILE.

Follow the process in $INGEST_RULES step by step.
Follow ALL rules in $AGENTS_FILE strictly.

Remember:
- Extract 18-20 atomic concepts minimum
- Every concept page needs TWO Graphviz diagrams (Visual Explanation + Semantic Network)
- Use deferred backlinks with '<!-- TODO: add backlink here -->' comments
- Create 1-3 synthesis pages
- Create a source summary
- Update wiki/index.md
- Append to wiki/log.md
- NEVER modify sources/
- NEVER create fewer than 15 concept/synthesis pages
"

END_HASH="$(git hash-object wiki/index.md 2>/dev/null || echo "none")"

echo ""
echo -e "${GREEN}═══ Ingest Complete ═══${NC}"

if [ "$START_HASH" != "$END_HASH" ]; then
    echo -e "${YELLOW}Summary:${NC}"
    echo "  Source: $SOURCE_NAME"
    echo "  Title:  $SOURCE_TITLE"
    echo ""
    echo -e "${YELLOW}New/updated pages in wiki/:${NC}"
    git diff --name-status HEAD 2>/dev/null | grep '^A.*wiki/' | sed 's/^A/  + Created:/' | head -20
    git diff --name-status HEAD 2>/dev/null | grep '^M.*wiki/' | sed 's/^M/  ~ Updated:/' | head -10
    echo ""
    echo -e "${YELLOW}Run ./scripts/wiki-lint.sh to resolve deferred backlinks.${NC}"
else
    echo -e "${YELLOW}No changes detected in wiki/index.md. Check wiki/log.md for details.${NC}"
fi
