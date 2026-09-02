#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
WIKI_DIR="$CONTENT_DIR/wiki"

TOPIC_FILTER=""
for arg in "$@"; do
    case "$arg" in
        --topic=*) TOPIC_FILTER="${arg#--topic=}" ;;
        --help|-h) echo "Usage: ./scripts/generate-wiki-mocs.sh [--topic=topic]"; exit 0 ;;
    esac
done

generate_moc() {
    local topic="$1"
    local dir="$WIKI_DIR/$topic"
    local moc="$dir/$topic-moc.md"
    local title
    title="$(echo "$topic" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')"
    local date_now
    date_now="$(date +%Y-%m-%d)"
    local concepts
    concepts="$(ls -1 "$dir"/*.md 2>/dev/null | grep -v summary | grep -v moc | sort || true)"
    local count
    count="$(echo "$concepts" | grep -c "\.md" || echo 0)"

    local syntheses=""
    local core=""
    for f in $concepts; do
        b="$(basename "$f" .md)"
        t="$(grep -m1 '^title:' "$f" 2>/dev/null || echo "")"
        if echo "$t" | grep -q "type:"; then
            syntheses="$syntheses
- [[$b|$(echo "$b" | sed 's/-/ /g')]] — comparison"
        else
            cname="$(grep -m1 '^concept:' "$f" 2>/dev/null | sed 's/concept:\s*//' | tr -d '"' || echo "$b")"
            core="$core
- [[$b|$cname]] — concept"
        fi
    done

    cat > "$moc" <<EOF
---
title: $title — Map of Content
type: moc
tags: [meta, $topic]
created: $(grep -m1 '^created:' "$moc" 2>/dev/null | awk '{print $2}' || echo "$date_now")
updated: $date_now
---

> Map of Content for **$title** — ${count} concepts. Start here to navigate $topic.

## Core Concepts

$core

## Mechanisms & How Things Work

_Auto-generated — edit to curate. Pages that explain processes/flows._

## Comparisons & Tradeoffs

$([ -n "$syntheses" ] && echo "$syntheses" || echo "- _(No synthesis yet — create via ingest or query --save)_")

## Sources Ingested

- [[$topic-summary|Source Summary]] (hidden, draft:true) — ingested via wiki/.wiki-meta.json

## Suggested Reading Order

1. Browse Core Concepts above — start with most-linked page
2. Follow Connections sections for dense graph traversal
EOF
    echo "  + MOC: $moc ($count concepts)"
}

if [ -n "$TOPIC_FILTER" ]; then
    if [ -d "$WIKI_DIR/$TOPIC_FILTER" ]; then
        generate_moc "$TOPIC_FILTER"
    else
        echo "Topic not found: $TOPIC_FILTER" >&2; exit 1
    fi
else
    for d in "$WIKI_DIR"/*/; do
        topic="$(basename "$d")"
        [ "$topic" = "agent-module" ] && continue
        [ -f "$WIKI_DIR/$topic/$topic-moc.md" ] && continue
        if ls "$d"*.md >/dev/null 2>&1; then
            generate_moc "$topic"
        fi
    done
fi
