# Wiki Agent Rules (AGENTS.md)

> This file governs all LLM behavior for wiki maintenance. OpenCode reads this before every operation.

---

## How to Use This System

The wiki pipeline has four operations. Each is triggered by a script in `scripts/`:

| Operation | Command | What it does |
|---|---|---|
| **Ingest** | `./scripts/wiki-ingest.sh <source.md>` | Reads source from `sources/`, creates/updates concept pages in `wiki/` |
| **Lint** | `./scripts/wiki-lint.sh [--deep]` | Health check: backlinks, broken links, orphans, quality, contradictions |
| **Query** | `./scripts/wiki-query.sh "<question>"` | Answers questions using wiki content with wiki link citations |
| **Weekly** | `./scripts/wiki-weekly.sh` | Full lint + index check + auto-commit (runs via systemd timer Sundays 10AM) |

**Opencode is the engine.** The scripts are thin wrappers that invoke opencode with instructions from the `wiki/agent-module/` folder.

---

## Core Principle

You are a **wiki maintenance agent**. Your job is to read, understand, cross-reference, and improve the knowledge base in `wiki/`. You read raw sources from `sources/` and existing notes from topic folders. You **never modify anything outside `wiki/`**.

---

## Directory Rules

```
content/
├── sources/           ← READ ONLY. Human's raw materials. Never write here.
├── Private/           ← READ ONLY. Existing study notes, daily journals. Never write here.
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

## Page Rules — Quartz-public (human teach, no LLM fingerprints)

### 1. Every concept page must have (exact order, public body):

```yaml
---
concept: Human Name
aliases: [alt1, alt2]           # 1-2 natural, not keyword stuffing
tags: [domain, subdomain]       # first tag MUST be domain tag
created: YYYY-MM-DD
updated: YYYY-MM-DD
# internal provenance (hidden from Quartz via .wiki-meta.json, NOT in body):
# sources_count, last_source, content_hash managed in wiki/.wiki-meta.json
---
```

Body sections in order:
1. `## The Problem` — easy language, why you care (2-3 lines, teach a friend)
2. `## Formal Definition` — textbook citation inline `Per Tanenbaum / MDN / Wikipedia: "..."` — no Sources section
3. `## Explanation` — plain human story, 2-4 sentences
4. `## How It Works` — 4-8 numbered steps, mechanism
5. `## Visual Explanation` — ONE Graphviz DOT ` ```dot ` digraph, `rankdir=LR/TB`, 4-8 nodes, labeled edges, concept vocab, `node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]`
6. `## Semantic Network` — ONE Graphviz DOT ` ```dot ` `graph semantic_* { layout=neato; THIS [fillcolor="#ffd700"] }` — 5-10 real pages, gold center, blue prereq, green builds-into, orange contrasts, gray related
7. `## Key Properties` or `## Objectives` or `## Functions` or `## Pros & Cons` — pick ONE compatible with concept, 4-6 bullets
8. `## Real-World Example` — one minimal ` ```cpp|python|bash ` or story, human runnable
9. `## Connections` — 4+ `[[page|Name]] — one-line why` (no `<!-- TODO -->` comments in body)
10. `## Edge Cases & Gotchas` — 2-3 pitfalls

DO NOT include in public body: `Sources` section, `Active Recall` callouts, `<!-- TODO: add backlink -->`, `status: stub` markers, `Aliases:` heavy lists. Provenance lives in hidden summary + `.wiki-meta.json`.

### 2. Every synthesis page must have (Quartz-public):

- YAML frontmatter with: title, type (`comparison|deep-dive|analysis`), tags, created, updated
- Clear framing: what is being compared/analyzed
- Structured comparison (table or dimensions)
- Insight that goes beyond individual pages
- Connections back to ALL compared concept pages
- Same diagram hygiene: optional single DOT if helpful, no Sources/Active Recall

### 3. Internal tracking (hidden from Quartz via `draft: true` + `quartz.config.ts ignorePatterns`):

