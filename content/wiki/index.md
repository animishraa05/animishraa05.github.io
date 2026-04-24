---
title: Wiki
tags: [wiki, index]
---

# The Wiki — Compounding Knowledge Base

> This is the persistent, interlinked knowledge layer. Maintained by the LLM. Fed by raw sources. Read by the human in Obsidian.

---

## How This Works

- **Raw sources** live in `sources/` — drop articles, transcripts, papers here
- **The wiki** lives in `wiki/` — topic folders, each containing atomic concept pages that cross-link and compound
- When a new source is ingested, the LLM reads it and creates/updates as many wiki pages as the source contains concepts
- The wiki gets richer with every source, not just bigger

---

## Concept Index

### Data Engineering / Analytics (database)

- [[star-schema|Star Schema]] — Denormalized dimensional model with fact tables at center, dimension tables surrounding
- [[dimension-table|Dimension Table]] — Descriptive attributes about business entities (customer, restaurant, date)
- [[fact-table|Fact Table]] — Measurable business events with foreign keys to dimensions
- [[etl-pipeline|ETL Pipeline]] — Extract, Transform, Load process that populates warehouse
- [[data-warehouse|Data Warehouse]] — Separate analytical database for OLAP queries
- [[apache-airflow|Apache Airflow]] — Workflow orchestration for scheduling and monitoring pipelines
- [[prophet-forecasting|Prophet Forecasting]] — Facebook Prophet time-series model for demand forecasting
- [[rfm-segmentation|RFM Segmentation]] — Recency, Frequency, Monetary customer segmentation
- [[docker-compose|Docker Compose]] — Container orchestration for multi-service infrastructure
- [[customer-lifetime-value|Customer Lifetime Value]] — Total expected revenue from a customer

### Enterprise JavaBeans (dev)

- [[stateful-session-bean|Stateful Session Bean]] — Maintains client conversational state across multiple method calls
- [[session-bean|Session Bean]] — Server-side component encapsulating business logic in EJB
- [[entity-bean|Entity Bean]] — Represents persistent data stored in a database; the original ORM
- [[ejb-container|EJB Container]] — Runtime environment managing bean lifecycle, transactions, security, and pooling
- [[bean-managed-persistence|Bean-Managed Persistence]] — Developer writes all JDBC code for entity bean persistence
- [[container-managed-persistence|Container-Managed Persistence]] — Container auto-generates persistence code; developer defines O/R mapping at deployment
- [[activation|Activation]] — Deserializing a passivated stateful bean back into memory; Passive → Ready
- [[passivation|Passivation]] — Serializing idle stateful bean to free memory; Ready → Passive
- [[instance-pooling|Instance Pooling]] — Container maintains a pool of bean instances to avoid creation overhead
- [[ejb-lifecycle-stateless|Stateless Bean Lifecycle]] — Does Not Exist → Method-Ready Pool
- [[ejb-lifecycle-stateful|Stateful Bean Lifecycle]] — Does Not Exist → Method-Ready → Passive → Method-Ready
- [[object-relational-mapping|Object-Relational Mapping]] — Mapping between object models and relational databases

**Syntheses:**

- [[cmp-vs-bmp|CMP vs BMP — Entity Bean Persistence Compared]]
- [[stateful-vs-stateless-session-beans|Stateful vs Stateless Session Beans — Compared]]

### Front End / Back End (dev)

- [[front-end|Front End]] — Presentation layer users interact with directly; client-side UI and rendering
- [[back-end|Back End]] — Data management and processing layer; server-side logic, APIs, databases
- [[full-stack|Full Stack]] — Both front end and back end together; entire application stack
- [[client-server-model|Client-Server Model]] — Architecture where client handles UI, server handles data/processing
- [[api|API]] — Interface for front end to communicate with back end, typically over HTTP
- [[client|Client]] — Computer or software that requests services from a server
- [[server|Server]] — Computer providing services to clients over a network

- [[socket|Socket]] — OS-managed communication endpoint; IP + port uniquely identifies connection
- [[tcp-handshake|TCP Handshake]] — Three-way handshake establishes reliable TCP connection
- [[tls-handshake|TLS Handshake]] — Negotiation for encrypted communication and server authentication

