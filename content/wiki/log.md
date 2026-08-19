---
title: Wiki Operation Log
tags: [meta, log]
---

> Append-only. Every ingest, lint, and query operation is recorded here.

---

## [2026-08-09] — Ingested Django Learning Roadmap, extracting core framework concepts and architecture.

---

## [2026-08-09] — Lint: index.md review

Cross-checked every topic folder against wiki/index.md — all 25 topics were already catalogued. Fixed one broken link: the Vim entry pointed to `learn-vim-progressively/summary`, which doesn't exist; corrected to `learn-vim-progressively-summary`.

---

## [2026-07-05] ingest | Strings (Character Hashing in C++)

Character hashing is deceptively deep. The two-phase model (store then use) is the key insight — most beginners build frequencies and then freeze. Hash maps eliminate ASCII math entirely, which is a nice ergonomic win. The array-vs-map question is really about whether you know your domain size.

---

## [2026-06-11] ingest | Operating Systems (OS)

- Created: 25 pages in wiki/os/ (22 concepts + 3 syntheses)
- Summary: [[os/os-summary]]
- Deferred backlinks: ~75 (resolve in next lint)
- Open questions added: 4 (see summary)

---

## [2026-06-11] rebuild | Pipeline Infrastructure

**Operation:** Rebuilt the wiki agent pipeline (scripts, systemd, index, log)

**Created:**
- `scripts/wiki-ingest.sh` — ingest entry point
- `scripts/wiki-lint.sh` — lint entry point
- `scripts/wiki-weekly.sh` — automated weekly maintenance
- `scripts/wiki-query.sh` — Q&A entry point
- `~/.config/systemd/user/wiki-agent.service` — systemd service unit
- `~/.config/systemd/user/wiki-agent.timer` — weekly timer (Sundays 10:00)

**Updated:**
- `wiki/index.md` — rebuilt with all 22 topic folders, proper wiki links
- `wiki/log.md` — converted to structured format

**Notes:**
- Several topic folders are missing source summaries (cn, computer-architecture, networking, theory-of-computation) — flagged for ingest
- Gemini API key needs to be added to `~/.config/opencode/env` for systemd timer

---

## [2026-06-09] note | Site Refocus

Refactoring site focus from generic knowledge base to personal portfolio. Moving gen AI research and basketball leadership to front.

---

## [2026-05-15] ingest | System Design Deep Dive

Spent the week mapping out large-scale system trade-offs. CAP theorem, caching strategies, and load balancing.

---

## [2026-05-13] ingest | Spring Ecosystem

Diving into Spring Boot and Hibernate. Auto-configuration under the hood.

---

## [2026-04-30] ingest | I/O Systems & OS Internals

OS disk scheduling and memory paging. Flow from keyboard interrupt to pixel on screen.

---

## [2026-04-12] ingest | Generative AI & Text Problem

Researching the text rendering problem in diffusion models. Flux + ControlNet.

---

## [2026-04-11] ingest | Wiki Foundation

Started documenting everything learned. Building a personal second brain. Starting with Computer Networks and Theory of Computation.
