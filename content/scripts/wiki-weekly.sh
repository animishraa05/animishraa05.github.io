#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"
AGENTS_FILE="$CONTENT_DIR/AGENTS.md"
LINT_RULES="$WIKI_DIR/agent-module/LINT.md"
SCHEMA_FILE="$WIKI_DIR/agent-module/SCHEMA.md"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${GREEN}${BOLD}═══ Weekly Wiki Maintenance ═══${NC}"
echo -e "${CYAN}Date:${NC}  $(date '+%Y-%m-%d %H:%M')"
echo ""

UNINGESTED=()

echo -e "${YELLOW}Step 0: Uningested sources (hash-aware)...${NC}"
META_FILE="$WIKI_DIR/.wiki-meta.json"
if [ ! -f "$META_FILE" ]; then echo '{}' > "$META_FILE"; fi
while IFS= read -r src; do
    src_name="$(basename "$src")"
    h="$(sha256sum "$src" 2>/dev/null | awk '{print $1}')"
    if grep -q "$h" "$META_FILE" 2>/dev/null; then continue; fi
    topic_folder="${src_name%.*}"
    topic_folder_lc="$(echo "$topic_folder" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g')"
    if [ ! -d "$WIKI_DIR/$topic_folder_lc" ]; then
        UNINGESTED+=("$src_name")
    fi
done < <(find "$CONTENT_DIR/sources" -maxdepth 1 -type f 2>/dev/null)

if [ ${#UNINGESTED[@]} -gt 0 ]; then
    echo -e "${RED}Found ${#UNINGESTED[@]} uningested source(s):${NC}"
    for s in "${UNINGESTED[@]}"; do echo "  - $s"; done
    echo ""
else
    echo -e "${GREEN}All sources have been ingested (hash-checked).${NC}"
fi

cd "$CONTENT_DIR"

echo -e "${YELLOW}Step 1: Deterministic lint (full wiki, no LLM)...${NC}"
bash "$SCRIPT_DIR/wiki-lint-det.sh" 2>&1 | tee /tmp/wiki-weekly-det.log
echo -e "${GREEN}Deterministic lint done.${NC}"

echo ""
echo -e "${YELLOW}Step 2: Sharded deep lint (2 topics, lint-deep agent)...${NC}"
bash "$SCRIPT_DIR/wiki-lint.sh" --deep 2>&1 | tee /tmp/wiki-weekly-deep.log || echo -e "${YELLOW}Deep lint hit quota — will retry next week${NC}"

echo ""
echo -e "${YELLOW}Step 3: MOCs + index consistency...${NC}"
bash "$SCRIPT_DIR/generate-wiki-mocs.sh" 2>&1 | tee /tmp/wiki-weekly-mocs.log || true
if [ -f "$SCRIPT_DIR/wiki-rebuild-index.sh" ]; then
    bash "$SCRIPT_DIR/wiki-rebuild-index.sh" 2>&1 | tee /tmp/wiki-weekly-index.log || true
else
    echo -e "${YELLOW}Index check: running deterministic index check...${NC}"
    topic_count="$(ls -1d "$WIKI_DIR"/*/ 2>/dev/null | wc -l)"
    echo "Topics: $topic_count"
fi
echo -e "${GREEN}MOC/index check done.${NC}"

echo ""
echo -e "${YELLOW}Step 4: Changes to commit...${NC}"
if git diff --quiet wiki/ 2>/dev/null && git diff --cached --quiet 2>/dev/null; then
    echo -e "${GREEN}No changes to commit.${NC}"
else
    changed_files="$(git diff --name-only wiki/ 2>/dev/null | wc -l)"
    staged_files="$(git diff --cached --name-only 2>/dev/null | wc -l)"
    echo -e "${CYAN}$changed_files file(s) changed (+$staged_files staged).${NC}"
    git add wiki/ "$META_FILE" 2>/dev/null || git add wiki/ 2>/dev/null || true
    if git diff --cached --quiet 2>/dev/null; then
        echo -e "${YELLOW}Nothing staged after add — skipping commit${NC}"
    else
        git commit -m "wiki: weekly maintenance $(date '+%Y-%m-%d') — det + sharded lint + MOC/index" || echo -e "${YELLOW}Commit failed (nothing to commit?)${NC}"
        echo -e "${GREEN}Committed.${NC}"
    fi
fi

echo ""
echo -e "${GREEN}${BOLD}═══ Weekly maintenance complete ═══${NC}"

if [ ${#UNINGESTED[@]} -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}Reminder:${NC} Ingest these unprocessed sources:"
    for s in "${UNINGESTED[@]}"; do echo "  ./scripts/wiki-ingest.sh \"$s\""; done
fi
echo -e "${CYAN}Logs:${NC} /tmp/wiki-weekly-{det,deep,mocs,index}.log  + wiki/log.md"
