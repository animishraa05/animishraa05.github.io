#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

usage() {
    echo -e "${CYAN}wiki-find${NC} — Full-text search across all wiki pages"
    echo ""
    echo "Usage:"
    echo "  ./scripts/wiki-find.sh <query> [--topic=name] [--regex]"
    echo ""
    echo "Arguments:"
    echo "  <query>         Text or regex to search for"
    echo "  --topic=NAME    Limit search to one topic folder (e.g. --topic=cn)"
    echo "  --regex         Treat query as a regular expression"
    echo ""
    echo "Examples:"
    echo "  ./scripts/wiki-find.sh \"TCP handshake\""
    echo "  ./scripts/wiki-find.sh \"session bean\" --topic=ejb"
    echo "  ./scripts/wiki-find.sh \"O\(n\)\" --regex"
    exit 1
}

QUERY=""
TOPIC=""
REGEX=false

for arg in "$@"; do
    case "$arg" in
        --topic=*) TOPIC="${arg#--topic=}" ;;
        --regex) REGEX=true ;;
        --help|-h) usage ;;
        *) if [ -z "$QUERY" ]; then QUERY="$arg"; else echo "Unknown arg: $arg"; usage; fi ;;
    esac
done

if [ -z "$QUERY" ]; then usage; fi

SEARCH_PATH="$WIKI_DIR"
if [ -n "$TOPIC" ]; then
    SEARCH_PATH="$WIKI_DIR/$TOPIC"
    if [ ! -d "$SEARCH_PATH" ]; then
        echo "Topic not found: $TOPIC"
        echo "Available: $(ls -1d "$WIKI_DIR"/*/ | xargs -I{} basename {} | grep -v agent-module | tr '\n' ' ')"
        exit 1
    fi
fi

echo -e "${GREEN}Searching:${NC} \"$QUERY\"${TOPIC:+ in $TOPIC}"
echo ""

RG_FLAGS=(-i --line-number --no-heading --color=always -g '*.md')
if [ "$REGEX" = false ]; then RG_FLAGS+=(--fixed-strings); fi

# Exclude internal files from results
EXCLUDE_PATTERN='agent-module|SCHEMA|MAINTENANCE|log\.md|open-questions'

if command -v rg &>/dev/null; then
    rg "${RG_FLAGS[@]}" "$QUERY" "$SEARCH_PATH" 2>/dev/null \
        | grep -v -E "$EXCLUDE_PATTERN" \
        | sed "s|$WIKI_DIR/||" \
        | head -60 || echo "  No matches."
else
    grep -rn --color=always "$QUERY" "$SEARCH_PATH" --include='*.md' \
        | grep -v -E "$EXCLUDE_PATTERN" \
        | sed "s|$WIKI_DIR/||" \
        | head -60 || echo "  No matches."
fi
