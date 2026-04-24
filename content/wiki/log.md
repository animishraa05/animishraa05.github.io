# Wiki Log

Append-only, grep-parseable. Every entry starts with `## [YYYY-MM-DD] type | Title`.

Quick queries:

- Last 5 entries: `grep "^## \[" wiki/log.md | tail -5`
- All ingests: `grep "^## .* ingest" wiki/log.md`
- All lints: `grep "^## .* lint" wiki/log.md`

---

## [2026-04-11] setup | Wiki bootstrap — initial structure, schema, seed concepts

**Type:** setup
**What:** Created wiki infrastructure.

- Created `wiki/` directory with `concepts/`, `syntheses/`, `sources/`
- Created `sources/` directory for raw source drops
- Created `SCHEMA.md` — wiki conventions for the LLM
- Created `index.md` — wiki landing page with one-line summaries per concept
- Created `log.md` — this file (renamed from changelog.md)

**Concepts seeded (14):**

- packet-switching, circuit-switching, broadcast-links, point-to-point-links
- osi-model-layers, tcp-ip-model-layers (pending)
- connection-oriented-service, connectionless-service
- layered-architecture-networking, client-server-model
- declarative-knowledge, procedural-knowledge, meta-knowledge, heuristic-knowledge, structural-knowledge

**Syntheses seeded (3, pending):**

- osi-vs-tcpip, switching-techniques, knowledge-types-compared

**Notes:** Most seed concept pages created from existing raw notes in `computer-networks/` and `ai/`. Some referenced concepts (osi-model-layers, point-to-point-links, etc.) are listed in the index but their .md files need to be created in a follow-up pass.

---

## [2026-04-11] ingest | Ejb.md

**Type:** ingest
**What:** Ingested EJB source covering Session Beans (Chapter 4) and Entity Beans (Chapter 6)

**Concepts extracted (13):**

- session-bean, stateless-session-bean, stateful-session-bean
- passivation, activation
- entity-bean, container-managed-persistence, bean-managed-persistence
- instance-pooling
- ejb-lifecycle-stateless, ejb-lifecycle-stateful
- object-relational-mapping, ejb-container

**Wiki pages created:**

- 12 concept pages in `concepts/`
- 1 source summary in `sources/`

**Key insights captured:**

- Session beans = "Verbs" (actions), Entity beans = "Nouns" (data)
- Stateful cannot be pooled (dedicated per client), stateless can be pooled
- CMP vs BMP trade-off
- Don't rely on ejbRemove() for critical cleanup

---

## [2026-04-11] ingest | Theory of computation - Wikipedia.md

**Type:** ingest
**What:** Ingested Theory of Computation source covering the three branches of ToC, models of computation, and key results

**Concepts extracted (15):**

- theory-of-computation, model-of-computation, turing-machine
- automata-theory, computability-theory, halting-problem
- rices-theorem, computational-complexity-theory
- formal-language-theory, chomsky-hierarchy
- lambda-calculus, church-turing-thesis
- big-o-notation, p-vs-np-problem
- alan-turing

**Wiki pages created:**

- 15 concept pages in `concepts/`
- 1 source summary in `sources/`

**Key insights captured:**

- Three branches: automata theory, computability theory, computational complexity theory
- Turing machine as the standard model due to Church-Turing thesis
- Fundamental undecidability results: halting problem (1937), Rice's theorem (1953)
- P vs NP is a Millennium Prize Problem
- The field answers "What are the fundamental capabilities and limitations of computers?"

---

## [2026-04-12] ingest | imgen.md

**Type:** ingest
**What:** Ingested marketing image generation pipeline research covering architecture, text rendering problem, and solutions

**Concepts extracted (10):**

- hybrid-pipeline, text-rendering-problem, flux-architecture
- glyph-injection, diffusion-models, vae
- clip, t5-encoder, lora-finetuning, controlnet

**Syntheses created (1):**

- text-rendering-solutions — three-layer solution approach

**Key takeaways:**

- Text rendering is a THREE-layer problem (character-blind encoder, semantic drift, VAE stroke loss)
- Flux addresses 2 of 3 natively (T5 + 16-channel VAE)
- ControlNet glyph injection provides the final guarantee layer
- Only 3 things need training: LLM, base aesthetic LoRA, per-client LoRAs

