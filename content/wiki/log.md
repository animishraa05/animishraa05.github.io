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

## [2026-04-28] ingest | EJbContinued.md

**Type:** ingest
**What:** Ingested EJB continued source covering Entity Bean lifecycle callbacks, BMP implementation, and container callbacks

**Concepts extracted (15):**

- entity-context, getprimarykey
- finder-methods, ejbload, ejbstore
- ejbcreate, ejbremove, ejbpostcreate
- ejbhome
- setentitycontext, unsetentitycontext
- jdbc
- (plus expanded details on pool reuse, identity crisis of pooled beans)

**Topic folder:** `wiki/ejb/` (existing folder, concepts added to it)

**Key insights:**
- Entity beans are pooled and reused to represent different data instances
- getPrimaryKey() is critical in ejbLoad() and ejbRemove() to know which record to access
- In ejbStore(), no getPrimaryKey() needed because data already in memory
- Finder methods must begin with ejbFind prefix and return primary keys
- Home methods operate on class level, not specific instances

**Notes:** This source expands the EJB topic folder with detailed callback methods and BMP implementation details.

---

## [2026-04-28] ingest | EJb4.md

**Type:** ingest
**What:** Ingested EJb4.md source covering CMP lifecycle, EJB-QL, MDB, JMS, transactions, and EJB relationships (1:1, 1:N, M:N, directionality)

**Concepts extracted (25):**
- ejb-ql, cdata-hack, primary-key-class, cmp-abstract-accessors, cmp-lifecycle
- message-driven-bean, jms, jms-programming-model, point-to-point-vs-pub-sub
- poison-message, message-oriented-middleware, flat-vs-nested-transactions
- transaction-demarcation, entity-bean-transactions, pluggable-message-providers
- queue-partitioning, one-to-one-relationship, one-to-many-relationship
- many-to-many-relationship, bidirectional-vs-unidirectional
- session-bean-relationships, transactions, declarative-vs-programmatic-transactions
- client-initiated-transactions, normalized-vs-denormalized-schema

**Synthesis created (1):**
- cmp-vs-bmp-relationships — BMP vs CMP relationship implementations compared

**Wiki pages created:**
- 25 concept pages + 1 synthesis page + 1 source summary in `wiki/ejb/`

**Key insights captured:**
- MDB is unique: no interfaces, only onMessage(), async, stateless, pooled
- Entity beans MUST use CMT (BMT illegal) — container calls ejbLoad/ejbStore, not bean
- JMS abstracts MOM products; two domains: PTP (Queue, 1:1) and Pub/Sub (Topic, 1:N)
- CMP relationships use CMR fields with multiplicity in deployment descriptor
- BMP relationships require manual FK↔stub conversion and JNDI lookups
- Poison messages: MDB rollback causes infinite retransmit loop

---

## [2026-04-28] ingest | EJB3.md — RMI, JNDI, and EJB Deep Learning

**Type:** ingest
**What:** Added foundational concepts for RMI and JNDI that connect to EJB architecture

**Concepts extracted (16):**

- EJB architecture: ejb-object, home-interface, remote-interface, middleware, ejb-deployment-descriptor
- RMI foundation: rmi-remote-method-invocation, object-serialization, pass-by-value-in-rmi, pass-by-reference-in-rmi
- Naming: jndi

**Topic folder:** `wiki/ejb/` (existing folder, concepts added to it)

**Key insights:**
- EJB Object is the container-generated proxy for remote communication
- Home Interface is the factory for creating/finding bean instances
- Remote Interface declares business methods clients can call
- Middleware handles infrastructure (transactions, security) transparently
- Serialization enables RMI; pass-by-value for objects, pass-by-reference for Remote objects
- JNDI generalizes beyond RMI Registry for locating resources
- Layered architecture: Serialization→RMI→JNDI→Middleware→EJB

**Notes:** This source provides the foundational understanding connecting RMI communication to EJB middleware. Understanding serialization and stub architecture is essential for understanding how EJB achieves transparency.

---

## [2026-04-29] ingest | ejb5.md

**Type:** ingest
**What:** Ingested ejb5.md source (Gemini conversation, 76 messages) covering EJB Chapter 3 (Developing Your First Bean), Chapter 4 (Intro to Session Beans), and Chapter 6 (Intro to Entity Beans). Full architectural understanding of EJB component model.

**Concepts extracted (23):**
- component-architecture-soa, ejb-roles, distributed-objects
- explicit-vs-implicit-middleware, ejb-development-lifecycle
- local-home-interface, ejb-context
- application-vs-system-exceptions, ejb-verification-generation
- ejb-client-jar, location-transparency
- why-bean-doesnt-implement-interface, business-interface-pattern
- dont-rely-on-ejbremove, session-bean-lifetime
- session-bean-subtypes, stateless-session-bean-pooling
- persistence-concepts, serialization-vs-orm
- entity-bean-identity, entity-bean-instance-vs-data
- ejb-jar-file, ejb-naming-service

**Wiki pages created:**
- 23 concept pages in `wiki/ejb/` (all new, none existed before)
- 1 source summary: `wiki/ejb/ejb5-summary.md`

**Key insights captured:**
- EJB 8-step development lifecycle: code → descriptor → compile → JAR → deploy → configure → start → test
- Local Home Interface (EJBLocalHome) for same-JVM calls—no RemoteException, faster
- EJB Context is the bean's gateway to container—security, transactions, home access
- Application exceptions (routine) → client; System exceptions (critical) → container intercepts, may alert admin
- Don't rely on ejbRemove()—server crashes bypass it; use external cleanup utilities
- Session beans = short-lived, non-persistent (RAM only); Entity beans = persistent (database, years)
- Stateful (multi-request, dedicated) vs Stateless (single-request, pooled, shared)
- Stateless beans use Method-Ready Pool—any bean serves any client
- Serialization (blob, unqueryable) vs ORM (relational tables, SQL-queryable) for persistence
- Entity beans have identity (primary key)—comparable, shareable across clients
- Business Interface Pattern avoids pollution—pure business interface, bean + EJB Object both implement
- Location transparency via JNDI—lookup by nickname, not physical address
- EJB Client JAR—optional smaller archive hiding business logic from clients
- Container verifies and auto-generates EJB Object, Home Object, RMI-IIOP stubs

