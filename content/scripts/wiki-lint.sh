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
NC='\033[0m'

usage() {
    echo -e "${CYAN}wiki-lint${NC} — Health check for the wiki"
    echo ""
    echo "Usage:"
    echo "  ./scripts/wiki-lint.sh [--deep]"
    echo ""
    echo "Options:"
    echo "  --deep    Run contradiction detection and thin page analysis (Pass 5-6)"
    echo ""
    echo "Lint passes:"
    echo "  1. Resolve deferred backlinks (TODO comments)"
    echo "  2. Broken link scan + stub creation"
    echo "  3. Orphan page detection"
    echo "  4. Quality checks (missing sections, tags, etc)"
    echo "  5. Contradiction detection (--deep only)"
    echo "  6. Thin page analysis (--deep only)"
    exit 1
}

DEEP=false
if [ $# -gt 0 ]; then
    if [ "$1" = "--deep" ]; then
        DEEP=true
    else
        usage
    fi
fi

echo -e "${GREEN}═══ wiki-lint ═══${NC}"
echo -e "${CYAN}Mode:${NC}  $([ "$DEEP" = true ] && echo 'deep' || echo 'standard')"
echo ""

if [ "$DEEP" = true ]; then
    INSTRUCTION="Run ALL 6 lint passes as defined in $LINT_RULES."
else
    INSTRUCTION="Run passes 1-4 only (deferred backlinks, broken link scan, orphan detection, quality checks). Skip passes 5-6."
fi

cd "$CONTENT_DIR"

opencode run "
You are a wiki maintenance agent. Read ALL of these files first:

1. $AGENTS_FILE — master behavioral rules
2. $LINT_RULES — lint-specific process
3. $SCHEMA_FILE — page format conventions

Now lint the wiki at $WIKI_DIR.

$INSTRUCTION

Follow the process in $LINT_RULES step by step.
Follow ALL rules in $AGENTS_FILE strictly.

After linting, append a log entry to wiki/log.md in the format:
## [YYYY-MM-DD] lint | [scope: all]

**Resolved:**
- Deferred backlinks: N
- Broken links fixed: N (M stubs created)
- [other fixes]

**Flagged for human review:**
- Orphans: [list]
- Contradictions: [list]
- Tag errors: [list]
"

echo ""
echo -e "${GREEN}═══ Lint Complete ═══${NC}"
echo -e "${YELLOW}Check wiki/log.md for the full report.${NC}"
