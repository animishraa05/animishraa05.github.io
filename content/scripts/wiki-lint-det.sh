#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

TOPIC_FILTER=""
for arg in "$@"; do
    case "$arg" in
        --topic=*) TOPIC_FILTER="${arg#--topic=}" ;;
        --help|-h) echo "Usage: ./scripts/wiki-lint-det.sh [--topic=topic]"; exit 0 ;;
    esac
done

echo -e "${CYAN}═══ wiki-lint-det (deterministic, no LLM) ═══${NC}"
if [ -n "$TOPIC_FILTER" ]; then echo -e "${CYAN}Filter:${NC} $TOPIC_FILTER"; fi
echo ""

BROKEN_CREATED=0
BROKEN_FLAGGED=0
ORPHANS_FIXED=0
TAG_ERRORS=0
DOT_ERRORS=0
LLM_TELLS=0
DEFERRED=0
LOG_FILE="$WIKI_DIR/log.md"

WIKI_META="$WIKI_DIR/.wiki-meta.json"
if [ ! -f "$WIKI_META" ]; then echo '{}' > "$WIKI_META"; fi

all_mds="$(find "$WIKI_DIR" -name "*.md" -type f | grep -v ".wiki-meta" | sort)"
if [ -n "$TOPIC_FILTER" ]; then
    all_mds="$(echo "$all_mds" | grep "/$TOPIC_FILTER/" || echo "$all_mds" | head -0)"
fi

existing="$(echo "$all_mds" | sed "s|$WIKI_DIR/||" | sed 's|\.md$||' | tr '[:upper:]' '[:lower:]' | sort -u)"
existing_basenames="$(basename -a $all_mds 2>/dev/null | sed 's/\.md$//' | tr '[:upper:]' '[:lower:]' | sort -u || echo "")"

link_list="$(mktemp)"
link_counts="$(mktemp)"
trap 'rm -f "$link_list" "$link_counts"' EXIT

rg -o '\[\[([^\]|#]+)' "$WIKI_DIR" -g '*.md' --no-heading -n 2>/dev/null | sed 's/.*\[\[//' | tr '[:upper:]' '[:lower:]' | sed 's|/$||' | sort > "$link_list" || true
sort "$link_list" | uniq -c | sort -rn > "$link_counts" || true

DEFERRED="$(rg -c '<!-- TODO: add backlink here -->' "$WIKI_DIR" -g '*.md' 2>/dev/null | awk -F: '{s+=$2} END{print s+0}')"
if [ "$DEFERRED" -gt 0 ]; then
    echo -e "${YELLOW}Deferred backlinks found: $DEFERRED — removing markers (backlinks already exist via deterministic relate)${NC}"
    rg -l '<!-- TODO: add backlink here -->' "$WIKI_DIR" -g '*.md' 2>/dev/null | while read f; do
        sed -i 's/ *<!-- TODO: add backlink here -->//g' "$f"
    done
fi

