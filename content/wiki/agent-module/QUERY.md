# Query Rules

> Loaded by the agent when answering a question using wiki content.

---

## Query Process

### Step 1 — Find Relevant Pages

Read `wiki/index.md` first. Scan for pages whose concept, tags, or summary match the question.

Do not guess at filenames. Use the index.

### Step 2 — Read the Pages

Open every relevant concept, synthesis, and source summary page. Read them fully.

If a page links to another page that also seems relevant, read that too — one hop is usually enough.

### Step 3 — Synthesize

Answer the question in your own words, citing wiki pages with `[[wikilinks]]`.

Use this citation pattern in prose:

> As described in [[stateless-session-bean|Stateless Session Beans]], the container manages pooling...

### Step 4 — Capture New Insights

If synthesizing across pages generates an insight that isn't in any existing page:

- Create a new synthesis page in the most relevant topic folder
- Use the Synthesis Page template from `SCHEMA.md`
- Add it to `wiki/index.md`
- Append to `wiki/log.md`

### Step 5 — Flag Gaps

If the question cannot be fully answered from existing wiki content:

- Note the gap explicitly in your response
- Add a research question to `wiki/open-questions.md`

---

## Response Format for Queries

Answer directly in prose with [[wikilinks]] as citations. No headers or structured operation labels needed. If the answer creates a new insight, save it as a synthesis page and note it in the log.

---

## What Query Must NOT Do

- Do not invent information not present in the wiki
- Do not modify existing pages to fit the answer (create synthesis instead)
- Do not skip `index.md` and guess at what pages exist