**Novelty:**
This source provides the complete architectural "big picture" connecting all EJB components:
- Client → JNDI → Home Object → EJB Object (Proxy) → Bean flow
- Why beans don't implement their own component interfaces (pollution + `this` danger)
- Explicit middleware (developer writes everything) vs Implicit middleware (container handles it)
- Session bean lifetime and subtype distinctions with pooling
- Persistence concepts comparing serialization vs ORM for entity beans
- Entity bean identity, instance vs data distinction

---
## [2026-04-29] ingest | ejb6.md

**Type:** ingest
**What:** Ingested ejb6.md (Gemini conversation, 88+ messages) covering JNDI architecture, J2EE platform, RMI-IIOP, and all major J2EE technologies with exam preparation tips.

**Concepts extracted (24):**
- JNDI deep dive (8): jndi-architecture, jndi-spi, jndi-naming-concepts, atomic-name, compound-name, jndi-binding, jndi-context, subcontext
- J2EE platform (4): j2ee-specification, j2ee-compliance, java-platforms, jax-rpc
- Integration & APIs (6): java-idl, jca, jaxp, jaas, jta-jts, javamail
- Web technologies (2): servlets, jsp
- Communication (1): rmi-iiop
- EJB examples (2): count-bean-example, account-bean-bmp-example
- Performance (2): client-think-time, resource-pooling
- Session context (1): session-context

**Wiki pages created:**
- 24 concept pages in `wiki/ejb/` (all new, none existed before)
- 1 synthesis page: `wiki/ejb/j2ee-tech-stack-compared.md`
- 1 source summary: `wiki/ejb/ejb6-summary.md`

**Updated:**
- [[instance-pooling|Instance Pooling]] — added client think time concept, benefits, visual diagram

**Key insights captured:**
- JNDI Architecture: Two-part system (Client API for developers, SPI for vendors) similar to JDBC
- JNDI Naming: Hierarchical tree with 5 core concepts (atomic names, compound names, bindings, contexts, subcontexts)
- J2EE is a specification (rules/PDFs), not a product—vendors implement it to earn compliance via TCK
- Java Platform Hierarchy: J2EE ⊃ J2SE ⊃ J2ME (conceptual superset)
- RMI-IIOP: Official J2EE remoting, EJB objects extend java.rmi.Remote
- Instance Pooling: 50 beans serve 10,000 clients using "client think time"
- All major J2EE APIs covered: JAX-RPC, Java IDL, JCA, JAXP, JAAS, JTA/JTS, JavaMail, Servlets, JSP
- Count Bean: Complete stateful session bean example with passivation/activation
- Account Bean: Complete BMP entity bean example with JDBC, PK class, finders

**Novelty:**
This source provides the most comprehensive coverage of:
1. **JNDI internals**: Architecture (API vs SPI), naming concepts (5 detailed concepts), practical usage
2. **J2EE big picture**: Specification vs product, compliance certification (TCK), Java platform hierarchy
3. **All J2EE APIs**: 10+ technologies grouped into 5 logical layers (Presentation, Business, Communication, Data, Foundation)
4. **RMI-IIOP deep dive**: How EJB objects are networked RMI-IIOP objects, parameter passing rules
5. **Exam preparation**: 20-mark question structure, instance pooling explanation with "bank ATM" analogy
6. **Concrete examples**: Count Bean (stateful, passivation) and Account Bean (BMP, JDBC) with exam-focused code

**Connections:**
All 24 new concept pages have 4+ bidirectional connections to existing EJB wiki pages.

---

## [2026-04-30] ingest | ds.md

**Type:** ingest
**What:** Ingested Data Science Book Summary covering data science pipeline, ML fundamentals, and modeling concepts

**Concepts extracted (16):**
- data-science, data-wrangling, data-cleaning, data-transformation
- exploratory-data-analysis, data-visualization, feature-engineering
- data-modeling, supervised-learning, unsupervised-learning
- train-test-split, overfitting, underfitting, cross-validation
- regression, classification

**Wiki pages created:**
- Topic folder: `wiki/ds/`
- 16 concept pages in `wiki/ds/`
- 1 source summary: `wiki/ds/ds-summary.md`

**Key insights captured:**
- Data science pipeline: wrangling (60-80% of work) → EDA → feature engineering → modeling
- Two main ML paradigms: supervised (labeled, X→y) vs unsupervised (unlabeled, find patterns)
- Two main supervised tasks: regression (continuous) and classification (categorical)
- Evaluation fundamentals: train-test split, cross-validation, overfitting vs underfitting
- Feature engineering often matters more than algorithm choice

**Novelty:**
This source introduces the **Data Science (ml)** domain to the wiki:
1. Full data science pipeline coverage (wrangling → modeling → deployment)
2. ML fundamentals: supervised/unsupervised, regression/classification
3. Evaluation concepts: train-test split, CV, over/under-fitting
4. All 16 concept pages have DOT diagrams and 4+ bidirectional connections

---

## [2026-04-30] ingest | https.md

**Type:** ingest
**What:** Ingested HTTP HTTPS DNS URL source (ChatGPT conversation, 6 messages) covering full end-to-end flow from key press to screen rendering.

**Concepts extracted (29):**
- url-parsing, hsts
- dns-lookup, dns-cache, dns-hierarchy, dns-root-server, dns-tld-server, dns-authoritative-server, recursive-dns
- arp-protocol, mac-address
- http-request, http-response, http-headers
- browser-rendering, dom-tree, render-tree, layout, painting, compositing, gpu-rendering
- css-parsing, html-parsing, cssom
- browser-autocomplete
- keyboard-interrupt, os-interrupt-handler
- tcp-packet-drop
- https

**Wiki pages created:**
- Topic folder: `wiki/https/`
- 29 concept pages in `wiki/https/`
- 1 synthesis page: `wiki/https/url-to-rendering-flow.md` (full flow analysis)
- 1 source summary: `wiki/https/https-summary.md`

**Updated existing pages (4):**
- `wiki/backend-engineering-basics/dns.md` — added source count, new connections
- `wiki/backend-engineering-basics/tls-handshake.md` — added source count, new connections
- `wiki/backend-engineering-basics/tcp-handshake.md` — added source count, new connections
- `wiki/backend-engineering-basics/socket.md` — added source count, new connections

