# Wiki Agent Rules (AGENTS.md)

> This file governs all LLM behavior for wiki maintenance. OpenCode reads this before every operation.

---

## Core Principle

You are a **wiki maintenance agent**. Your job is to read, understand, cross-reference, and improve the knowledge base in `wiki/`. You read raw sources from `sources/` and existing notes from topic folders. You **never modify anything outside `wiki/`**.

---

## Directory Rules

```
content/
├── sources/           ← READ ONLY. Human's raw materials. Never write here.
├── [topic-folders]/   ← READ ONLY. Existing study notes. Never write here.
└── wiki/              ← YOUR DOMAIN. Create, update, link everything here.
    ├── SCHEMA.md      ← Page format conventions (read this for templates)
    ├── index.md       ← Catalog of all wiki content (update on every change)
    ├── log.md         ← Append-only operation log (append on every change)
    ├── MAINTENANCE.md ← Human's maintenance guide (reference only, don't edit)
    │
    ├── ejb/           ← Topic folder: everything from the EJB source
    │   ├── stateless-session-bean.md    ← concept
    │   ├── activation.md                ← concept
    │   ├── cmp-vs-bmp.md                ← synthesis
    │   └── ejb-summary.md               ← source summary
    │
    ├── networking/      ← Topic folder: everything from networking sources
    │   ├── packet-switching.md
    │   └── ...
    │
    └── theory-of-computation/  ← Topic folder: everything from ToC sources
        ├── turing-machine.md
        └── ...
```

### Topic Folder Rule

- When you ingest a source, create a folder in `wiki/` named after the source (kebab-case, no extension)
- ALL pages from that source go in this one folder: concepts, syntheses, source summaries
- No nested `concepts/` or `syntheses/` subfolders — everything is flat within the topic folder
- If the topic folder already exists, add new pages to it — don't create a duplicate
- If the source covers an existing topic (e.g., another EJB article → `wiki/ejb/`), add to the existing folder

---

## Page Rules

### 1. Every concept page must have:

- YAML frontmatter with: concept, aliases, tags, sources_count, last_source, created, updated
- "The Problem" section — why this concept exists
- "Core Idea" section — minimum viable definition
- "How It Works" section — mechanism, not just description
- "Visual Explanation" section — a Graphviz (DOT) diagram explaining the concept's structure, flow, or relationships. Use ` ```dot ` blocks.
- "Key Properties" section — bullet points
- "Connections" section — wiki links to related concepts (4+ minimum)
- "Edge Cases & Gotchas" section — where this fails, common misconceptions
- "Sources" section — wiki links to source summaries

### 2. Every synthesis page must have:

- YAML frontmatter with: title, type, tags, created, updated
- Clear framing: what is being compared/analyzed
- Structured comparison (not just descriptions side by side)
- Insights that go beyond individual concept pages
- Connections back to concept pages

### 3. Every source summary must have:

- YAML frontmatter with: source, source_path, content_hash, ingested, concepts_count
- What concepts were extracted
- Which wiki pages were created or updated
- Key takeaways from this source
- Open questions this source raises (add to wiki/open-questions.md)

---

## Cross-Reference Rules

### Bidirectional linking is mandatory

If page A links to page B, page B must mention page A in its Connections section.

### Connection types (use these labels):

- **Built from:** prerequisite concepts this one depends on
- **Builds into:** concepts that use this one
- **Contrasts with:** similar but different concepts
- **Related:** adjacent concepts, same domain, neither prerequisite nor application

### Minimum connections per page

- Concept pages: 4+ connections
- Synthesis pages: links to ALL concept pages it compares
- Source summaries: links to all concept pages it created/updated

### Link format

Use Obsidian wiki links: `[[filename-without-ext|Display Name]]`

Obsidian resolves links across topic folders automatically.

---

## Naming Conventions

- Concept pages: `wiki/[topic-folder]/kebab-case-concept.md`
- Synthesis pages: `wiki/[topic-folder]/kebab-case-comparison.md`
- Source summaries: `wiki/[topic-folder]/topic-name-summary.md`
- Always lowercase, hyphens for spaces, no underscores in filenames
- Topic folder names: kebab-case, short but descriptive (`ejb`, not `ejb-source-from-my-notes`)

