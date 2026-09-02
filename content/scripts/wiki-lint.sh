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
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

usage() {
    echo -e "${CYAN}wiki-lint${NC} — Health check for the wiki (hybrid: deterministic + sharded LLM)"
    echo ""
    echo "Usage:"
    echo "  ./scripts/wiki-lint.sh [--deep] [--topic=topic] [--shard=N]"
    echo ""
    echo "Options:"
    echo "  --deep          Sharded LLM Pass 5-6 (contradiction + thin) on 2-3 topics"
    echo "  --topic=NAME    Limit to one topic folder (e.g. --topic=cn)"
    echo "  --shard=N       Shard index for weekly rotation (0-based)"
    echo ""
    echo "Lint passes:"
    echo "  det  Pass 1-4 deterministic (no LLM, full wiki, <5s): backlinks, broken stubs, orphans, quality"
    echo "  llm  Pass 5-6 sharded LLM (2-3 topics): contradictions, thin fleshing (--deep only)"
    exit 1
}

DEEP=false
TOPIC=""
SHARD=""
for arg in "$@"; do
    case "$arg" in
        --deep) DEEP=true ;;
        --topic=*) TOPIC="${arg#--topic=}" ;;
        --shard=*) SHARD="${arg#--shard=}" ;;
        --help|-h) usage ;;
        *) usage ;;
    esac
done

echo -e "${GREEN}═══ wiki-lint ═══${NC}"
echo -e "${CYAN}Mode:${NC}  $([ "$DEEP" = true ] && echo 'deep (det+sharded LLM)' || echo 'standard (det only)')"
if [ -n "$TOPIC" ]; then echo -e "${CYAN}Topic:${NC} $TOPIC"; fi
echo ""

cd "$CONTENT_DIR"

DET_ARGS=()
if [ -n "$TOPIC" ]; then DET_ARGS+=("--topic=$TOPIC"); fi
echo -e "${YELLOW}Step 1 — Deterministic pre-pass (no LLM)...${NC}"
bash "$SCRIPT_DIR/wiki-lint-det.sh" "${DET_ARGS[@]}" 2>&1 | tee /tmp/wiki-lint-det.log
DET_EXIT=${PIPESTATUS[0]}
if [ $DET_EXIT -ne 0 ]; then echo -e "${RED}Deterministic lint failed${NC}"; exit $DET_EXIT; fi

if [ "$DEEP" = true ]; then
    echo ""
    echo -e "${YELLOW}Step 2 — Sharded LLM deep pass (Pass 5-6)...${NC}"
    if [ -n "$TOPIC" ]; then
        SHARD_TOPICS=("$TOPIC")
    else
        mapfile -t ALL_TOPICS < <(ls -1 "$WIKI_DIR" 2>/dev/null | grep -v "^\." | while read e; do [ -d "$WIKI_DIR/$e" ] && [ "$e" != "agent-module" ] && echo "$e"; done | sort)
        TOTAL=${#ALL_TOPICS[@]}
        if [ "$TOTAL" -eq 0 ]; then echo "No topics found"; exit 0; fi
        if [ -n "$SHARD" ]; then
            START=$(( (SHARD * 2) % TOTAL ))
        else
            WEEK=$(date +%V)
            START=$(( (WEEK * 2) % TOTAL ))
        fi
        SHARD_TOPICS=("${ALL_TOPICS[@]:$START:2}")
        if [ ${#SHARD_TOPICS[@]} -eq 0 ]; then SHARD_TOPICS=("${ALL_TOPICS[@]:0:2}"); fi
        echo -e "${CYAN}Shards (${#SHARD_TOPICS[@]}/$TOTAL):${NC} ${SHARD_TOPICS[*]} (week $(date +%V), start $START)"
    fi
    for t in "${SHARD_TOPICS[@]}"; do
        if [ ! -d "$WIKI_DIR/$t" ]; then echo "Skip missing topic $t"; continue; fi
        echo -e "${YELLOW}Linting shard: $t${NC}"
        set +e
        opencode run --agent lint-deep "
You are a wiki maintenance agent. Read these files first:
1. $AGENTS_FILE
2. $LINT_RULES
3. $SCHEMA_FILE

Lint ONLY the topic shard at $WIKI_DIR/$t (2-3 topics total this run, not full wiki).
Run Pass 5 (contradiction detection) and Pass 6 (thin page fleshing) as defined in $LINT_RULES.
For contradictions: surface, do NOT silently pick one version.
For thin pages: flesh out if you have context from related pages, else flag in log.

Scope: wiki/$t/ (do not touch other topics).
After linting shard $t, append a brief shard note to wiki/log.md: ## [YYYY-MM-DD] — Lint: shard $t — Contradictions: N, Thin flagged: N
"
        LLM_EXIT=$?
        set -e
        if [ $LLM_EXIT -ne 0 ]; then echo -e "${YELLOW}Shard $t LLM lint exited $LLM_EXIT (quota? will retry next week)${NC}"; fi
    done
    echo -e "${GREEN}Sharded deep lint done.${NC}"
else
    echo -e "${CYAN}Tip: run with --deep for contradiction/thin checks on 2 shards${NC}"
fi

echo ""
echo -e "${GREEN}═══ Lint Complete ═══${NC}"
echo -e "${YELLOW}Det log: /tmp/wiki-lint-det.log  |  Full log: wiki/log.md${NC}"