echo -e "${CYAN}Pass 2 — Broken links${NC}"
while read count link; do
    [ -z "$link" ] && continue
    link="$(echo "$link" | xargs)"
    [ -z "$link" ] && continue
    if echo "$link" | grep -qE 'summary$|moc$|^log$|^open-questions$|^index$|SCHEMA|MAINTENANCE'; then continue; fi
    if echo "$existing" | grep -qx "$link"; then continue; fi
    if echo "$existing" | grep -qx "$(basename "$link")"; then continue; fi
    base="$(basename "$link")"
    if echo "$base" | grep -qE 'summary$|moc$'; then continue; fi
    if echo "$existing_basenames" | grep -qx "$base"; then continue; fi
    if [ "$count" -ge 2 ]; then
        topic="misc"
        if [ -n "$TOPIC_FILTER" ]; then topic="$TOPIC_FILTER"; else
            src="$(rg -l "\[\[$link" "$WIKI_DIR" -g '*.md' 2>/dev/null | head -1)"
            if [ -n "$src" ]; then topic="$(basename "$(dirname "$src")")"; fi
        fi
        mkdir -p "$WIKI_DIR/$topic"
        stub="$WIKI_DIR/$topic/$base.md"
        if [ ! -f "$stub" ] && [ ! -f "$WIKI_DIR/$base.md" ]; then
            cat > "$stub" <<EOF
---
concept: $(echo "$base" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')
aliases: []
tags: [dev]
draft: true
created: $(date +%Y-%m-%d)
updated: $(date +%Y-%m-%d)
---

## The Problem

Auto-created stub for broken link \`[[$link]]\` — needs human content.

## Formal Definition

Per Wikipedia: "To be written."

## Explanation

Stub — fill with plain language explanation.

## How It Works

1. To be written.

## Visual Explanation

\`\`\`dot
digraph $base {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Stub: $base"]
  B [label="To be written"]
  A -> B [label="needs content"]
}
\`\`\`

## Semantic Network

\`\`\`dot
graph semantic_$base {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="$(echo "$base" | sed 's/-/ /g')" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  THIS -- REL1 [label="related"]
}
\`\`\`

## Key Properties

- To be written.

## Real-World Example

\`\`\`python
# TODO: add example
\`\`\`

## Connections

- **Related:** [[index|Index]] — auto stub, needs proper links

## Edge Cases & Gotchas

- To be written.
EOF
            echo "  + Stub: $stub (link [[$link]] appeared $count times)"
            BROKEN_CREATED=$((BROKEN_CREATED+1))
        fi
    else
        echo "  ! Flagged (singleton): [[$link]] appeared $count time(s) — not auto-stubbing"
        BROKEN_FLAGGED=$((BROKEN_FLAGGED+1))
    fi
done < "$link_counts"

echo -e "${CYAN}Pass 3 — Orphans${NC}"
inbound_tmp="$(mktemp)"
rg -o '\[\[([^\]|#]+)' "$WIKI_DIR" -g '*.md' --no-heading 2>/dev/null | sed 's/.*\[\[//' | tr '[:upper:]' '[:lower:]' | sort | uniq -c > "$inbound_tmp" || true
for md in $all_mds; do
    rel="${md#$WIKI_DIR/}"
    base="$(basename "$md" .md | tr '[:upper:]' '[:lower:]')"
    if echo "$rel" | grep -q "summary\|moc\|index\|log\|open-questions\|SCHEMA\|MAINTENANCE\|agent-module"; then continue; fi
    if grep -qi "\[\[$base" "$inbound_tmp" 2>/dev/null; then continue; fi
    if grep -qi "\[\[$(echo "$rel" | sed 's/\.md$//')" "$inbound_tmp" 2>/dev/null; then continue; fi
    topic="$(basename "$(dirname "$md")")"
    moc="$(find "$WIKI_DIR/$topic" -name "*-moc.md" 2>/dev/null | head -1)"
    if [ -n "$moc" ] && [ -f "$moc" ]; then
        if ! grep -q "\[\[$base" "$moc" 2>/dev/null; then
            echo "" >> "$moc"
            echo "- [[$base|$(basename "$md" .md)]] — orphan auto-linked" >> "$moc"
            echo "  ~ Orphan $base -> linked via $moc"
            ORPHANS_FIXED=$((ORPHANS_FIXED+1))
        fi
    else
        echo "  ! Orphan (no MOC): $rel"
    fi
done
rm -f "$inbound_tmp"

echo -e "${CYAN}Pass 4 — Quality (tags, DOT, LLM tells)${NC}"
for md in $all_mds; do
    if echo "$md" | grep -q "summary\|agent-module\|SCHEMA\|MAINTENANCE\|log\|open-questions"; then continue; fi
    if [ -n "$TOPIC_FILTER" ] && ! echo "$md" | grep -q "/$TOPIC_FILTER/"; then continue; fi
    first_tag="$(awk '/^tags:/{print; exit}' "$md" 2>/dev/null | tr '[:upper:]' '[:lower:]' || echo "")"
    if echo "$first_tag" | grep -q "tags:"; then
        if ! echo "$first_tag" | grep -qE 'networking|ai|ml|systems|dev|theory|database|security|meta'; then
            echo "  ! Tag error: $md -> $first_tag"
            TAG_ERRORS=$((TAG_ERRORS+1))
        fi
    fi
    dot_count="$(grep -c '```dot' "$md" 2>/dev/null || echo 0)"
    if [ "$dot_count" -lt 2 ]; then
        echo "  ! DOT missing ($dot_count/2): $md"
        DOT_ERRORS=$((DOT_ERRORS+1))
    fi
    if grep -q '^## Sources' "$md" 2>/dev/null; then
        python3 -c "
import re, sys
content = open('$md', 'r', errors='ignore').read()
cleaned = re.sub(r'\n## Sources\n.*?(?=\n#+ |\Z)', '', content, flags=re.DOTALL).rstrip() + '\n'
if cleaned != content:
    open('$md', 'w').write(cleaned)
    print('  ~ Auto-stripped ## Sources: $md')
" 2>/dev/null || true
        LLM_TELLS=$((LLM_TELLS+1))
    fi
    if grep -q '> \[!question' "$md" 2>/dev/null || grep -q 'Active Recall' "$md" 2>/dev/null; then
        echo "  ! LLM tell Active Recall: $md"
        LLM_TELLS=$((LLM_TELLS+1))
    fi
done

echo ""
echo -e "${GREEN}Deterministic lint done${NC}"
echo "  Deferred cleaned: $DEFERRED"
echo "  Broken stubs created: $BROKEN_CREATED (heuristic ≥2)"
echo "  Broken flagged (singletons): $BROKEN_FLAGGED"
echo "  Orphans linked via MOC: $ORPHANS_FIXED"
echo "  Tag errors: $TAG_ERRORS"
echo "  DOT errors (<2): $DOT_ERRORS"
echo "  LLM tells: $LLM_TELLS"