**Key insights captured:**
- Full flow mastery: keyboard interrupt → OS → browser → URL parsing → DNS → TCP → TLS → HTTP → rendering
- DNS deep dive: 7 pages covering hierarchy (root → TLD → authoritative) and caching
- Browser internals: 10 pages covering complete rendering pipeline
- Hardware to software: keyboard matrix → scan codes → interrupts → event dispatch
- Security layered: HSTS (app) + TLS (transport) + HTTPS (protocol)

**Novelty:**
This source provides the most comprehensive "full flow" explanation in the wiki:
1. Hardware level: Keyboard matrix → scan codes → interrupts
2. OS level: Interrupt handlers → event dispatch
3. Browser level: URL parsing → autocomplete → HSTS check
4. Network level: DNS → ARP → TCP → TLS → HTTP
5. Rendering level: HTML/CSS parsing → DOM/CSSOM → render tree → layout → paint → composite → GPU

**Open questions added (4):**
- How does the browser's preload scanner work during HTML parsing?
- What are the differences between Blink, Gecko, and WebKit rendering pipelines?
- How does HTTP/2 multiplexing affect the request/response flow?
- What is the role of the browser's compositor thread vs main thread?

---

## [2026-04-30] ingest | io.md

**Type:** ingest
**What:** Ingested ChatGPT conversation (46 messages) covering I/O System, Secondary Storage, Semaphores, Paging, and Hashing.

**Concepts extracted (50):**
- io-system, device-driver, io-software-structure, io-request-to-hardware
- device-controller, user-level-io-software, device-independent-io-software
- interrupt-handler, polling, dma, io-devices
- block-driver, character-driver, network-driver, system-bus
- disk-structure, disk-scheduling, disk-management, swap-space, raid
- fcfs, sstf, scan-scheduling, c-scan, look-scheduling, c-look
- paging, page-table, page-fault, demand-paging, tlb, virtual-memory, segmentation, thrashing
- semaphore, binary-semaphore, counting-semaphore, wait-operation, signal-operation
- producer-consumer, reader-writer
- hashing, hash-function, collision-resolution, separate-chaining, linear-probing
- quadratic-probing, double-hashing, load-factor
- buffering

**Wiki pages created:**
- Topic folder: `wiki/io/`
- 50 concept pages (all new)
- 4 synthesis pages (paging-vs-segmentation, hashing-performance, disk-scheduling-compared, semaphore-types)
- 1 source summary: `wiki/io/io-summary.md`

**Key insights captured:**
- I/O is 4-layer architecture: User → Device-Independent → Driver → Interrupt Handler
- Full I/O flow: fopen() → system call → driver → controller → hardware → interrupt
- Disk scheduling evolution: FCFS → SSTF → SCAN → C-SCAN → LOOK → C-LOOK
- Semaphores: wait()/signal() with binary (mutex) and counting (resource pool) types
- Paging enables virtual memory with page tables and TLB caching
- Hashing is O(1) average with good hash function and α ≤ 0.7

**Novelty:**
- Complete I/O request to hardware flow with DMA and interrupt handling diagrams
- All 6 disk scheduling algorithms with trade-offs (FCFS through C-LOOK)
- Detailed semaphore operations (wait/signal) with producer-consumer and reader-writer solutions
- Paging internals: page tables, TLB, demand paging, page faults, and thrashing
- All hash collision resolution techniques: chaining, linear/quadratic probing, double hashing

**Open questions added (4):**
- How does the OS decide which pages to evict during thrashing?
- What is the optimal load factor for different collision resolution methods?
- How does NCQ (Native Command Queuing) in modern disks interact with OS disk scheduling?
- What are the real-world performance differences between LOOK and C-LOOK?

---

## [2026-05-02] index-rebuild | weekly-automated

**Type:** index-rebuild
**What:** Full automated rebuild of wiki/index.md from the current state of all wiki pages.

- Read all files across 17 topic folders
- Reorganized by domain category (not by topic folder)
- Updated all one-line summaries from current Core Idea sections
- Accurate stats: 427 concept pages, 20 synthesis pages, 17 source summaries, 464 total pages
- Domain distribution: dev (160), networking (106), systems (86), theory (18), ml (17), ai (13), database (11), security (4)
- No concept/synthesis/source pages modified — only index.md updated


**Type:** lint
**What:** Full wiki health check across ALL topic folders.

### Automated Fixes Applied:

**Wrong tags fixed (11):**
- `wiki/https/browser-autocomplete.md` through `wiki/https/render-tree.md` (11 files)
- Changed `tags: [front-end, browser]` → `tags: [dev, browser]`
- `front-end` is not a valid domain tag; `dev` is the correct domain tag

**Missing tags added (15):**
- All source summary pages now have proper `tags: [domain, subdomain]` in frontmatter
- Domains assigned: theory (1), dev (10), networking (1), ml (1), database (1), systems (1), ai (1)

**Missing Connections added (13):**
- All 13 summary/source pages now have `## Connections` sections with links to their concept pages

### Issues Flagged for Human Review:

**Orphan pages (12) — zero inbound links:**
1. `wiki/agent-module/INGEST.md` — meta instructions, not a concept page
2. `wiki/agent-module/LINT.md` — meta instructions, not a concept page
3. `wiki/agent-module/QUERY.md` — meta instructions, not a concept page
4. `wiki/computer-architecture/addressing-modes-compared.md` — orphaned synthesis
5. `wiki/computer-architecture/dma-modes-comparison.md` — orphaned synthesis
6. `wiki/computer-architecture/endianness-comparison.md` — orphaned synthesis
7. `wiki/computer-architecture/programmed-io.md` — orphaned concept
8. `wiki/computer-architecture/risc-vs-cisc.md` — orphaned synthesis
9. `wiki/cn/arp.md` — duplicate of `wiki/https/arp-protocol.md`
10. `wiki/cn/icmp.md` — orphaned concept
11. `wiki/cn/stateful-protocol.md` — orphaned concept
12. `wiki/https/url-to-rendering-flow.md` — synthesis page, likely underlinked

