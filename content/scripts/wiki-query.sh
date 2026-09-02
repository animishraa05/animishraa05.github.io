#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"
AGENTS_FILE="$CONTENT_DIR/AGENTS.md"
QUERY_RULES="$WIKI_DIR/agent-module/QUERY.md"
SCHEMA_FILE="$WIKI_DIR/agent-module/SCHEMA.md"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

usage() {
    echo -e "${CYAN}wiki-query${NC} — Ask a question against the wiki"
    echo ""
    echo "Usage:"
    echo "  ./scripts/wiki-query.sh \"<your question>\""
    echo ""
    echo "Examples:"
    echo "  ./scripts/wiki-query.sh \"What's the difference between packet and circuit switching?\""
    echo "  ./scripts/wiki-query.sh \"Compare stateful and stateless session beans\""
    echo "  ./scripts/wiki-query.sh --save \"Compare EJB and Spring approaches to transactions\""
    echo ""
    echo "Options:"
    echo "  --save     Save the answer as a synthesis page in the wiki"
    exit 1
}

SAVE=false
ARGS=()
for arg in "$@"; do
    if [ "$arg" = "--save" ]; then
        SAVE=true
    else
        ARGS+=("$arg")
    fi
done

if [ ${#ARGS[@]} -lt 1 ]; then
    usage
fi

QUESTION="${ARGS[*]}"

echo -e "${GREEN}═══ wiki-query ═══${NC}"
echo -e "${CYAN}Question:${NC} $QUESTION"
echo ""

SAVE_INSTRUCTION=""
if [ "$SAVE" = true ]; then
    SAVE_INSTRUCTION="If the answer reveals a new insight, comparison, or synthesis not yet in the wiki, create a new synthesis page in the most relevant topic folder and update wiki/index.md and wiki/log.md. Use the Synthesis Page template."
fi

cd "$CONTENT_DIR"

opencode run --agent query "
You are a wiki maintenance agent. Read these files first:

1. $AGENTS_FILE — master behavioral rules
2. $QUERY_RULES — query-specific process
3. $SCHEMA_FILE — page format conventions

Now answer this question using the wiki:

\"$QUESTION\"

Follow the QUERY.md process step by step:
1. Read wiki/index.md first to find relevant pages
2. Read every relevant concept, synthesis, and source summary page fully
3. Synthesize an answer with [[wikilinks]] as citations (Quartz-clean, human teach tone)
4. Flag any gaps the wiki can't answer → append to wiki/open-questions.md

$SAVE_INSTRUCTION

Use this output format:

### Operation: query
### Question: $QUESTION

[Answer in prose with wiki links]

**Sources used:**
- [[page-name|Page Name]] — contribution

**Gaps / open questions added:**
- [list or 'none']
"