**Notes:** Source contains detailed Hinglish explanations of technical concepts. Valuable learning roadmap with resources included.

---

## [2026-04-12] ingest | Lsp.md

**Type:** ingest
**What:** Ingested Neovim LSP documentation covering the built-in LSP client, configuration, and features

**Concepts extracted (7):**

- language-server-protocol, vim-lsp
- lsp-configuration, lsp-client
- lsp-root-markers, lsp-events, lsp-semantic-tokens

**Wiki pages created:**

- 7 concept pages in `wiki/lsp/`
- 1 source summary in `wiki/lsp/`

**Key takeaways:**

- Neovim has a built-in LSP client (vim.lsp) requiring no plugins for basic functionality
- Configuration uses a merge chain: global (\*) → runtimepath → after/ (highest priority)
- Root markers identify project workspace; nested arrays for equal priority
- Default features: diagnostics, hover (K), omnifunc, tagfunc, formatexpr
- Semantic tokens provide semantic highlighting beyond Treesitter syntax parsing

## [2026-04-12] ingest | YBlog - Learn Vim Progressively.md

**Type:** ingest
**What:** Progressive Vim learning tutorial with four skill levels.

**Concepts extracted (11):**

- vim-modes, vim-basic-commands, vim-text-objects, vim-visual-selection
- vim-search-navigation, vim-rectangular-blocks, vim-repetition, vim-macros
- vim-splits, vim-buffers, vim-completion

**Wiki pages created:**

- Topic folder: wiki/learn-vim-progressively/
- 11 concept pages for Vim fundamentals

**Key takeaways:**

- Four progressive levels: Survive → Comfortable → Better/Stronger/Faster → Superpowers
- Modal editing is the fundamental design (Normal, Insert, Visual modes)
- Operators + motions compose: d$, yG, cw
- Learning curve: 2-3 weeks before productivity gains

**Open questions:**

- Folds (za, zR) positioning in progressive framework
- Registers beyond macros (black hole, named, system clipboard)
- Neovim Lua configuration integration

---

## [2026-04-12] ingest | Understanding HTTP for Backend Engineers Where It All Starts.md

**Type:** ingest
**What:** Ingested HTTP fundamentals source covering protocol basics, statelessness, methods, headers, status codes, CORS, and versions.

**Concepts extracted (7):**

- http, statelessness, http-methods
- http-headers, http-status-codes
- cors, http-versions

**Wiki pages created:**

- Topic folder: wiki/understanding-http-for-backend-engineers/
- 7 concept pages + 1 source summary

**Key takeaways:**

- Statelessness is a feature, not a bug—enables massive scale through simplicity
- Headers are the extension mechanism—HTTP evolves through headers without protocol changes
- Status codes are a taxonomy—3-digit system (1xx-5xx)
- CORS is a security feature protecting users while allowing controlled cross-origin access
- HTTP versions: 1.0 (new connection) → 1.1 (persistent) → 2.0 (multiplexing) → 3.0 (QUIC/UDP)

**Notes:**

- First networking concept focused on HTTP specifically
- Java code examples in source demonstrate statelessness in practice
- HTTP concepts connect to existing networking concepts (packet-switching, circuit-switching)

## [2026-04-12] ingest | Front end and back end - Wikipedia.md

**Type:** ingest
**What:** Wikipedia article covering front end, back end, full stack, client-server model, APIs

**Concepts extracted (7):**

- Front End — Presentation layer users interact with directly
- Back End — Data management and processing behind the scenes
- Full Stack — Both front end and back end together
- Client-Server Model — Architecture where client handles UI, server handles data/processing
- API — Interface for front end to communicate with back end
- Client — Computer/software that requests services from a server
- Server — Computer providing services to clients

**Pages created:**

