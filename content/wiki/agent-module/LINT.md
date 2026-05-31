# Lint Rules

> Loaded by the agent when running a wiki audit.
> Lint is the operation that resolves deferred work from ingest passes.

---

## What Lint Does

Ingest passes deliberately defer certain expensive work. Lint resolves it:

- Bidirectional link verification and repair
- Broken link detection
- Orphan page detection
- Content quality checks
- Contradiction flagging across pages

Run lint after every 2–3 ingest sessions, or when the wiki feels inconsistent.

---

## Lint Pass Order

Work in this order. Each pass builds on the previous one.

### Pass 1 — Resolve Deferred Backlinks

Search all pages for `<!-- TODO: add backlink here -->` comments.

For each one:

1. Identify the target page referenced on that line
2. Open the target page
3. Add a link back to the current page in the target's Connections section
4. Remove the `<!-- TODO: add backlink here -->` comment
5. Update `updated:` in the target's frontmatter

Log count: "Resolved N deferred backlinks"

### Pass 2 — Broken Link Scan

Scan all `[[wikilinks]]` across all pages in `wiki/`.

For each link, check if the target file exists:

- **If exists**: no action
- **If missing**: either
  - Create a stub page at the expected path (preferred if the concept is real and worth having)
  - Or remove the link and note it in `log.md` if the link was erroneous

A stub page is:

```markdown
---
concept: Concept Name
tags: [domain-tag]
status: stub
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

<!-- Stub created by lint pass. Needs content. -->

## The Problem

_To be written._

## Core Idea

_To be written._

## Connections

_To be written._
```

### Pass 3 — Orphan Detection

An orphan is a page with zero inbound links from other wiki pages.

For each orphan:

- Check if it should link to something in the index
- If it's a legitimate concept, add it to at least one related page's Connections section
- If it appears to be a duplicate, note it in `log.md` for human review — do not delete

### Pass 4 — Quality Checks

Scan every concept page for:

| Check                                      | Flag as             |
| ------------------------------------------ | ------------------- |
| Missing "The Problem" section              | `status: stub`      |
| Missing "Core Idea" section                | `status: stub`      |
| Missing Visual Explanation diagram         | needs diagram       |
| Missing Semantic Network diagram           | needs diagram       |
| Connections section has fewer than 2 links | thin connections    |
| `status: stub` but content looks complete  | promote to `draft`  |
| First YAML tag is not a domain tag         | tag error           |
| `aliases:` is empty                        | low discoverability |

Report findings grouped by type. Fix what you can automatically; flag the rest.

### Pass 5 — Contradiction Detection

Compare pages that reference the same mechanism or make factual claims.

Look for:

- Two pages that describe the same concept differently without acknowledging the difference
- A concept page that contradicts its source summary
- Claims that appear to have been superseded by a newer source (check `last_source:` and `ingested:` dates)

When a contradiction is found:

- Add a `confidence: contested` flag to the relevant page(s)
- Add a comment in the body: `<!-- CONTRADICTION: conflicts with [[other-page]] on [specific point] -->`
- Note it in `log.md` for human review

Do NOT silently resolve contradictions by picking one version. Surface them.

### Pass 6 — Thin Pages

A page is thin if any of the following apply:

- "How It Works" section is 1–2 sentences
- "Key Properties" has fewer than 3 bullet points
- "Edge Cases & Gotchas" is empty

For thin pages:

- If you have enough information from related pages and source summaries, flesh them out
- If not, set `status: stub` and note them in `log.md`

---

## Log Entry Format

```markdown
## [YYYY-MM-DD] lint | [scope: all | topic-name]

**Resolved:**

- Deferred backlinks: N
- Broken links fixed: N (M stubs created)

**Flagged for human review:**

- Orphans: [list]
- Contradictions: [list with page names]
- Tag errors: [list]

**Promoted:**

- stub → draft: [list]
- draft → complete: [list]
```

---

## What Lint Must NOT Do

- Do not delete any page, even obvious duplicates — flag for human review
- Do not resolve contradictions by choosing a version — mark `confidence: contested`
- Do not rewrite completed pages just to change style
- Do not change the meaning of a page when fixing a link
