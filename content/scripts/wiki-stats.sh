#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${GREEN}${BOLD}═══ Wiki Stats ═══${NC}"
echo -e "${CYAN}Date:${NC} $(date '+%Y-%m-%d %H:%M')"
echo ""

# --- Topic count ---
TOPICS="$(ls -1d "$WIKI_DIR"/*/ 2>/dev/null | grep -v "agent-module" | wc -l | tr -d ' ')"
echo -e "${CYAN}Topics:${NC} $TOPICS"

# --- Page counts ---
ALL_MD="$(find "$WIKI_DIR" -name '*.md' -not -path '*/agent-module/*' | sort)"
TOTAL="$(echo "$ALL_MD" | wc -l | tr -d ' ')"
SUMMARY_COUNT="$(echo "$ALL_MD" | grep -c '\-summary\.md' || true)"
MOC_COUNT="$(echo "$ALL_MD" | grep -c '\-moc\.md' || true)"
CONCEPT_COUNT=$(( TOTAL - SUMMARY_COUNT - MOC_COUNT ))

echo -e "${CYAN}Pages:${NC}  $TOTAL total  ($CONCEPT_COUNT concept/synthesis, $MOC_COUNT MOCs, $SUMMARY_COUNT summaries)"

# --- Drafts / stubs ---
DRAFTS="$(grep -rl '^draft: true' "$WIKI_DIR" --include='*.md' 2>/dev/null | grep -v 'agent-module\|summary' | wc -l | tr -d ' ')"
STUBS="$(grep -rl 'status: stub' "$WIKI_DIR" --include='*.md' 2>/dev/null | wc -l | tr -d ' ')"
AUTO_STUBS="$(grep -rl 'Auto-created stub' "$WIKI_DIR" --include='*.md' 2>/dev/null | wc -l | tr -d ' ')"
echo -e "${CYAN}Drafts:${NC} $DRAFTS hidden (draft:true)  |  ${CYAN}Stubs:${NC} $STUBS status:stub  |  ${CYAN}Auto-stubs:${NC} $AUTO_STUBS"

# --- DOT diagram coverage ---
MISSING_DOT=0
CHECKED=0
while IFS= read -r md; do
    case "$md" in
        *summary*|*-moc*|*agent-module*|*SCHEMA*|*MAINTENANCE*|*log.md*|*open-questions*|*index.md*) continue ;;
        "") continue ;;
    esac
    CHECKED=$((CHECKED+1))
    dot_count="$(grep -c '```dot' "$md" 2>/dev/null || true)"
    dot_count="${dot_count//[^0-9]/}"
    dot_count="${dot_count:-0}"
    if [ "$dot_count" -lt 2 ] 2>/dev/null; then
        MISSING_DOT=$((MISSING_DOT+1))
    fi
done <<< "$ALL_MD"
echo -e "${CYAN}DOT coverage:${NC} $((CHECKED - MISSING_DOT))/$CHECKED pages have 2+ diagrams  |  ${YELLOW}$MISSING_DOT missing${NC}"

# --- Broken links (fast grep count) ---
BROKEN=0
if command -v rg &>/dev/null; then
    existing_bases="$(find "$WIKI_DIR" -name '*.md' | sed 's|.*/||' | sed 's/\.md$//' | tr '[:upper:]' '[:lower:]' | sort -u)"
    all_links="$(rg -oh '\[\[([^\]|#\\]+)' "$WIKI_DIR" -g '*.md' 2>/dev/null | sed 's/\[\[//' | awk -F'/' '{print $NF}' | tr '[:upper:]' '[:lower:]' | sort -u)"
    BROKEN=$(comm -23 <(echo "$all_links" | sort) <(echo "$existing_bases" | sort) | wc -l | tr -d ' ')
fi
if [ "$BROKEN" -gt 0 ]; then
    echo -e "${CYAN}Broken links:${NC} ${RED}~$BROKEN unique targets missing${NC}  (run wiki-lint.sh to fix)"
else
    echo -e "${CYAN}Broken links:${NC} ${GREEN}none detected${NC}"
fi

# --- LLM tells ---
LLM_TELLS="$(grep -rl '^## Sources\|Active Recall\|ChatGPT\|Gemini conversation\|OpenAI' "$WIKI_DIR" --include='*.md' 2>/dev/null | grep -v 'agent-module\|MAINTENANCE\|log.md\|open-questions' | wc -l | tr -d ' ')"
if [ "$LLM_TELLS" -gt 0 ]; then
    echo -e "${CYAN}LLM tells:${NC} ${RED}$LLM_TELLS files${NC}  (run wiki-lint.sh to auto-strip)"
else
    echo -e "${CYAN}LLM tells:${NC} ${GREEN}none${NC}"
fi

# --- Meta ledger ---
META="$WIKI_DIR/.wiki-meta.json"
if [ -f "$META" ]; then
    INGESTED="$(python3 -c "import json; d=json.load(open('$META')); print(len(d))" 2>/dev/null || echo '?')"
    echo -e "${CYAN}Ingested sources:${NC} $INGESTED (tracked in .wiki-meta.json)"
else
    echo -e "${CYAN}Ingested sources:${NC} ${RED}.wiki-meta.json missing${NC}"
fi

# --- Uningested sources ---
UNINGESTED=()
if [ -f "$META" ]; then
    while IFS= read -r src; do
        src_name="$(basename "$src")"
        h="$(sha256sum "$src" 2>/dev/null | awk '{print $1}')"
        if grep -q "$h" "$META" 2>/dev/null; then continue; fi
        topic_lc="$(echo "${src_name%.*}" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g')"
        if [ ! -d "$WIKI_DIR/$topic_lc" ]; then
            UNINGESTED+=("$src_name")
        fi
    done < <(find "$CONTENT_DIR/sources" -maxdepth 1 -type f 2>/dev/null)
fi
if [ ${#UNINGESTED[@]} -gt 0 ]; then
    echo -e "${CYAN}Uningested:${NC} ${RED}${#UNINGESTED[@]} source(s) not yet ingested:${NC}"
    for s in "${UNINGESTED[@]}"; do echo "    - $s"; done
else
    echo -e "${CYAN}Uningested:${NC} ${GREEN}none${NC}"
fi

# --- Git info ---
echo ""
echo -e "${CYAN}Last commit:${NC} $(git -C "$CONTENT_DIR" log -1 --format='%ar — %s' 2>/dev/null || echo 'not a git repo')"
DIRTY="$(git -C "$CONTENT_DIR" diff --name-only wiki/ 2>/dev/null | wc -l | tr -d ' ')"
if [ "$DIRTY" -gt 0 ]; then
    echo -e "${CYAN}Uncommitted:${NC} ${YELLOW}$DIRTY file(s) changed in wiki/${NC}"
else
    echo -e "${CYAN}Uncommitted:${NC} ${GREEN}clean${NC}"
fi

# --- Per-topic summary ---
echo ""
echo -e "${BOLD}Per-topic page counts:${NC}"
printf "  %-40s %s\n" "Topic" "Concept pages"
printf "  %-40s %s\n" "─────────────────────────────────────" "─────────────"
for dir in "$WIKI_DIR"/*/; do
    t="$(basename "$dir")"
    [ "$t" = "agent-module" ] && continue
    count="$(ls -1 "$dir"*.md 2>/dev/null | grep -v 'summary\|-moc' | wc -l | tr -d ' ')"
    printf "  %-40s %s\n" "$t" "$count"
done

echo ""
echo -e "${GREEN}${BOLD}═══════════════════${NC}"
