---
title: Open Questions
tags: [meta, open-questions]
updated: 2026-04-11
---

# Open Questions — What the Wiki Doesn't Know Yet

> Every ingest surfaces questions the source raised but the wiki can't answer.
> This file is your research agenda. Grow it deliberately.

---

## How This Works

When ingesting a source, the LLM should ask: **what did this source make me wonder that I can't answer from existing wiki pages?**

Each question gets:

- The question itself
- Which source raised it
- Which existing concepts are related
- Status: `open` → `investigating` → `answered`

---

## Open Questions

<!-- Add new questions at the TOP, under the appropriate category -->

### EJB / Enterprise Java

- _(No questions yet — EJB was the first source)_

### Backend Engineering

- **How does HTTP parsing differ between frameworks?** — raised by [[backend-engineering-basics-summary|backend-engineering-basics]]. Related: [[http-protocol]], [[backend-framework]]. Status: open
- **What are the exact performance trade-offs between session and JWT auth at scale?** — raised by [[backend-engineering-basics-summary|backend-engineering-basics]]. Related: [[session-authentication]], [[jwt-authentication]]. Status: open
- **When should you build from scratch vs use a framework?** — raised by [[backend-engineering-basics-summary|backend-engineering-basics]]. Related: [[backend-framework]], [[backend-as-program]]. Status: open
- **How do reverse proxies actually handle TLS termination in production?** — raised by [[backend-engineering-basics-summary|backend-engineering-basics]]. Related: [[tls-handshake]], [[backend-architecture]]. Status: open

### Networking

- _(No questions yet — seeding phase)_

### Theory of Computation

- _(No questions yet — seeding phase)_

### Cross-Domain

- _(No questions yet — need more sources to reveal connections)_

### Data Engineering

- **How would incremental ETL differ from full REPLACE for this schema?** — raised by [[comprehensive-report-summary|FoodFlow Analytics]]. Related: [[etl-pipeline]], [[data-warehouse]]. Status: open
- **What additional features would improve Prophet forecasting accuracy?** — raised by [[comprehensive-report-summary|FoodFlow Analytics]]. Related: [[prophet-forecasting]]. Status: open
- **How would real-time streaming change the architecture?** — raised by [[comprehensive-report-summary|FoodFlow Analytics]]. Related: [[data-warehouse]], [[etl-pipeline]]. Status: open

---

## Answered Questions (Archive)

<!-- When a question is answered, move it here with the answer -->

- _(None yet)_

---

## Stats

- **Open questions:** 7 (4 + 3 new)
- **Under investigation:** 0
- **Answered:** 0

_This file grows deliberately. Don't let it accumulate without pursuing answers._