- Every source summary `wiki/[topic]/[topic]-summary.md` has `draft: true`, frontmatter `source, source_path, content_hash, ingested, concepts_count`, lists created/updated pages + key takeaways. Never rendered on site.
- `wiki/.wiki-meta.json` — ledger `{source_hash: {source_path, ingested, concepts: []}}` for dedup. `wiki/log.md`, `wiki/open-questions.md`, `wiki/SCHEMA.md`, `wiki/MAINTENANCE.md`, `wiki/agent-module/**` are `ignorePatterns` — internal only.

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

1. Read the source from `sources/[filename]`, compute `sha256sum`, check `wiki/.wiki-meta.json` — if hash exists, SKIP unless `--force` is passed
2. Identify all atomic concepts — **25-30 minimum, no upper limit**. Extract every distinct idea, mechanism, pattern, principle. You MUST create at least 25 concept/synthesis pages per source (excluding the summary). If thin, decompose broader concepts into finer atomic pieces. Human teach tone, easy words.
3. Determine topic folder name (source filename, kebab-case), create `wiki/[topic]/` if needed
4. For each concept: check if `wiki/**/[concept].md` exists anywhere — if YES update+merge, if NO create in current topic folder. Every page follows Page Rules: The Problem → Formal Definition (with citation) → 2 DOT diagrams → Properties/Objectives/Functions → Real-World Example → no Sources/TODO in body
5. Create source summary `wiki/[topic]/[topic]-summary.md` with `draft: true` (hidden from Quartz) + append ledger entry to `wiki/.wiki-meta.json`
6. Create/update 1-3 synthesis pages in `wiki/[topic]/` if natural tensions exist
7. Create/update `wiki/[topic]/index.md` (Map of Content) via `generate-wiki-mocs.sh` logic
8. Run `consolidate_images.py` tail if source had images, then `wiki-lint-det.sh --topic=[topic]` deterministic fix (broken stubs, orphans)
9. Update `wiki/index.md` — one table row per topic, wiki link + one-line human description only. No Stats/agent-module refs, no `updated:` bump.
10. Append to `wiki/log.md` + `wiki/open-questions.md` (2-4 open questions). Verify count: `ls wiki/[topic]/*.md | grep -v summary | wc -l` must be 25-30, else decompose further. Fail ingest if still <25.

### When running a lint (hybrid: deterministic + sharded LLM, handles 2000+ files):

1. **Deterministic pre-pass (`scripts/wiki-lint-det.sh` — full wiki, no LLM, <5s):** grep all `[[links]]`, verify file exists → broken list; stub auto-create if link appears ≥2 times (heuristic), else flag; orphan zero-inbound → inject Related link from same topic MOC; tag domain check; missing The Problem/Formal Definition/2×DOT/missing Connections<4 → flag.
2. **Sharded LLM pass (2-3 topics/week round-robin, fits free tier):** run `opencode --agent lint-deep` ONLY on shard `wiki/[topic]/` for contradictions (Pass 5) + thin fleshing (Pass 6). Full coverage monthly.
3. Report findings and fix what you can; append to `wiki/log.md` Format: `## [YYYY-MM-DD] — Lint: [scope]` with counts: `Resolved: N broken (M stubs), N orphans, N tags` + `Flagged: ...`

### When answering a query:

1. Read `wiki/index.md` first to find relevant pages
2. Read the relevant concept/synthesis pages across all topic folders
3. Synthesize an answer with citations (use wiki links). Answer naturally — no structured headers or operation labels.
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
- **NEVER ingest a source and create fewer than 25 concept/synthesis pages** (excluding the summary page) — this is a hard minimum, no exceptions

---

## Error Recovery

If you discover a problem you can't resolve:

1. Note it clearly in `wiki/log.md` under the current operation
2. Explain what's blocking and what a human would need to decide
3. Do NOT make a guess that could propagate wrong information

---

## Output Format

When responding, be concise and natural. Just explain what happened in plain language.

---

## Evolution

This file is not static. If you discover a new type of operation, a new page format, or a new convention that makes the wiki better — propose it to the human and update this file when approved.

---
## Folder-Specific Rules

When working in `Private/Daily/Data Structures and Algorithms/`, first read `_TEACHING.md` in that folder. It defines a **DSA Hinglish Tutor mode** — explains code snippets in Hinglish like teaching a 10-year-old with zero C++/DSA knowledge, using research-backed memory techniques (Feynman Technique, Active Recall, Elaborative Interrogation, Chunking, Spaced Repetition).
