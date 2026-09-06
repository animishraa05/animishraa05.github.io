#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"
INDEX="$WIKI_DIR/index.md"

echo "Rebuilding wiki/index.md deterministically..."

existing_topics="$(ls -1d "$WIKI_DIR"/*/ 2>/dev/null | xargs -I{} basename {} | grep -v "agent-module" | sort)"

tmp="$(mktemp)"
cat > "$tmp" <<'HDR'
---
title: Wiki Index
tags: [meta, index]
---

> knowledge base.

---
HDR

emit_section() {
    local header="$1"
    shift
    local topics=("$@")
    echo "" >> "$tmp"
    echo "## $header" >> "$tmp"
    echo "" >> "$tmp"
    echo "| Topic | Description |" >> "$tmp"
    echo "| --- | --- |" >> "$tmp"
    for t in "${topics[@]}"; do
        moc_desc=""
        if [ -f "$WIKI_DIR/$t/index.md" ]; then
            moc_desc="$(grep -m1 "^> Map" "$WIKI_DIR/$t/index.md" 2>/dev/null | sed 's/^> //' | head -c 120 || echo "")"
        fi
        summary_desc=""
        if [ -f "$WIKI_DIR/$t/$t-summary.md" ]; then
            summary_desc="$(grep -m1 "^source:" "$WIKI_DIR/$t/$t-summary.md" 2>/dev/null | sed 's/source:\s*//' | head -c 120 || echo "")"
        fi
        desc="${moc_desc:-${summary_desc:-$t}}"
        count="$(ls -1 "$WIKI_DIR/$t"/*.md 2>/dev/null | grep -v summary | grep -v 'index\.md' | wc -l | tr -d ' ')"
        echo "| [[$t/index\|${t}]] | $desc ($count pages) |" >> "$tmp"
    done
}

emit_section "Topics" $existing_topics

echo "" >> "$tmp"
echo "---" >> "$tmp"
echo "" >> "$tmp"
echo "## Meta" >> "$tmp"
echo "" >> "$tmp"
echo "- [[SCHEMA|Wiki Schema]] — page format conventions" >> "$tmp"
echo "- [[MAINTENANCE|Maintenance Guide]] — how to use the wiki scripts" >> "$tmp"
echo "- [[log|Change Log]] — operation history" >> "$tmp"
echo "- [[open-questions|Open Questions]] — what the wiki doesn't know yet" >> "$tmp"

if cmp -s "$tmp" "$INDEX"; then
    echo "Index unchanged."
    rm "$tmp"
else
    mv "$tmp" "$INDEX"
    echo "Index rebuilt: $INDEX"
fi