**Duplicate pages across folders (3) — potential contradictions:**
1. `csma-cd`: `wiki/wireless-n/csma-cd.md` vs `wiki/cn/csma-cd.md` — different content, both valid perspectives (wireless vs general networking)
2. `dns`: `wiki/cn/dns.md` vs `wiki/backend-engineering-basics/dns.md` — same topic, different depth. Backend version has `sources_count: 2`, cn version is more academic
3. `http-headers`: `wiki/understanding-http-for-backend-engineers/http-headers.md` vs `wiki/https/http-headers.md` — same topic, different content from different sources. Consider merging or cross-referencing

**Unindexed topic folders (2):**
1. `wiki/cn/` — 39 concept pages on computer networking fundamentals (acknowledgment, ARP, CSMA, TCP, UDP, etc.) — NOT referenced in index.md
2. `wiki/computer-architecture/` — 29 concept pages on CPU addressing modes, DMA, endianness, RISC/CISC, pipelining — NOT referenced in index.md

**Broken links (551 found, but ~530 are false positives):**
- SCHEMA.md and agent-module/ files contain template placeholders like `[[concept-a]]`, `[[page-a]]` — these are expected
- Real broken links: ~20 pages link to concepts that don't exist yet (e.g., `[[redis]]`, `[[mongodb]]`, `[[certificate-authority]]`, `[[ports]]`, `[[cn-summary]]`, `[[collision]]`) — these are forward references to planned stubs