### Database

- [[sql-database|SQL Database]] — Structured relational data storage with predefined schemas
- [[nosql-database|NoSQL Database]] — Flexible schema data storage for varied data models

### Backend Engineering (dev)

- [[backend-as-program|Backend as Program]] — A program running on a server that responds to requests
- [[backend-architecture|Backend Architecture]] — Layered system structure (API → Database → Cache → Workers)
- [[backend-framework|Backend Framework]] — Libraries automating server basics (Express, Django, Spring Boot)
- [[curl|curl]] — CLI tool for direct HTTP communication
- [[session-authentication|Session Authentication]] — Server-side session-based authentication
- [[jwt-authentication|JWT Authentication]] — Stateless token-based authentication

### AI / Image Generation (ai)

- [[hybrid-pipeline|Hybrid LLM-Guided Diffusion]] — LLM for reasoning + diffusion for synthesis; modular, production-ready
- [[text-rendering-problem|Text Rendering Problem]] — Three root causes: character-blind encoder, semantic drift, VAE stroke loss
- [[flux-architecture|Flux.1-dev Architecture]] — DiT, dual encoders (CLIP+T5), 16-channel VAE, flow matching
- [[glyph-injection|Glyph Injection via ControlNet]] — Pixel-perfect text via font rendering + spatial conditioning
- [[diffusion-models|Diffusion Models]] — Reverse noising process for image generation
- [[vae|VAE]] — Compressed latent space representation
- [[clip|CLIP Encoder]] — Semantic text-image alignment (character-blind)
- [[t5-encoder|T5 Encoder]] — Character-aware alternative to CLIP
- [[lora-finetuning|LoRA Fine-tuning]] — Low-rank adaptation for brand consistency
- [[controlnet|ControlNet]] — Spatial conditioning for generation control

**Syntheses:**

- [[text-rendering-solutions|Text Rendering Solutions — Three-Layer Approach]]

### Theory of Computation