- `wiki/front-end-and-back-end-wikipedia/front-end.md`
- `wiki/front-end-and-back-end-wikipedia/back-end.md`
- `wiki/front-end-and-back-end-wikipedia/full-stack.md`
- `wiki/front-end-and-back-end-wikipedia/client-server-model.md`
- `wiki/front-end-and-back-end-wikipedia/api.md`
- `wiki/front-end-and-back-end-wikipedia/client.md`
- `wiki/front-end-and-back-end-wikipedia/server.md`
- `wiki/front-end-and-back-end-wikipedia/front-end-and-back-end-wikipedia-summary.md`

**Notes:**

- Adds foundational vocabulary for software development concepts
- Cross-references existing networking concepts (HTTP, client-server)
- Establishes domain for dev concepts in the wiki

---

## [2026-04-12] ingest | Backend Engineering Basics.md

**Type:** ingest
**What:** Ingested comprehensive backend engineering fundamentals source covering first principles from internet to frameworks.

**Concepts extracted (18):**

- backend-as-program, ip-address, dns, port
- socket, tcp-handshake, tls-handshake
- http-protocol, curl
- sql-database, nosql-database
- session-authentication, jwt-authentication
- backend-architecture, backend-framework

**Wiki pages created:**

- Topic folder: wiki/backend-engineering-basics/
- 18 concept pages + 1 source summary

**Key takeaways:**

- Backend is fundamentally a program—not a machine, but software listening on a port
- Everything builds on sockets—HTTP, TLS, databases all run on top of socket connections
- Frameworks are abstractions over fundamentals—knowing basics makes any framework learnable
- TLS is typically terminated at reverse proxies (Nginx), not in application code

**Open questions added (4):**

- How does HTTP parsing differ between frameworks?
- Performance trade-offs between session and JWT auth at scale?
- When to build from scratch vs use a framework?
- How do reverse proxies handle TLS termination in production?

---

## [2026-04-21] ingest | WirelessN.md

**Type:** ingest
**What:** Ingested Jochen Schiller "Mobile Communications" (2nd Ed) course notes covering Units 1–5 of wireless networks

**Concepts extracted (25):**

- wireless-network, multipath-propagation, channel-fading, modulation, multiplexing
- spread-spectrum, frequency-shift-keying, minimum-shift-keying, antenna-types
- hidden-terminal-problem, exposed-terminal-problem, near-far-terminal
- maca, dama
- cellular-mobile-system, frequency-reuse, co-channel-interference, cell-sectoring, handoff
- gsm-architecture, gsm-services, gprs
- code-division-multiple-access, ieee-802-11, bluetooth, wimax, zigbee
- mobile-tcp, mobile-ad-hoc-network

**Syntheses created (2):**

- modulation-techniques-compared — FSK vs MSK vs GMSK
- wireless-mac-problems-compared — Hidden vs Exposed vs Near/Far terminal problems

**Key insights:**
- Cellular architecture enables infinite capacity scaling through frequency reuse
- MSK eliminates FSK's phase reset problem; GSM uses GMSK
- MACA's RTS/CTS handshake solves hidden terminal; strict power control solves near/far
- GSM's three subsystems (RSS, NSS, OSS) manage radio, switching, and operations
- Short-range wireless (Wi-Fi DSSS, Bluetooth FHSS, ZigBee DSSS) coexist in 2.4 GHz

**Topic folder:** wiki/wireless-n/

---

## [2026-04-14] ingest | COMPREHENSIVE_REPORT.md

**Type:** ingest
**What:** Ingested FoodFlow Analytics comprehensive report—a complete data warehouse and analytics project for Indian food delivery

**Concepts extracted (11):**

- star-schema, dimension-table, fact-table
- etl-pipeline, data-warehouse
- apache-airflow, prophet-forecasting
- rfm-segmentation, docker-compose
- customer-lifetime-value

**Syntheses created:** 0

**Topic folder:** `wiki/comprehensive-report/`

**Key insights:**
- Star schema with 5 dimensions, 2 facts, 1 aggregate table
- 80,000 orders, ~200,000 order items, 2-year date range
- ETL with full REPLACE strategy, feature engineering
- Airflow DAG with 5 tasks, daily at 03:00 IST
- Prophet forecasting with weekend regressor, MAPE evaluation
- RFM segmentation using NTILE(5) scoring

**Notes:** Adds data engineering domain to wiki. Source provides comprehensive coverage of modern data stack concepts.