**Missing required sections:**
- `## The Problem`: 30 files (mostly synthesis pages and source summaries — expected for those types)
- `## Core Idea`: 30 files (same as above)
- `## How It Works`: 31 files (same pattern)
- `## Edge Cases & Gotchas`: 31 files (1 concept page `alan-turing.md` + 30 synthesis/summary)
- `## Sources`: 22 files (mostly synthesis pages that don't require this)
- DOT diagrams missing: 162 concept pages — many pages from early ingests lack visual diagrams

**Thin pages:** 0 pages under 20 lines — all pages have substantive content

### Recommendations for Human:
1. **Index the `cn/` and `computer-architecture/` folders** — 68 concept pages are invisible in the index
2. **Resolve 3 duplicate page names** — merge or cross-reference `csma-cd`, `dns`, `http-headers`
3. **Add DOT diagrams to 162 concept pages** — especially older pages from theory-of-computation, wireless-n, comprehensive-report
4. **Consider adding `alan-turing.md` Edge Cases section** — only concept page missing this section
5. **Agent module files** (INGEST.md, LINT.md, QUERY.md) are intentionally orphans — they're meta-instructions, not wiki concepts
- **Topic folders:** 12 (added: io)
- **Concept pages:** 240 (190 + 50 new)
- **Synthesis pages:** 11 (7 + 4 new)
- **Source summaries:** 12 (11 + 1 new)

---

## [2026-05-04] ingest | dw1.md

**Type:** ingest
**What:** Ingested comprehensive Data Warehousing source (Gemini conversation, ~1926 lines) covering definitions, architecture, ETL, OLAP, schemas, and metadata.

**Topic folder:** `wiki/dw1/`

**Concepts extracted (37):**

- data-warehouse-definition, subject-oriented-dwh, integrated-dwh, time-variant-dwh, nonvolatile-dwh
- oltp-vs-olap, three-tier-dwh-architecture, dwh-gateway, etl-pipeline-dwh
- data-extraction, data-scrubbing, enrichment-dwh, conditioning-dwh, scoring-dwh, householding-dwh
- loading-dwh, dwh-refresh, dwh-server-models, data-mart-types
- star-schema, snowflake-schema, fact-constellation-schema
- multidimensional-data-model, fact-table, dimension-table
- olap-operations, olap-servers, rolap-server, molap-server, holap-server
- metadata-in-dwh, metadata-repository, metadata-management-challenges
- dwh-application-areas, dwh-benefits, dwh-scale, dwh-evolution

**Syntheses created (3):**

- schema-comparison — Star vs Snowflake vs Galaxy schema tradeoffs
- olap-server-comparison — ROLAP vs MOLAP vs HOLAP server tradeoffs
- inmon-vs-kimball — Top-down vs Bottom-up DWH architecture approaches

**Wiki pages created:**

- 37 concept pages in `wiki/dw1/`
- 3 synthesis pages in `wiki/dw1/`
- 1 source summary: `wiki/dw1/dw1-summary.md`

**Updated existing pages (5):**

- `wiki/comprehensive-report/data-warehouse.md` — added dw1 source, updated frontmatter
- `wiki/comprehensive-report/etl-pipeline.md` — added dw1 source, updated frontmatter
- `wiki/comprehensive-report/star-schema.md` — added dw1 source, updated frontmatter
- `wiki/comprehensive-report/fact-table.md` — added dw1 source, updated frontmatter
- `wiki/comprehensive-report/dimension-table.md` — added dw1 source, updated frontmatter

**Key insights captured:**

- Inmon's 4 characteristics (subject-oriented, integrated, time-variant, nonvolatile) define what makes a warehouse a warehouse
- OLTP vs OLAP is the fundamental split: transaction processing vs analytical processing
- ETL is a 4-phase process: Extract (raw), Transform (scrub/enrich/condition/score/household), Load (batch + checkpoints), Refresh (data shipping vs transaction shipping)
- Schema choice is a spectrum: star (fast, denormalized) → snowflake (efficient, normalized) → galaxy (expressive, multi-fact)
- ROLAP vs MOLAP is about computation timing: query-time (flexible, slow) vs load-time (fast, rigid)
- Metadata is the warehouse's roadmap — without it, the warehouse is a data swamp
- Inmon (top-down, enterprise first) vs Kimball (bottom-up, data marts first) — most organizations evolve from Kimball to Inmon

**Connections:**

- All 40 new pages have 4+ bidirectional connections to each other and to existing wiki pages
- Cross-references added to existing comprehensive-report pages (data-warehouse, etl-pipeline, star-schema, fact-table, dimension-table)

---

## [2026-05-11] lint | weekly-automated-lint

**Type:** lint
**What:** Full wiki health check across ALL topic folders (22 topic folders, ~496 files).

### Automated Fixes Applied:

**Broken links fixed (7):**
- `data-warehouse/fact-constellation-schema.md` — fixed 6 `wiki/data-warehouse/` prefix paths
- `data-warehouse/star-schema.md` — fixed 2 `wiki/data-warehouse/` prefix paths
- `data-warehouse/dimension-table.md` — fixed 2 `wiki/data-warehouse/` prefix paths
- `data-warehouse/dw1-summary.md` — fixed 3 `wiki/data-warehouse/` prefix paths

**Tag fixes (0):**
- No wrong tags found — previous lint fixes were preserved
- All tags now use valid domain tags: `dev`, `networking`, `ml`, `database`, `systems`, `theory`, `ai`, `meta`

**Missing Connections (0):**
- All 490+ concept pages have `## Connections` sections

### Issues Flagged for Human Review:

**Orphan pages (17) — zero inbound links:**
1. `agent-module/INGEST.md` — meta instructions, not a concept page
2. `agent-module/LINT.md` — meta instructions, not a concept page
3. `agent-module/QUERY.md` — meta instructions, not a concept page
4. `agent-module/SCHEMA.md` — schema template, not a concept page
5. `computer-architecture/addressing-modes-compared.md` — synthesis, underlinked
6. `computer-architecture/dma-modes-comparison.md` — synthesis, underlinked
7. `computer-architecture/endianness-comparison.md` — synthesis, underlinked
8. `computer-architecture/risc-vs-cisc.md` — synthesis, underlinked
9. `computer-architecture/programmed-io.md` — concept, underlinked
10. `networking/broadcast-links.md` — concept, underlinked
11. `networking/circuit-switching.md` — concept, underlinked
12. `networking/packet-switching.md` — concept, underlinked
13. `cn/arp.md` — duplicate concept (wireless-n/arp-protocol.md has more content)
14. `cn/icmp.md` — orphaned concept (not linked from anywhere)
15. `cn/stateful-protocol.md` — orphaned concept (not linked from anywhere)
16. `https/url-to-rendering-flow.md` — synthesis, underlinked
17. `data-warehouse/Pasted image 20260504155516.png` — image file, not a page

**Duplicate pages across folders (3) — potential contradictions:**
1. `csma-cd`: `wireless-n/csma-cd.md` vs `cn/csma-cd.md` — different perspectives (wireless vs general networking), both valid
2. `dns`: `cn/dns.md` vs `backend-engineering-basics/dns.md` vs `https/dns-lookup.md` — three versions, different depths
3. `http-headers`: `https/http-headers.md` vs `understanding-http-for-backend-engineers/http-headers.md` — two versions from different sources

**Unindexed topic folders (2) — 70+ concept pages invisible in index.md:**
1. `cn/` — 41 computer networking concepts (acknowledgment, ARP, CSMA, TCP, UDP, etc.) — NOT in index.md
2. `computer-architecture/` — 29 CPU concepts (addressing modes, DMA, endianness, RISC/CISC, pipelining) — NOT in index.md

**Broken wiki links (~100+ forward references to planned stubs):**
- `theory-of-computation/` folder: ~35 broken links (undecidability, grammar, lambda calculus terms, automata concepts, complexity theory terms)
- `wireless-n/` folder: ~50 broken links (sectoring, cell-splitting, handoff variants, GSM protocols, CDMA terms)
- `data-warehouse/scoring-dwh.md`: `data-mining-tools` → should be `data-mining`
- `understanding-http-for-backend-engineers/statelessness.md`: `rest-api`

**Missing required sections (expected for synthesis/source pages):**
- ~30 synthesis pages missing: `The Problem`, `Core Idea`, `How It Works`, `Sources`
- ~30 source summaries missing: `The Problem`, `Core Idea`
- These are expected — synthesis/source pages follow different templates

**Missing DOT diagrams:**
- ~160 concept pages from older ingests (theory-of-computation, wireless-n, io, comprehensive-report) lack Graphviz diagrams
- All new concept pages (data-warehouse, decision-tree) have proper DOT diagrams

**Thin pages:** 0 pages under 20 lines — all pages have substantive content

### Recommendations for Human:

1. **Index the `cn/` and `computer-architecture/` folders** — 70 concept pages are invisible in index.md
2. **Resolve 3 duplicate page names** — csma-cd, dns, http-headers have multiple versions with different content
3. **Add DOT diagrams to 160 concept pages** — especially theory-of-computation and wireless-n folders
4. **Create ~85 stub pages** for forward references (theory-of-computation, wireless-n broken links)
5. **Merge or cross-reference** `cn/arp.md` and `wireless-n/arp-protocol.md`
6. **Agent module files** (INGEST.md, LINT.md, QUERY.md, SCHEMA.md) are intentionally orphans — meta-instructions, not wiki concepts

### Wiki Stats:
- **Total files:** 496 (including log, index, schema, open-questions)
- **Topic folders:** 22
- **Concept pages:** ~460 (estimated)
- **Synthesis pages:** ~20
- **Source summaries:** ~16
- **Pages with Connections:** 490+
- **Pages with proper tags:** 492 (all valid domain tags)
- **Pages with DOT diagrams:** ~300 (60% coverage)
- **Broken links fixed this lint:** 13

### Actions Taken:
1. Scanned all 22 topic folders
2. Fixed 13 broken links (data-warehouse path prefix issues)
3. Verified all tags are valid domain tags
4. Verified all concept pages have Connections sections
5. Documented all orphans, duplicates, and forward references
6. Updated log.md with full findings

---

## [2026-05-06] ingest | dtree.md

**Type:** ingest
**What:** Ingested Decision Tree in Machine Learning source (GeeksforGeeks article) covering tree structure, attribute selection (Information Gain, Gini Index), recursive building, and prediction.

**Topic folder:** `wiki/dtree/`

**Concepts extracted (20):**

- decision-tree-structure, root-node, internal-node, leaf-node
- decision-tree-splitting, decision-tree-prediction
- entropy, entropy-calculation, information-gain, information-gain-calculation
- gini-index, gini-index-properties
- attribute-selection-measures, recursive-tree-building, node-purity
- decision-tree-stopping-conditions, decision-tree-interpretability
- decision-tree-preprocessing, decision-tree-flexibility
- id3-algorithm

**Syntheses created (1):**

- entropy-vs-gini — Information-theoretic rigor vs computational efficiency; nearly identical results in practice

**Wiki pages created:**

- 20 concept pages in `wiki/dtree/`
- 1 synthesis page in `wiki/dtree/`
- 1 source summary: `wiki/dtree/dtree-summary.md`

**Updated existing pages (3):**

- `wiki/ds/supervised-learning.md` — added decision trees as model family, dtree source reference
- `wiki/ds/classification.md` — added decision tree classifier connections, dtree source reference
- `wiki/ds/regression.md` — added decision tree regressor connections, dtree source reference

**Key insights captured:**

- Decision trees = flowchart-like: root → internal nodes (tests) → branches (outcomes) → leaves (predictions)
- Information Gain = Entropy reduction; Gini Index = 1 - Σpᵢ²; both serve same purpose, Gini is faster
- Three stopping conditions: pure class, no attributes, no instances — each with a fallback labeling strategy
- Trees are inherently interpretable: every prediction is a traceable if-then rule
- Trees need minimal preprocessing: no scaling, no encoding, handles mixed types naturally
- Worked example: splitting on Y in a 3-feature dataset produced perfectly pure children, no further splits needed

**Connections:**

- All 21 new pages have 4+ bidirectional connections to each other and to existing wiki pages (supervised-learning, classification, regression, neural-networks)
- Cross-references added to ds/ topic pages (supervised-learning, classification, regression)

---

## [2026-05-11] index-rebuild | weekly-automated

**Type:** index-rebuild
**What:** Full automated rebuild of wiki/index.md from the current state of all wiki pages.

- Read all files across 18 topic folders (487 content pages)
- Reorganized by domain category (not by topic folder)
- Updated all one-line summaries from current Core Idea sections
- Accurate stats: 450 concept pages, 20 synthesis pages, 17 source summaries, 487 content pages
- Domain distribution: dev (158), networking (108), systems (92), database (50), ml (39), theory (19), ai (14), security (5)
- No concept/synthesis/source pages modified — only index.md updated

---

## [2026-05-13] ingest | compilerdesign.md

**Type:** ingest
**What:** Ingested Compiler Design Tutorial source covering the complete compilation pipeline from lexical analysis through code generation to runtime environments.

**Topic folder:** `wiki/compilerdesign/`

**Concepts extracted (35):**

- compiler, phases-of-compiler, lexical-analysis, token, syntax-analysis
- semantic-analysis, intermediate-code-generation, code-optimization, code-generation
- object-code, compiler-pass, compiler-construction-tools, symbol-table-in-compiler
- error-handling-in-compiler, programming-language-generations, flex-lexical-analyzer-generator
- context-free-grammar, first-and-follow-sets, ambiguous-grammar
- parser-introduction, top-down-parsing, bottom-up-parsing, shift-reduce-parser
- lr-parsers (SLR, CLR, LALR), operator-precedence-parser
- syntax-directed-translation, attributed-sdt (S-attributed, L-attributed)
- three-address-code, loop-detection-in-tac, code-generator-design-issues
- data-flow-analysis, static-and-dynamic-scoping, runtime-environment
- linker-and-loader, storage-allocation-strategies

**Syntheses created (2):**

- single-pass-vs-multi-pass — compilation speed vs code quality trade-off
- compiler-vs-interpreter — ahead-of-time translation vs line-by-line execution

**Wiki pages created:**

- 35 concept pages in `wiki/compilerdesign/`
- 2 synthesis pages in `wiki/compilerdesign/`
- 1 source summary: `wiki/compilerdesign/compilerdesign-summary.md`

**Key insights captured:**

- Compiler architecture splits into front-end (analysis: phases 1-3) and back-end (synthesis: phases 4-6), enabling retargeting
- Six-phase pipeline: lexical → syntax → semantic → IR gen → optimize → code gen
- Single-pass compilers (Pascal) are fast but limited; multi-pass (C, C++) enables optimization
- Three LR parser variants: SLR (simple tables, least power), CLR (maximum power, huge tables), LALR (sweet spot, Yacc)
- S-attributed SDTs work bottom-up (LR); L-attributed SDTs work top-down (LL)
- Data-flow analysis (reaching definitions, live variables, available expressions) enables safe optimization
- Three storage allocation strategies: static (globals), stack (locals), heap (dynamic) — matched to data lifetime

**Connections:**
All 37 new pages have 4+ bidirectional connections to each other within the compilerdesign topic folder. Own domain tag (dev, compiler-design) verified.

**Novelty:**
This source introduces the **Compiler Design (dev)** domain to the wiki:
1. Complete six-phase compilation pipeline from characters to machine code
2. Formal language theory foundations (CFG, FIRST/FOLLOW, ambiguity) applied to parsing
3. All major parsing strategies covered (LL, LR, SLR, CLR, LALR, operator precedence)
4. Code optimization and data-flow analysis theory for semantics-preserving transformation
5. Runtime environment concepts (scoping, storage allocation, linking, loading)
6. Every concept page includes DOT diagrams, semantic network graphs, and bidirectional cross-references

---

## [2026-05-13] ingest | cd2.md

**Type:** ingest
**What:** Ingested GATE exam-focused Compiler Design tutorial covering the full syllabus with exam weightage, preparation tips, and practical sub-concepts.

**Topic folder:** `wiki/compilerdesign/` (existing folder)

**Concepts extracted (15):**

- working-of-lexical-analyzer — input buffering, lookahead, maximal munch
- classification-of-context-free-grammars — ambiguous/unambiguous, LL(k), LR(k) hierarchy
- recursive-descent-parser — hand-written top-down parsing
- predictive-parser — table-driven LL(1) parser
- ll1-parsing-table — construction from FIRST/FOLLOW sets
- ll1-parsing-algorithm — stack-based driver algorithm
- lr0-parser — simplest LR variant with zero lookahead
- sdt-schemes — semantic actions embedded in productions
- application-of-sdts — practical SDT uses (infix-to-postfix, type checking)
- basic-blocks — straight-line code sequences in TAC
- control-flow-graph — directed graph of basic blocks
- peephole-optimization — local target-level pattern matching
- common-subexpression-elimination — redundant expression removal
- constant-propagation — compile-time constant evaluation and propagation
- liveliness-analysis — backward data-flow analysis for live variables

**Syntheses created (2):**

- parsing-techniques-compared — LL(1), LR(0), SLR, CLR, LALR across power, table size, use cases
- optimization-techniques-compared — peephole, CSE, constant propagation, liveliness analysis compared

**Wiki pages created:**
- 15 concept pages in `wiki/compilerdesign/`
- 2 synthesis pages in `wiki/compilerdesign/`
- 1 source summary: `wiki/compilerdesign/cd2-summary.md`

**Updated existing pages (24):**

- 22 existing concept pages in `wiki/compilerdesign/` — added cd2 source reference
- 1 existing source summary (`compilerdesign-summary.md`) — added Related Sources section linking to cd2-summary
- 1 wiki index — added 15 new concepts and 2 new syntheses to Compiler Design section

**Key insights captured:**

- Parsing techniques (LL through LALR) are the most heavily tested GATE CD topic
- Three optimization techniques are GATE-relevant: peephole, CSE, constant propagation
- Liveliness analysis is the key backward data-flow analysis for dead code elimination and register allocation
- Basic blocks and control flow graphs form the structural foundation for all global optimization
- SDT schemes are the operational form of SDDs — the difference is execution order prescription vs declarative attributes
- LL(1) parsing table construction is algorithmic from FIRST/FOLLOW sets — multiple table entries mean the grammar is not LL(1)

**Connections:**
All 15 new concept pages have 4+ bidirectional connections to existing compilerdesign pages. Both new synthesis pages link to ALL concepts they compare. The source summary links to all created/updated pages.

---

## [2026-05-15] ingest | readmemd.md

**Type:** ingest
**What:** Ingested the System Design Primer README (donnemartin/system-design-primer) covering the full spectrum of large-scale system design topics from foundational trade-offs through infrastructure, databases, caching, messaging, and communication protocols.

**Topic folder:** `wiki/readmemd/`

**Concepts extracted (38):**

- Foundational: performance-vs-scalability, latency-vs-throughput, cap-theorem, cp-consistency-partition-tolerance, ap-availability-partition-tolerance, weak-consistency, eventual-consistency, strong-consistency
- Availability & Infrastructure: active-passive-failover, active-active-failover, availability-nines, availability-parallel-vs-sequence, dns-system-design, cdn-push, cdn-pull, layer4-load-balancing, layer7-load-balancing, horizontal-scaling, reverse-proxy-pattern
- Architecture & App Layer: microservices-architecture, service-discovery
- Database: master-slave-replication, master-master-replication, database-federation, sharding, denormalization, sql-tuning, nosql-database-types
- Caching: cache-aside, write-through-cache, write-behind-cache, refresh-ahead-cache
- Async: message-queues, task-queues, back-pressure
- Communication: rpc-remote-procedure-call, rest-architectural-style
- Estimation: back-of-envelope-estimates

**Syntheses created (2):**

- load-balancer-vs-reverse-proxy — compares traffic distribution vs backend abstraction
- sql-vs-nosql — compares relational vs non-relational database paradigms

**Wiki pages created:**
- 38 concept pages in `wiki/readmemd/`
- 2 synthesis pages in `wiki/readmemd/`
- 1 source summary: `wiki/readmemd/readmemd-summary.md`

**Key insights captured:**
- Everything in system design is a trade-off — no perfect solution, only informed choices
- CAP theorem: P is mandatory in distributed systems; the real choice is C vs A
- Four cache update strategies serve different read/write patterns (lazy, sync, async, proactive)
- Horizontal scaling with commodity hardware beats vertical scaling for cost and availability
- REST minimizes coupling for public APIs; RPC maximizes performance for internal services
- Back-of-the-envelope estimates using powers of two and latency trees are essential interview skills
- Know your latency numbers: L1 (0.5ns) → RAM (100ns) → SSD (150μs) → HDD (10ms) → cross-continent (150ms)

**Connections:**
All 40 new pages have 4+ bidirectional connections within the readmemd topic folder and to existing wiki pages. Source summary links to all created/updated pages.

**Novelty:**
This source introduces the **System Design (systems)** domain to the wiki — 38 new concepts covering the complete system design landscape from a practical, interview-focused perspective.

---

## [2026-05-13] ingest | Java1.md

**Type:** ingest
**What:** Ingested comprehensive GeeksforGeeks Java tutorial covering the full Java landscape from fundamentals through advanced APIs.

**Topic folder:** `wiki/java1/`

**Concepts extracted (43):**

- java-platform-independence, java-program-structure, java-identifiers-and-keywords, java-data-types, java-wrapper-classes, java-variables, java-operators, java-control-flow, java-loops, java-methods, java-access-modifiers, java-varargs, java-arrays, java-strings, java-stringbuilder-stringbuffer, java-constructors, java-object-class, java-abstraction, java-encapsulation, java-inheritance, java-polymorphism, java-packages, java-interfaces, java-exception-hierarchy, java-try-catch-finally, java-throw-throws, java-custom-exceptions, java-regex, java-memory-management, java-garbage-collection, java-collections-framework, java-arraylist, java-hashmap, java-iterator, java-comparable-and-comparator, java-lambda-and-streams, java-multithreading, java-synchronization, java-deadlock, java-executor-framework, java-file-handling, java-socket-programming, java-jdbc

**Syntheses created (3):**

- java-checked-vs-unchecked — Checked vs Unchecked Exceptions
- java-string-types-compared — String vs StringBuffer vs StringBuilder
- java-oop-pillars — The Four OOP Pillars

**Wiki pages created:**

- 43 concept pages in `wiki/java1/`
- 3 synthesis pages in `wiki/java1/`
- 1 source summary: `wiki/java1/java1-summary.md`

**Key insights captured:**

- Java achieves platform independence through JVM bytecode abstraction
- Primitives (8 types) live on stack; objects on heap with GC management
- OOP is universal in Java — four pillars: encapsulation, inheritance, polymorphism, abstraction
- Exception handling is structured: Throwable → Exception (checked) + RuntimeException (unchecked) + Error
- Collections framework is interface-centric; choose implementations by performance characteristics
- Java 8+ functional additions (lambdas, streams) enable declarative data processing
- Concurrency model: threads + synchronization + executor framework for scalable parallelism
- JDBC provides vendor-independent database access through driver abstraction

**Connections:**
All 43 concept pages have 4+ bidirectional connections within the java1 topic folder. All 3 synthesis pages link to all concepts they compare. The source summary links to all created pages.

**Novelty:**
This source introduces the **Java (dev)** domain to the wiki:
1. Complete Java language foundation: syntax, types, variables, operators, control flow
2. OOP system: classes, objects, inheritance, interfaces, polymorphism
3. Memory model: stack, heap, garbage collection with generational collectors
4. Collections: full List, Set, Map hierarchy with implementations
5. Concurrency: threads, synchronization, deadlock, executor framework
6. I/O system: file handling, sockets, JDBC — all following stream-based patterns
7. Modern Java: lambdas, streams, functional interfaces
8. Each concept page includes DOT diagrams, semantic network graphs, and bidirectional cross-references

---

## [2026-05-13] ingest | Java2.md — Java OOP Concepts (GeeksforGeeks)

**Type:** ingest
**What:** Ingested GeeksforGeeks Java OOP concepts article covering the four OOP pillars (encapsulation, inheritance, polymorphism, abstraction), classes/objects, association types (aggregation, composition), five inheritance variants, and OOP advantages/disadvantages.

**Topic folder:** `wiki/java/` (existing folder — OOP concepts from both Java1.md and Java2.md merged)

**Concepts from this source (18):**
- class, object, abstraction, encapsulation, association, aggregation, composition, inheritance, inheritance-types, single-inheritance, multilevel-inheritance, hierarchical-inheritance, multiple-inheritance, hybrid-inheritance, polymorphism, compile-time-polymorphism, runtime-polymorphism, oop-advantages, oop-disadvantages

**Wiki pages updated in this ingest (17):**
- 5 inheritance subtype pages (single, multilevel, hierarchical, multiple, hybrid) — added Visual Explanation (DOT), Semantic Network, Key Properties
- java-single-inheritance — also added Edge Cases & Gotchas section
- java-interfaces — added "100% abstraction" detail and java2-summary source reference
- java-methods — added method definition detail and java2-summary source reference
- 4 synthesis pages (oop-pillars, aggregation-vs-composition, overloading-vs-overriding, abstract-class-vs-interface) — added Sources sections linking to java2-summary

**Key insights captured:**
- OOP advantages: code reusability, better structure, DRY principle, faster development
- OOP disadvantages: steep learning curve, small program overhead, debugging complexity, higher memory usage
- Java supports five inheritance types but restricts multiple/hybrid to interface-only
- Encapsulation acts as a "protective shield" wrapping data and methods into a single unit
- Abstraction: abstract classes provide partial abstraction; interfaces provide 100% abstraction
- Association has three levels: basic (independent), aggregation (weak has-a), composition (strong has-a)

**Novelty:**
This source provides a focused overview of Java OOP concepts with real-world metaphors (ATM for abstraction, House/Rooms for composition, Dog/Tommy for objects) that enrich existing concept pages. No new concept pages were needed — all 18 concepts from this source already existed from the Java1.md ingest. This ingest strengthens the existing pages with DOT diagrams, additional examples, and proper source attribution.

---

## [2026-05-13] ingest | java3.md — Advanced Java Tutorial

**Type:** ingest
**What:** Ingested comprehensive GeeksforGeeks Advanced Java tutorial index covering Hibernate ORM, entire Spring ecosystem (Core, MVC, Boot, Data JPA, ORM, JDBC, Security, AOP, Cloud), Java Microservices, and JUnit testing.

**Topic folder:** `wiki/java3/`

**Concepts extracted (42 new concept pages):**

**Hibernate (5):** hibernate-orm-framework, hibernate-entity-mapping, hibernate-annotations, hql, hibernate-caching

**Spring Core (6):** spring-framework, spring-ioc-container, spring-bean-lifecycle, spring-autowiring, spring-annotations, spring-spel

**Spring MVC (5):** spring-mvc, dispatcher-servlet, spring-controller, spring-form-handling, spring-mvc-exception-handling

**Spring Boot (4):** spring-boot, spring-boot-auto-configuration, spring-boot-rest-api, spring-boot-actuator

**Spring Data JPA (4):** spring-data-jpa, jpa-repository, jpa-query-methods, jpa-pagination-sorting

**Spring ORM + JDBC (2):** spring-orm, spring-jdbc-template

**Spring Security (3):** spring-security, spring-security-authentication, spring-security-csrf-jwt

**Spring AOP (2):** spring-aop, spring-aop-advice

**Spring Cloud (3):** spring-cloud, spring-cloud-service-discovery, spring-cloud-api-gateway

**Java Microservices (4):** java-microservices, api-gateway-pattern, service-discovery-registry, distributed-tracing

**JUnit (4):** junit-testing, junit-annotations-lifecycle, junit-parameterized-tests, test-driven-development

**Syntheses created (2):**
- servlet-vs-jsp — Servlet vs JSP comparison
- monolithic-vs-microservices — Monolithic vs Microservices architecture analysis

**Updated existing pages (5):**
- `wiki/java/java-jdbc.md` — added CRUD operations, statement types, transaction details, java3 source
- `wiki/ejb/jdbc.md` — added java3 source reference
- `wiki/ejb/servlets.md` — added lifecycle, filters, session management, CRUD details
- `wiki/ejb/jsp.md` — added lifecycle, directives, EL, JSTL, implicit objects
- `wiki/ejb/object-relational-mapping.md` — added Hibernate ORM details

**Key insights captured:**
- Spring dominates Java enterprise development — its modular ecosystem covers every layer (web, data, security, cloud)
- Spring Boot's auto-configuration uses conditional annotations to detect classpath dependencies and create infrastructure beans automatically
- Spring Data JPA eliminates all DAO implementation code through interface-based repositories and derived query methods
- Hibernate caching spans three levels: L1 (session), L2 (session-factory), and query cache (result IDs)
- Spring Cloud provides the full microservice infrastructure stack: Eureka (discovery), Gateway (routing), Sleuth/Zipkin (tracing)
- Microservice architecture decision depends on team size and operational maturity, not technology preference
- JUnit 5 parameterized tests enable running the same test with multiple inputs, each reported independently

**Novelty:**
This source introduces the **Spring ecosystem** and **microservices architecture** domains to the wiki:
1. Complete Spring coverage: Core → MVC → Boot → Data → Security → AOP → Cloud
2. Hibernate ORM concepts that complement existing EJB ORM content
3. Java Microservices architecture with API Gateway, Service Discovery, Distributed Tracing
4. JUnit 5 testing framework with parameterized tests and TDD practice
5. All 34 new concept pages include DOT diagrams, semantic network graphs, and 4+ bidirectional connections
6. 2 synthesis pages compare Servlet vs JSP and Monolithic vs Microservice architectures