- [[theory-of-computation|Theory of Computation]] — Studies what can and cannot be computed, and the resources required
- [[turing-machine|Turing Machine]] — Abstract machine that defines the limits of computation; foundation of computability
- [[halting-problem|Halting Problem]] — No algorithm can determine if an arbitrary program halts; fundamental limit of computation
- [[chomsky-hierarchy|Chomsky Hierarchy]] — Four-level classification of formal languages by expressive power
- [[automata-theory|Automata Theory]] — Study of abstract machines and the languages they recognize
- [[computability-theory|Computability Theory]] — What problems are solvable by algorithms in principle
- [[computational-complexity-theory|Computational Complexity Theory]] — Classifies problems by resource requirements (time, space)
- [[formal-language-theory|Formal Language Theory]] — Study of languages defined by grammars and automata
- [[p-vs-np-problem|P vs NP Problem]] — Whether every efficiently verifiable problem is also efficiently solvable
- [[rices-theorem|Rice's Theorem]] — All non-trivial semantic properties of programs are undecidable
- [[church-turing-thesis|Church-Turing Thesis]] — Any effectively calculable function is computable by a Turing machine
- [[alan-turing|Alan Turing]] — Father of computer science; defined the Turing machine and the halting problem
- [[lambda-calculus|Lambda Calculus]] — Formal system for function definition and computation; equivalent to Turing machines
- [[model-of-computation|Model of Computation]] — Abstract definition of how computation proceeds
- [[big-o-notation|Big O Notation]] — Describes upper bound on algorithm growth rate; measures worst-case complexity

### Wireless / Mobile Networks (networking)

- [[wireless-n/wireless-network|Wireless Network]] — communication via radio waves instead of cables
- [[wireless-n/multipath-propagation|Multipath Propagation]] — signals bouncing off obstacles arriving at different times
- [[wireless-n/channel-fading|Channel Fading]] — constructive/destructive interference of multipath signals
- [[wireless-n/modulation|Modulation]] — encoding digital data onto radio carrier waves
- [[wireless-n/multiplexing|Multiplexing]] — SDMA/FDMA/TDMA/CDMA for spectrum sharing
- [[wireless-n/spread-spectrum|Spread Spectrum]] — DSSS and FHSS for interference resistance
- [[wireless-n/minimum-shift-keying|MSK]] — continuous-phase FSK eliminating phase discontinuities
- [[wireless-n/frequency-reuse|Frequency Reuse]] — same frequencies in geographically separated cells
- [[wireless-n/cellular-mobile-system|Cellular Mobile System]] — hexagonal cells enabling massive capacity
- [[wireless-n/gsm-architecture|GSM Architecture]] — RSS/NSS/OSS subsystems for 2G cellular
- [[wireless-n/gprs|GPRS]] — packet-switched data on GSM (2.5G)
- [[wireless-n/code-division-multiple-access|CDMA]] — spread-spectrum multiple access; all users share same frequency
- [[wireless-n/ieee-802-11|IEEE 802.11]] — Wi-Fi wireless LAN
- [[wireless-n/bluetooth|Bluetooth]] — wireless personal area network (WPAN)
- [[wireless-n/zigbee|ZigBee]] — ultra-low-power WPAN for IoT sensors
- [[wireless-n/mobile-ad-hoc-network|Mobile Ad Hoc Network]] — infrastructure-less multi-hop mesh

### Neovim / Vim (dev)

- [[language-server-protocol|Language Server Protocol]] — Standard protocol enabling editor-server communication for code intelligence
- [[vim-lsp|vim.lsp — Neovim LSP Framework]] — Built-in Lua framework for LSP client management
- [[lsp-configuration|LSP Configuration]] — Define and merge LSP server configs in Neovim
- [[lsp-client|LSP Client]] — Active connection to a language server with capabilities and state
- [[lsp-root-markers|Root Markers]] — Files/directories for identifying project workspace boundaries
- [[lsp-events|LSP Events]] — Autocmd events for LSP lifecycle (attach, detach, progress, etc.)
- [[lsp-semantic-tokens|Semantic Tokens]] — Server-provided semantic code highlighting

- [[vim-modes|Vim Modes]] — Modal editing: Normal, Insert, Visual; the fundamental design
- [[vim-basic-commands|Survival Commands]] — Five essential commands: i, x, :wq, dd, p
- [[vim-text-objects|Text Objects]] — Zone selection: ci", da", yi(, etc.
- [[vim-visual-selection|Visual Selection]] — v, V, <C-v> for selecting text regions
- [[vim-search-navigation|Search & Navigation]] — Word/line/file moves, pattern search, jumping
- [[vim-rectangular-blocks|Block Selection]] — <C-v> for column-wise editing across lines
- [[vim-repetition|Repetition]] — . (dot) and N prefix for repeating commands
- [[vim-macros|Macros]] — qa...q recording and @a replay
- [[vim-splits|Vim Splits]] — :split/:vsplit and window management
- [[vim-buffers|Vim Buffers]] — File loading, saving, and buffer switching
- [[vim-completion|Vim Completion]] — <C-n>/<C-p> word completion in Insert mode

---

## Quick Navigation

- All topic folders: `wiki/` — browse by topic
- `log` — grep-parseable operation log: `grep "^## \[" wiki/log.md | tail -5`
- `SCHEMA` — page format conventions
- `MAINTENANCE` — human's maintenance guide

---

## Stats

- **Topic folders:** 11 (wireless-n, ejb, networking, theory-of-computation, imgen, lsp, learn-vim-progressively, understanding-http-for-backend-engineers, front-end-and-back-end-wikipedia, backend-engineering-basics, comprehensive-report)
- **Concept pages:** 127 (102 + 25 new)
- **Synthesis pages:** 6 (4 + 2 new)
- **Source summaries:** 9 (8 + 1 new)

_Last full lint: not yet run_

## Tips

- **Graph view** — open Obsidian graph view on `wiki/` to see connections, hubs, and orphans
- **Web Clipper** — use Obsidian Web Clipper to save articles directly to `sources/`
- **Wiki is a git repo** — you get version history, branching, and collaboration for free