---

## Tag Rules

The FIRST tag must ALWAYS be a domain tag. Use ONLY these:
`networking`, `ai`, `ml`, `systems`, `dev`, `theory`, `database`, `security`, `meta`

Second tag = specific subdomain:

```yaml
tags: [dev, ejb]              ← good
tags: [theory, automata]      ← good
tags: [networking, switching] ← good
tags: [ejb, session-bean]     ← WRONG — ejb is not a domain tag
```

---

## Update Rules

### When ingesting a new source:

1. Read the source from `sources/[filename]`
2. Identify all atomic concepts — **no upper limit, lower limit is 15**. Extract every distinct idea, mechanism, pattern, or principle that appears meaningfully in the source. You MUST create at least 15 concept/synthesis pages per source (excluding the summary page). If the source is thin, decompose broader concepts into finer atomic pieces to meet the minimum.
3. Determine the topic folder name (from source filename, kebab-case)
4. Create the topic folder in `wiki/` if it doesn't exist
5. For each concept:
   - Check if `wiki/[topic-folder]/[concept].md` exists (in THIS folder or ANY folder)
   - If YES: update it — merge new info, flag contradictions, strengthen
   - If NO: create it in the current topic folder
6. Create a source summary in `wiki/[topic-folder]/`
7. Create/update synthesis pages in `wiki/[topic-folder]/`
8. Update `wiki/index.md` with new concepts and one-line summaries
9. Append to `wiki/log.md` with format: `## [YYYY-MM-DD] ingest | Source Title`
10. **Verify the count**: Before finishing, confirm the topic folder has at least 15 concept/synthesis files (excluding the summary). If not, decompose further until the minimum is met.

### When running a lint:

1. Check ALL topic folders in `wiki/` for:
   - Orphan pages (zero inbound links)
   - Broken wiki links
   - Contradictions between pages (even across topic folders)
   - Stale claims superseded by newer info
   - Thin pages (1-2 lines that need fleshing out)
   - Missing Connections sections
   - Wrong tags (first tag must be a domain tag)
2. Report findings and fix what you can
3. Append to `wiki/log.md` with format: `## [YYYY-MM-DD] lint | Findings`

### When answering a query:

1. Read `wiki/index.md` first to find relevant pages
2. Read the relevant concept/synthesis pages across all topic folders
3. Synthesize an answer with citations (use wiki links)
4. If the answer creates a new insight, save it as a synthesis page in the most relevant topic folder

---

## What You Must NOT Do

- **NEVER modify `sources/`** — these are the human's raw materials, read only
- **NEVER modify files outside `wiki/`** — existing notes are immutable
- **NEVER create a concept page without checking if one exists first**
- **NEVER leave a broken wiki link** — if you create a link, create the target page
- **NEVER write vague Connections** — explain the specific relationship
- **NEVER skip "The Problem" section** — every concept needs its why
- **NEVER delete a concept page** — update or mark superseded, never delete
- **NEVER update index.md or log.md without also making the actual content changes**
- **NEVER use non-domain tags as the first tag**
- **NEVER ingest a source and create fewer than 15 concept/synthesis pages** (excluding the summary page) — this is a hard minimum, no exceptions

---

## Error Recovery

If you discover a problem you can't resolve:

1. Note it clearly in `wiki/log.md` under the current operation
2. Explain what's blocking and what a human would need to decide
3. Do NOT make a guess that could propagate wrong information

---

## Output Format

When responding to the human, use this format:

```
### Operation: [ingest | lint | query]
### Source/Target: [what you worked on]

**Changes made:**
- Created: [list of new files]
- Updated: [list of modified files with brief why]
- Linked: [new cross-references added]

**Findings (if lint):**
- [list of issues found and fixed/flagged]
```

---

## Evolution

This file is not static. If you discover a new type of operation, a new page format, or a new convention that makes the wiki better — propose it to the human and update this file when approved.
