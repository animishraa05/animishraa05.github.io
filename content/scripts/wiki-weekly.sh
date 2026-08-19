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
NC='\033[0m'
BOLD='\033[1m'

echo -e "${GREEN}${BOLD}═══ Weekly Wiki Maintenance ═══${NC}"
echo -e "${CYAN}Date:${NC}  $(date '+%Y-%m-%d %H:%M')"
echo ""

UNINGESTED=()

# Step 0: Check for uningested sources
echo -e "${YELLOW}Step 0: Checking for uningested sources...${NC}"
while IFS= read -r src; do
    src_name="$(basename "$src")"
    topic_folder="${src_name%.*}"
    topic_folder_lc="$(echo "$topic_folder" | tr '[:upper:]' '[:lower:]')"

    if [ ! -d "$WIKI_DIR/$topic_folder_lc" ]; then
        UNINGESTED+=("$src_name")
    fi
done < <(find "$CONTENT_DIR/sources" -maxdepth 1 -type f 2>/dev/null)

if [ ${#UNINGESTED[@]} -gt 0 ]; then
    echo -e "${RED}Found ${#UNINGESTED[@]} uningested source(s):${NC}"
    for s in "${UNINGESTED[@]}"; do
        echo "  - $s"
    done
    echo ""
else
    echo -e "${GREEN}All sources have been ingested.${NC}"
fi

cd "$CONTENT_DIR"

# Step 1: Lint
echo -e "${YELLOW}Step 1: Running lint...${NC}"
opencode run "
You are a wiki maintenance agent. Read these files first:
1. $AGENTS_FILE
2. $LINT_RULES
3. $SCHEMA_FILE

Lint the wiki at $WIKI_DIR. Run ALL 6 passes including deep analysis (contradiction detection and thin page analysis).

After linting, append to wiki/log.md with the results.
"

echo ""
echo -e "${GREEN}Lint complete.${NC}"

# Step 2: Index rebuild check
echo ""
echo -e "${YELLOW}Step 2: Checking index consistency...${NC}"
opencode run "
You are a wiki maintenance agent. Read these files:
1. $AGENTS_FILE
2. $SCHEMA_FILE

Review wiki/index.md at $WIKI_DIR/index.md. Does it accurately reflect all pages in the wiki?
If not, update it. If yes, do nothing.
"

echo ""
echo -e "${GREEN}Index check complete.${NC}"

# Step 3: Auto-commit to git
echo ""
echo -e "${YELLOW}Step 3: Checking for changes to commit...${NC}"
if git diff --quiet wiki/ 2>/dev/null; then
    echo -e "${GREEN}No changes to commit.${NC}"
else
    changed_files="$(git diff --name-only wiki/ | wc -l)"
    echo -e "${CYAN}$changed_files file(s) changed.${NC}"
    git add wiki/ && git commit -m "wiki: weekly maintenance $(date '+%Y-%m-%d')"
    echo -e "${GREEN}Committed.${NC}"
fi

echo ""
echo -e "${GREEN}${BOLD}═══ Weekly maintenance complete ═══${NC}"

if [ ${#UNINGESTED[@]} -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}Reminder:${NC} Ingest these unprocessed sources:"
    for s in "${UNINGESTED[@]}"; do
        echo "  ./scripts/wiki-ingest.sh \"$s\""
    done
fi
