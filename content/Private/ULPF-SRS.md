a# Universal Log Pre-processing Framework (ULPF) Software Requirements Specification


**Date:** 2026-09-19  
**Team:** 3-Person Python Stack | SIH Problem Statement — Perimeter Network Devices  
**Status:** Draft for Review (100k synthetic, Docker, Beautiful UI)  
**Path:** `~/blog/content/ULPF-SRS.md` (Obsidian + Markdown, all diagrams DOT via Graphviz)

> **How to read this SRS:** Every major choice has a `Decision` callout with **Chosen vs Alternatives + 1-line why not**. This habit proves research depth vs generic LLM answers. DOT blocks render with `dot -Tpng` or Obsidian Graphviz plugin.

---

## Table of Contents
1. [Introduction](#1-introduction)
2. [Problem Statement Deep Dive](#2-problem-statement-deep-dive)
3. [Component Catalog — What We Use, Where From, Why This Not That](#3-component-catalog)
4. [System Overview — How Components Fit](#4-system-overview)
5. [Functional Requirements](#5-functional-requirements)
6. [Non-Functional Requirements](#6-non-functional-requirements)
7. [How We Will Use the Components — Detailed Workflow](#7-how-we-will-use-the-components)
8. [Tech Stack — Why This, Not That](#8-tech-stack)
9. [Architecture & Diagrams (DOT)](#9-architecture--diagrams-dot)
10. [Synthetic Log Forge — 100k Plan](#10-synthetic-log-forge)
11. [Data Design — OCSF Hybrid Schema](#11-data-design)
12. [Interface Specification & Beautiful UI](#12-interface-specification)
13. [Verification & Traceability](#13-verification--traceability)
14. [References](#14-references)
15. [Appendices](#15-appendices)

---

## 1. Introduction

### 1.1 Purpose
This SRS specifies the Universal Log Pre-processing Framework (ULPF) that converts **any perimeter network device log** — regardless of format, vendor, or technology — into a **standardized, lossless, analytics-ready** representation for next-gen SIEM and cybersecurity platforms. It is the single source of truth for architecture, implementation, and verification.

### 1.2 Scope
**In-scope (Current SIH Scope):** Perimeter devices only.  
*Network:* Cisco ASA/Firepower, Juniper SRX, Palo Alto NGFW, Fortinet FortiGate, Checkpoint, F5 BIG-IP, Zscaler NSS, Proxy, VPN, WAF, IDS/IPS.

*Formats:* Syslog (RFC3164/5424), JSON, XML, CSV, CEF, LEEF, proprietary vendor lines.

*Out-of-scope for demo (extensible via same plugin):* Servers, OS, DB, Cloud, IoT, EDR, IAM. Demo uses **100k synthetic logs only** — no hardware needed.

**Deliverables mapped to SIH:** Source Code (GitHub), README + `docker compose up` (Docker easy setup), Architecture Doc (this SRS condensed to 2 pages), Demo Video (2 min), 5-Slide PPT.

### 1.3 Definitions & Acronyms
| Term | Meaning |
|------|---------|
| **OCSF** | Open Cybersecurity Schema Framework — Linux Foundation vendor-neutral event schema |
| **CEF / LEEF** | Common Event Format / Log Event Extended Format |
| **Drain3** | Fixed-depth tree log parser (He et al., ICWS 2017) |
| **WASM** | WebAssembly — sandboxed, hot-reloadable plugin runtime (wasmtime) |
| **Redpanda** | Kafka-API compatible queue, KRaft mode (no ZooKeeper) |
| **LCU** | Log Contrastive Unit — group of logs differing only in parameters (LUNAR) |
| **Lossless** | Raw log fully preserved and rehydratable from normalized event |
| **Air-Gapped** | Deployable with zero internet egress; all models/images vendored inside Docker |

### 1.4 References
See Section 14. All research 2021-2026 (OCSF 1.4/1.8/1.9, DeepParse EASE 2026, LUNAR 2025, LogBERT/ADALog downstream).

### 1.5 Overview
Sec 2 = PS. Sec 3 = catalog with **why this not that** at each row + master alternatives table. Sec 7 = how we use them. Sec 9-11 = architecture/DOT/schema. Sec 13 proves PS `a-k`.

---

## 2. Problem Statement Deep Dive

### 2.1 Background
Modern enterprises generate billions of events/day from hundreds of sources. Security teams spend 60-70% of onboarding time writing source-specific parsers before data is usable in SIEM/Data Lake/ML. Hybrid multi-cloud estates need a vendor-agnostic, extensible universal schema.

### 2.2 Why Perimeter Devices Are Hard
*Same event, five dialects:*
```
Fortinet:  date=2026-09-19 time=10:00:00 devname=FGT logid=0000000013 type=traffic srcip=10.0.0.5 dstip=8.8.8.8 action=accept
Palo Alto: 2026/09/19 10:00:00,007301000001,TRAFFIC,accept,10.0.0.5,8.8.8.8
Cisco ASA: %ASA-6-302013: Built inbound TCP connection 123 for outside:8.8.8.8/443 to inside:10.0.0.5/52321
Zscaler:   {"sourcetype":"zscalernss-web","clientIP":"10.0.0.5","serverIP":"8.8.8.8","action":"Allow"}
CEF:       CEF:0|Fortinet|Fortigate|7.2|00013|traffic:forward|3|src=10.0.0.5 dst=8.8.8.8 act=accept
```
Without normalization: no correlation, no single dashboard, no portable Sigma/ML rules.

### 2.3 What SIH Asks Us to Build
ULPF must **ingest, parse, normalize, standardize** any hardware/software event **while preserving raw** for forensics/compliance, **traceable** (normalized <-> raw), **plug-and-play** new sources, **unified visibility**, **SIEM/Data Lake integrated**, **AI/ML-ready**, **reduced parser effort**, **air-gapped**, **containerized**.

**Traceability to PS Requirements `a-k`:**

| PS | Requirement | Satisfied By (SRS) |
|----|-------------|--------------------|
| a | Preserve raw without loss | FR5 + simple hash + rehydrate API (Sec 7.4) |
| b | Extract source-specific attrs | FR2/FR3 Drain+mask (Sec 7.2) |
| c | Normalize to common taxonomy | FR4 OCSF Mapper (Sec 11) |
| d | Traceability | FR5 SHA256 + `record_integrity` prev_event chain |
| e | Plug-and-play onboarding | FR6 WASM Registry + YAML |
| f | Unified visibility | FR9 Beautiful Dashboard |
| g | SIEM/Data Lake integration | FR8 Dual Sink Redpanda+Parquet |
| h | AI/ML-ready | FR8 Parquet + optional tiny transformer flag (Sec 7.6) |
| i | Reduced parser effort | FR2 Auto-synthesis + FR7 auto-heal |
| j | Air-gapped | NFR4 Docker tar + Ollama offline |
| k | Container platform independent | NFR6 `docker compose up` single command |

> **Decision: SIH Scope = Perimeter Only (not full enterprise)**
> *Alternatives:* Full enterprise (servers/DB/IoT) from day 1, Perimeter + one extra (e.g., EDR).
> *Why Perimeter Only:* SIH Current Scope explicitly says perimeter; judging will test perimeter CEF/LEEF/Syslog. Full scope spreads 3-person team thin and fails demo depth. Extensibility via YAML proves the rest without building it.

---

## 3. Component Catalog

> Every component: **what it does, where we got it from, why we chose it and not alternatives**. All choices Python-friendly for 3-person team.

### 3.1 Detailed Catalog (10 Components)

| #       | Component                                             | What It Does                                                                                                                         | Where It Came From (Source)                                                                                                        | Version / Provenance                                                                                                                                              | Why We Use It (1 line)                                                                               |
| ------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| **C1**  | **OCSF Core + Extensions**                            | Universal event taxonomy: categories, classes, objects, `base_event`. `record_integrity` & `ai_operation` profiles carry hash chain. | Linux Foundation OCSF, `schema.ocsf.io` & `github.com/ocsf/ocsf-schema`                                                            | **1.4.0** (2025-02-05) base + **1.8** (Mar 2026) `ai_operation` + **1.9** `record_integrity` attestation. Confirmed newest via `schema.ocsf.io:1.4.0` & releases. | Vendor-neutral standard judges expect; extensible without forking core.                              |
| **C2**  | **DeepParse Hybrid** (LLM Synth + Drain)              | *Offline* LLM mines typed regex masks from 50 samples; *Online* Drain applies them deterministically.                                | EASE 2026 paper & repo `NightBaRron1412/DeepParse` — separates stochastic reasoning from deterministic execution                   | DeepSeek-R1-Distill-Llama-8B LoRA r=8/α=32, PA 97.6% avg 16 datasets, 100× faster than per-line LLM                                                               | Accuracy of LLM, cost/determinism of regex. Perfect for air-gapped: synth once, run forever.         |
| **C3**  | **LUNAR Unsupervised LCU**                            | Ranks logs by commonality+variability to find Log Contrastive Units; prompt LLM to extract templates without labels.                 | ACM `doi:10.1145/3729377` — *No More Labelled Examples?* (Huang et al., Jun 2025)                                                  | Hybrid ranking + contrastive prompt, beats SOTA unsupervised                                                                                                      | Our drift auto-heal: when unparsed >5%, LUNAR finds new templates without human labels.              |
| **C4**  | **Drain3 Engine**                                     | Fixed-depth (5) parse tree, similarity 0.4. Mask-First variant: pre-mask with regex then tree cluster.                               | He et al., IEEE ICWS 2017 `Drain` + `logpai/drain3` Python impl                                                                    | De facto streaming parser industry, O(N)                                                                                                                          | Lightweight, deterministic, Python-native.                                                           |
| **C5**  | **Redpanda (Kafka API)**                              | Durable queue for `raw_logs` & `normalized_logs`, backpressure, replay.                                                              | Redpanda Inc., Kafka-compatible, KRaft (no ZK)                                                                                     | 24.x, `redpanda/redpanda:latest`                                                                                                                                  | 40% lighter than Kafka+ZK, single binary, air-gapped tar, proves billions/day without heavy cluster. |
| **C6**  | **WASM Runtime (wasmtime-py) / Vector 0.40 pattern**  | Sandboxed hot-pluggable filters: YAML -> WASM module hot-reloaded in 200ms, no restart.                                              | `github.com/eunomia-bpf/wasm-bpf`, `Fluent Bit WASM`, `Vector 0.40 WASM 2.0` (1.2M/sec/vCPU, 400μs coldstart, Gartner 70% by 2027) | `wasmtime 14.0`, WASM 2.0 multi-memory, Python `wasmtime`                                                                                                         | True plug-and-play + isolation: bad parser cannot crash pipeline.                                    |
| **C7**  | **Ollama + DeepSeek-R1-Distill-Llama-8B (quantized)** | Local LLM for offline mask synthesis. LoRA adapter published `NightBaRron1412/deepparse-r1-8b`                                       | DeepParse paper Sec *LLM Configuration*                                                                                            | 8B, Q4_K_M ~3.5GB, temp=0                                                                                                                                         | Air-gapped LLM: no API key, no egress.                                                               |
| **C8**  | **ClickHouse + MinIO (Parquet)**                      | Columnar store for analytics + S3-compatible lake. Tiering: hot 7d local -> S3.                                                      | `ClickHouse`, `MinIO`, `Loki 3.0 columnar` bench (10.2GB/s, 68% storage save)                                                      | ClickHouse 24.x, MinIO RELEASE.2024+                                                                                                                              | 10× faster than ES for log scans, compresses repetitive OCSF labels 4×.                              |
| **C9**  | **Pydantic OCSF + Great Expectations**                | Runtime validation of OCSF events, schema drift detection.                                                                           | `pydantic` + `greatexpectations`                                                                                                   | v2                                                                                                                                                                | Data contract: rejects bad normalized events before sink.                                            |
| **C10** | **Synthetic Forge**                                   | Generates 6-vendor × 4-format logs realistically.                                                                                    | Vendor log refs (Fortinet Log Ref 7.4, Palo Alto CEF, Cisco ASA Syslog), LogHub2, Faker                                            | Jinja2 + Faker                                                                                                                                                    | No hardware needed; reproducible demo; drift injection for auto-heal test.                           |

### 3.2 Why This, Not That — Per-Component Rationale

#### C1 — OCSF vs Alternatives

| Option | What It Is | Pros | Cons | Verdict |
|--------|------------|------|------|---------|
| **OCSF 1.4/1.9 (Chosen)** | Linux Foundation vendor-neutral | Extensible via `vendor_attributes` + `record_integrity`, SIH expects standard | Needs mapping effort | **Chosen** — SIH says vendor-agnostic; judges validate at `schema.ocsf.io` |
| ECS 8.x | Elastic Common Schema | Mature, ELK ready | Elastic-tied, not neutral | Not vendor-agnostic — loses `a-k` generality |
| Splunk CIM | Splunk | SIEM ready | Splunk lock-in | Fails extensibility test |
| CEF native | ArcSight flat | No taxonomy needed | No analytics-ready, loses `c,g,h` | Not analytics-ready |
| Custom JSON | Our own schema | Easy | No standard, judges reject | Reinvents wheel |

> **Decision: OCSF.** *Why not ECS/CIM:* Ties to one SIEM, violates `vendor-agnostic + suitable for Big Data` (SIH Detailed Description). *Why not CEF:* Flat key-value, no category/class, no ML-ready.

#### C2/C4 — Parser: DeepParse Hybrid vs Pure Approaches

| Option | Pros | Cons (1-liner) | Verdict |
|--------|------|----------------|---------|
| **DeepParse Mask-First Drain (Chosen)** | 97.6% PA, 0.3s/100 logs, deterministic, offline synth, air-gapped | Needs 50 samples | **Core** — best trade-off for 100k + billions/day |
| Per-line LLM (LLMParser, LogPPT direct) | High accuracy | 29s/100 logs, non-deterministic, needs internet, fails air-gap `j`, breaks `billion/day` | Too slow/costly |
| Pure Drain/Spell/Logram | Fast | PA 34% avg, hardcoded masks miss `blk_-?\d+` style | Too weak for perimeter CEF variety |
| LogPPT few-shot | Good with labels | Needs manual word-level labels, labor | Not unsupervised |

> **Decision: Offline synth once, deterministic Drain forever.** *Why not per-line LLM:* Paper Table II shows 100× slower + stochastic outputs violate forensic reproducibility (`d`). Our air-gapped must run without API.

#### C3 — Drift Auto-Heal: LUNAR vs Manual vs ADALog Retrain

| Option | Pros | Cons |
|--------|------|------|
| **LUNAR LCU (Chosen)** | Unsupervised, no labels, hybrid ranking | Needs sampler |
| Manual regex update | Simple | Human 70% time, violates `i` reduced effort |
| ADALog/Transformer retrain | Strong anomaly | Needs sequences + GPUs, overkill for parsing drift |

> **Decision: LUNAR.** Trigger when `unparsed>5% 5m`, auto-synth new masks, canary 1%. Keeps `i` promise without human.

#### C6 — WASM Hot-Plugin vs Native

| Option | Pros | Cons |
|--------|------|------|
| **WASM wasmtime-py (Chosen)** | 200ms hot-swap, sandboxed 8MB, bad parser cannot crash pipeline (Vector 0.40 proves 1.2M/sec) | Slight compile step |
| Native Python import | Simple | Crash pipeline, no isolation, requires restart — violates `e` plug-and-play |
| Go plugin/Lua | Fast | Go needs restart, Lua partial sandbox | 

> **Decision: WASM.** *Why not native:* Native `import` brings `canary fail = pipeline down`. WASM linear memory isolation guarantees a bad Juniper YAML cannot take down Fortinet parsing.

#### C7 — Ollama 8B Q4 vs Alternatives

| Option | Pros | Cons |
|--------|------|------|
| **DeepSeek-R1-8B Q4 (Chosen)** | 3.5GB, local, LoRA ready, DeepParse proven | 4GB RAM needed |
| GPT-4 API | Strong | Needs internet, cost, fails `j` air-gapped |
| Llama-3 70B | Strongest | 40GB RAM, not for 3-person laptop demo | 
| No LLM (hand regex) | Lightest | Not extensible, every new vendor needs expert |

> **Decision: 8B quantized.** *Why not API:* SIH `j` air-gapped bans egress. *Why not 70B:* Docker easy setup requires laptop-runnable.

### 3.3 Master Alternatives Table (For 2-Page Arch Doc)

| Decision | Chosen (Why) | Best Alternative (Why Not — 1 liner) |
|----------|--------------|--------------------------------------|
| Schema | OCSF 1.9 — neutral + attestation | ECS — Elastic lock-in, not vendor-agnostic |
| Parser | DeepParse hybrid — offline synth + deterministic Drain | Per-line LLM — 100× slower, non-deterministic, not air-gapped |
| Queue | Redpanda KRaft — single binary, light | Kafka+ZK — 3× containers, heavy for demo |
| Plugin | WASM — hot-swap sandboxed | Native Python — crash propagates, needs restart |
| LLM | R1-8B Q4 offline — 3.5GB | GPT-4 API — violates air-gap |
| Store | ClickHouse+MinIO — 68% save columnar | Elasticsearch — 220$/TB + JVM, heavy |
| Language | Python 3.11 — team stack | Java (Logstash) — heavy, not for 3-person Python SIH |
| UI | React+Vite — beautiful bespoke | Grafana — generic, not parser studio |
| Forge | Synthetic 100k Faker — reproducible | Real pcap — needs hardware |
| ML | Tiny DistilBERT downstream optional — 15MB | LogBERT as parser — couples stages, needs sequences |

### 3.4 Papers We Evaluated But Did Not Make Core (And Why)

*   **SecBPMN2 Hybrid (arxiv:2608.14370)** — Hybrid LLM + rule for BPMN diagrams. Validates hybrid philosophy, but domain is business process models, not streaming syslog/CEF. *Cite as related work, not core.*
*   **IEEE 11626222 Lightweight Hybrid for Semantic Normalization** — Title exactly SIH, argues lightweight hybrid beats heavy transformer for normalization latency. *Supports our lightweight choice; paywalled so cite title only.*
*   **LogBERT / ADALog / LogLLaMA** — Transformer for *anomaly after parsing*. They *consume* parsed templates, not create lossless normalization. Heavy, need grouped sessions, criticized for data leakage. *Keep as optional downstream flag (`is_alert`), not in parsing path.*

---

## 4. System Overview

ULPF is a **fabric**, not a monolith. Three planes:

* **Data Plane:** Ingest -> WASM Registry -> Drain -> OCSF Mapper -> Simple Integrity (hash) -> Dual Sink.
* **Control Plane:** FastAPI + Beautiful Parser Studio UI (no-code YAML tester, lineage viewer).
* **Synthesis Plane (offline):** `synth_masks` CLI — runs once per source, produces versioned `masks/<vendor>.json`, hot-loaded at runtime.

Every event flows with: `event_id (UUIDv7) | raw (verbatim) | raw_hash (SHA256) | normalized (OCSF) | normalized_hash | chain_uid + prev_event (simple ordering) | masks_version | ingestion_time`.

> **Decision: Fabric (not monolith)**
> *Alternatives:* Single binary, Microservices overkill (6 services + K8s).
> *Why Fabric:* Single Docker Compose still runs as fabric (5 containers) but logically separated so parser crash does not lose ingest. Monolith would violate `e` hot-plugin isolation; K8s overkill for SIH demo + air-gapped.

---

## 5. Functional Requirements

| ID | Requirement | Details | Priority | Decision Note |
|----|-------------|---------|----------|---------------|
| FR1 | **Ingestion** | Syslog UDP/TCP 514 (RFC3164/5424), File poll (`forge/output/*.log` for 100k), HTTP POST `/api/v1/ingest`, Kafka producer to `raw_logs`. Batch 1024, ring 128MB. | MUST | *Why Syslog+Poll+API:* Covers all perimeter transports; pure API misses legacy devices. eBPF optional upgrade only. |
| FR2 | **Offline Mask Synthesis** | `synth_masks(samples=50, mode=offline_hf)` -> `[{"label":"ipv4","pattern":"..."}]`. CLI `ulpf synth --vendor fortinet --samples 50`. Caches masks, versioned. | MUST | *Why 50:* DeepParse entropy-greedy proves 50 diverse samples beats 1000 random; fits air-gapped fast. |
| FR3 | **Deterministic Parsing** | Mask-First Drain3: masks -> `<IP>`, `<NUM>` -> tree depth 5 sim 0.4. Same input -> same `template_id`. | MUST | *Why depth 5 sim 0.4:* Paper-tuned; depth 3 under-groups CEF, depth 8 over-fragments. |
| FR4 | **Normalization (OCSF)** | YAML `field: json_path -> ocsf_path` (e.g., `srcip -> src_endpoint.ip`). Profiles: `network` 4001, `http` 4003, `dns` 4005. Preserves `unmapped` + `vendor_attributes`. | MUST | *Why YAML not code:* <50 LOC per vendor proves `i` reduced effort; UI can edit without Python. |
| FR5 | **Lossless + Traceability (Simple)** | Store `raw`, `raw_hash=SHA256(raw)`, `normalized_hash`, `prev_event` (SHA of previous normalized for ordering). API `GET /trace/{id}`, `POST /rehydrate/{id}` returns `raw == rehydrated` diff 0. Uses OCSF 1.9 `record_integrity` attestation fields but simple SHA, no blockchain. | MUST | *Why simple hash not Merkle tree:* SIH `a,d` needs rehydration proof, not crypto chain. Merkle over-engineers for 100k demo; simple SHA is verifiable and explainable to judges in 10s. |
| FR6 | **Plug-and-Play** | `POST /api/v1/parsers` YAML. Validate -> compile WASM -> hot-reload 200ms -> Kafka rebalance. No restart. | MUST | *Why WASM:* Sec 3.2. |
| FR7 | **Drift Auto-Heal** | Monitor `unparsed_rate`. If >5% 5min: Hybrid Partition -> LUNAR LCU -> re-synth -> canary 1% -> promote. Banner. | SHOULD | *Why 5% 5m:* Avoid flapping on burst; SIH demo will inject 2% new field. |
| FR8 | **Dual Sink** | `normalized_logs` -> (1) SIEM adapter (Wazuh/Elastic) (2) MinIO Parquet (`s3://ulpf/year=...`) + ClickHouse `ulpf_events`. | MUST | *Why dual:* SIH `g` needs both SIEM + Lake; single sink loses marks. |
| FR9 | **Beautiful Unified Visibility** | Parser Studio: dark SIEM theme, split Raw vs OCSF table, search `src_ip, class_uid`, lineage graph `prev_event -> event`, health donut `parsed/unparsed`, alert filter `is_alert`. 60fps virtualized 100k rows. | MUST | *Why beautiful bespoke:* Panel said generic Grafana loses wow. Tailwind dark theme + D3 lineage is memorable in 2-min video. |
| FR10 | **AI/ML-Ready (Optional Tiny)** | Every event includes `enrichment: {geoip, threat_intel}` offline MMDB. Optional `embeddings: vector(384)` via `sentence-transformers/all-MiniLM-L6-v2` 15MB quantized (offline). Export Parquet. Auto-generate Sigma skeleton from `class_uid + observables`. | SHOULD | *Why offline MiniLM not GPT:* 15MB fits Docker air-gap; GPT would break `j`. Optional so team not blocked. |

---

## 6. Non-Functional Requirements

| ID | Requirement | Target | Measurement | Why This Target, Not Higher |
|----|-------------|--------|-------------|-----------------------------|
| NFR1 | Throughput | 100k in <30s on single vCPU (WASM 1.2M/sec extrapolated), billions/day via partition | `k6` replay + `lag` | *Why not 1B in demo:* Laptop cannot replay 1B; prove via partition math + Parquet tiering, not raw hardware. |
| NFR2 | Lossless | 100% — `rehydrate==original` | `pytest fuzz 100k` | No compromise — SIH `a` mandatory. |
| NFR3 | Determinism | Same line -> same `template_id` across restarts | `test_identical` | Forensic reproducibility `d`. |
| NFR4 | Air-Gapped | Single host, no internet, `docker compose up` from tar (`docker save` + ollama volume) | fresh VM no net | *Why tar not registry pull:* Registry pull fails air-gap; tar is SIH spec. |
| NFR5 | Latency | p99 <120ms ingest->sink | histogram | WASM 0.8µs dominates; network is rest. |
| NFR6 | Portability | `docker compose.yml` + `compose.airgap.yml`, amd64/arm64 | `buildx` | *Why not K8s:* K8s needs 3 nodes, overkill for SIH laptop. |
| NFR7 | Extensibility | New vendor <50 LOC YAML | LOC count | Proves `i`. |
| NFR8 | Security | WASM sandbox, YAML hash verify, no host FS | audit | Isolation. |

---

## 7. How We Will Use the Components

### 7.1 Ingestion (C5 Redpanda + Python Syslog)

* Syslog server `ulpf/ingest/syslog.py` (asyncio UDP/TCP 514) parses RFC3164/5424 envelope, emits `{timestamp, host, raw, ingest_time}` to Kafka `raw_logs` (partition by `host`).
* File poller watches `forge/output/*.log` for 100k synthetic.
* Backpressure: if `lag >10k`, ring 128MB `drop-oldest` with metric (visible). eBPF zero-copy is future upgrade, not demo requirement.

> **Decision: Redpanda vs Kafka vs NATS**
> *Why Redpanda:* Single binary KRaft vs Kafka 3 containers (ZK+broker+schema registry). NATS lacks durable replay needed for reprocessing. Redpanda's Kafka API keeps Python `kafka-python` unchanged while cutting air-gap size 200MB.

### 7.2 Synthesis + Parsing (C2 DeepParse + C3 LUNAR + C4 Drain + C6 WASM + C7 Ollama)

**Offline (install time, air-gapped safe):**
```bash
ulpf synth --vendor fortinet --input forge/output/fortinet.log --samples 50 --mode hf --adapter NightBaRron1412/deepparse-r1-8b
# -> artifacts/masks/fortinet.json
```
*Sampler:* entropy-greedy picks diverse 50 lines (not random). Prompt `You are regex synthesizer...` -> returns list validated via `re.compile` dedupe.

**Online (steady state):**
```
Raw -> WASM Registry (host/regex) -> MaskApplier (<IP>, <BLK_ID>) -> Drain depth5 -> {template_id, template, params}
```
*Why Mask-First:* Keeps tree shallow/stable. Learned masks like `blk_-?\d+` not hardcoded.

**Drift Path (C3):**
`unparsed_rate` monitored. Trigger -> `Hybrid Partition` (heuristic + embedding KMeans) -> `LCU search` -> second `synth_masks` -> canary. Human approves via UI.

> **Decision: Offline 50-sample synth vs Online per-line LLM vs Hand regex**
> *Why offline 50:* Beats 1000 random (DeepParse). Per-line LLM fails determinism+air-gap. Hand regex fails `i` (70% effort). Offline gives once-cost, forever-speed.

### 7.3 Normalization (C1 OCSF)

Mapper `ulpf/normalizer/mapper.py`:

```yaml
# parsers/fortinet.yaml
name: fortinet
version: 1.0.0
vendor: Fortinet
class_uid: 4001
detection: {host_pattern: "FGT.*", raw_contains: "logid="}
masks: "artifacts/masks/fortinet.json"
grok:
  - pattern: 'CEF:%{INT:cef_ver}\|%{DATA:vendor}\|... src=%{IP:src_ip} dst=%{IP:dst_ip}.*act=%{WORD:action}'
ocsf_map:
  src_ip: src_endpoint.ip
  dst_ip: dst_endpoint.ip
  action: {source: action, value_map: {accept: 1, deny: 2}}
enrichment: {geoip: true, threat_intel: "data/threat.csv"}
```
Enrichment offline `GeoLite2-City.mmdb` + `threat.csv`. Validated by `pydantic_ocsf.NetworkActivity`. `unmapped` + `raw` never dropped.

> **Decision: YAML not Python code**
> *Why:* 3-person Python team can still add Juniper in 15 min without touching `mapper.py`; UI edits YAML live and hot-reloads. Code per vendor would need PR + restart.

### 7.4 Lossless Traceability — Simple Hash Proof (Clarified from Q5)

Per event (simple, no blockchain):
```json
{
  "metadata": {"profiles": ["record_integrity"], "product": {"name": "ULPF", "version": "1.2"}},
  "unmapped": {"fortinet_logid": "0000000013"},
  "raw_data": "date=2026-09-19 ...",
  "raw_hash": "sha256:abc...",
  "attestation": {
    "chain_uid": "ulpf-perimeter-001",
    "prev_event": "sha256:prev-normalized",
    "digest": "sha256:this-normalized",
    "serialization": "JCS"
  }
}
```
`prev_event` is simple SHA of previous normalized for ordering (per partition), not Merkle tree. `GET /rehydrate/{id}` does `template + params + unmapped -> raw` and asserts `sha256(rehydrated)==raw_hash`.

> **Decision: Simple SHA + prev_event vs Merkle vs Blockchain**
> *Why simple:* SIH needs proof of no information loss (`rehydrate == raw`), not crypto anchoring. Simple SHA is 5 lines Python, explainable in 10s to judges, verifiable via `pytest`. Merkle/Blockchain would need 200 lines + consensus, confuse demo, add size for 100k. Keep simple but still use OCSF 1.9 field names for standard compliance.

### 7.5 Hot-Plugin (C6)

```python
# ulpf/parser/wasm_registry.py (wasmtime-py)
store = Store()
module = Module.from_file(store.engine, "parsers/fortinet.wasm")
instance = Instance(store, module, [])
# hot-reload: watch parsers/*.yaml, recompile, swap 200ms, keep old draining
```
Hash verified before load. Bad YAML increments `unparsed`, data plane stays up.

### 7.6 Dual Sink (C5 + C8) & Optional ML

* Fast: `Kafka normalized_logs` -> SIEM adapter `ulpf/sink/siem.py` (OCSF->CEF/JSON Syslog for Wazuh).
* Lake: `ulpf/sink/parquet.py` batches 10k -> Parquet Snappy -> MinIO `s3://ulpf/...` -> ClickHouse `MergeTree ORDER BY (time, class_uid)` 68% compressed.
* Optional ML (not core): After lake, `ulpf/ml/tiny_bert.py` loads `all-MiniLM-L6-v2` 15MB quantized, scores each OCSF event `anomaly_score`, sets `is_alert` if >threshold, writes back. Demo shows `is_alert=true` red badge.

> **Decision: Optional tiny downstream vs Core LogBERT**
> *Why optional:* ULPF is pre-processing fabric; anomaly is consumer. Forcing LogBERT in critical path couples stages and would require grouped sessions + GPU, breaking Docker easy setup for 3-person team. Tiny downstream proves `h` AI-ready without risking core `a-d`.

---

## 8. Tech Stack

| Layer | Choice | Python Lib / Image | Offline Size | Why This, Not That (1-liner) |
|-------|--------|-------------------|--------------|------------------------------|
| **Lang** | **Python 3.11 (Chosen)** | `python:3.11-slim` | — | Team is Python; Go/Rust would split expertise + slower SIH timeline |
| **API** | **FastAPI (Chosen)** | `fastapi`, `uvicorn` | 50MB | Async auto-docs; Flask sync, Django heavy |
| **Queue** | **Redpanda (Chosen)** | `redpanda/redpanda:v24.1` | 200MB | KRaft single binary; Kafka+ZK 3 containers, heavy for air-gap |
| **Parser** | **Drain3 + wasmtime-py (Chosen)** | `drain3`, `wasmtime==14.0` | 120MB | Deterministic + sandboxed; pure Python import no isolation |
| **Synth LLM** | **Ollama + R1-8B Q4 (Chosen)** | `ollama/ollama` + `r1-8b-q4` | 3.5GB | Offline 3.5GB; GPT-4 API needs internet, 70B needs 40GB RAM |
| **Schema** | **Pydantic OCSF 1.4 (Chosen)** | `pydantic==2.7` | 5MB | Validation; raw `jsonschema` slower, no IDE hints |
| **Enrich** | **GeoIP2 + CSV (Chosen)** | `geoip2`, `pandas` | 30MB | Offline MMDB; API lookup fails air-gap |
| **Store** | **Postgres 16 + MinIO + ClickHouse 24 (Chosen)** | `postgres:16`, `minio/minio`, `clickhouse/clickhouse-server` | 800MB | Columnar 68% save; ES 220$/TB + JVM heavy, Loki needs Prom, PG JSONB slow scan |
| **UI** | **React+Vite+Tailwind (Chosen)** | `node:20` -> `nginx:alpine` | 20MB | Beautiful bespoke per your ask; Streamlit Python but not beautiful, Grafana generic |
| **Forge** | **Faker + Jinja2 (Chosen)** | `faker`, `jinja2` | 10MB | Seeded reproducible 100k + drift; LogHub lacks perimeter CEF, real pcap needs hardware |
| **Orchestration** | **Docker Compose v2 (Chosen)** | `docker compose` | — | `docker compose up` easy per your ask; K8s needs 3 nodes overkill for SIH |

**Total Docker air-gapped tar:** `docker save` ~5.2GB (models dominate). With Q4 + ClickHouse tiny fits 4GB USB. Easy setup: one command on judge VM.

> **Decision: Docker Compose, not K8s or bare Python**
> *Why:* You asked Docker easy setup. K8s needs cluster, bare Python needs `pip install` env drift. Compose one command passes air-gapped test `fresh VM, no net, tar load, compose up`.

---

## 9. Architecture & Diagrams (DOT)

> All DOT render with `dot -Tpng diagram.dot -o diagram.png` or Obsidian Graphviz plugin.

### 9.1 System Context

![ULPF-SRS Diagram 1](./ULPF-SRS_diagram_1.png)

### 9.2 Component Diagram

![ULPF-SRS Diagram 2](./ULPF-SRS_diagram_2.png)

### 9.3 Sequence Diagram

![ULPF-SRS Diagram 3](./ULPF-SRS_diagram_3.png)

### 9.4 Class Diagram — OCSF Hybrid (Simple)

![ULPF-SRS Diagram 4](./ULPF-SRS_diagram_4.png)

### 9.5 State Diagram — Drift Heal

![ULPF-SRS Diagram 5](./ULPF-SRS_diagram_5.png)

---

## 10. Synthetic Log Forge — 100k Plan

### 10.1 Why Synthetic 100k Only

No hardware needed, reproducible seed 42, drift injection to demo auto-heal. Enough to prove `billion/day` via math (partition × compression) without judging needing 1B replay.

> **Decision: 100k synthetic vs Real pcap vs LogHub 2k only**
> *Why 100k synthetic:* LogHub lacks perimeter CEF/LEEF, real pcap needs appliance. Synthetic gives exact Fortinet Log Ref 7.4 `logid 00013` + Palo Alto TRAFFIC + Cisco 302013 bit-identical, plus throttle to inject `new_field` for drift test.

**Fixed Manifest (100k):**

| Vendor | Format | Count | Example File | Drift Injection |
|--------|--------|-------|--------------|-----------------|
| Fortinet | CEF + Syslog | 20k | `forge/output/fortinet_cef.log` | — |
| Palo Alto | CSV TRAFFIC | 20k | `forge/output/paloalto.log` | — |
| Cisco ASA | Syslog 302013 | 20k | `forge/output/cisco_asA.log` | +2% new `policy_id` |
| Juniper SRX | LEEF | 20k | `forge/output/juniper.log` | — |
| Checkpoint | JSON Exporter | 10k | `forge/output/checkpoint.json` | — |
| Zscaler | NSS JSON | 10k | `forge/output/zscaler.json` | — |
| **Total** | **5 formats** | **100k** | **forge/output/** | **2% triggers heal** |

### 10.2 Templates Source
Fortinet 7.4 `00013`, Palo Alto CEF, Cisco ASA `302013/302014/106023`, Juniper `RT_FLOW`, Checkpoint Exporter, Zscaler NSS — vendor docs + LogHub2 patterns.

### 10.3 Generator Design

```python
# ulpf/forge/generator.py (Jinja + Faker) — Why Jinja+ Faker not raw random: templates guarantee CEF validity; Faker gives real ip dist
from faker import Faker; from jinja2 import Template
fake = Faker(); fake.seed_instance(42)
tpl = Template("CEF:0|Fortinet|Fortigate|7.2|00013|traffic:forward|3|src={{src}} dst={{dst}} act={{act}} bytes={{bytes}}")
for i in range(100_000):
    print(tpl.render(src=fake.ipv4_private(), dst=fake.ipv4_public(), act="accept" if i%3 else "deny", bytes=fake.random_int(64, 1500)))
```

CLI:

```bash
python -m ulpf.forge --count 100k --seed 42 --manifest forge/manifest.json --out forge/output/
cat forge/output/*.log | nc -u localhost 514   # syslog path
# or file poll: tail -f forge/output/*.log
```

### 10.4 Example: Raw vs Normalized (100k row)

**Raw CEF:**
```
CEF:0|Fortinet|Fortigate|7.2|00013|traffic:forward|3|src=10.0.0.5 dst=8.8.8.8 spt=52321 dpt=443 act=accept proto=6 cnt=1
```

**Normalized OCSF 4001:**

```json
{
  "class_uid": 4001, "category_uid": 4, "time": 1726740000000, "activity_id": 1, "severity_id": 1,
  "src_endpoint": {"ip": "10.0.0.5", "port": 52321}, "dst_endpoint": {"ip": "8.8.8.8", "port": 443},
  "connection_info": {"protocol_num": 6}, "metadata": {"product": {"name": "FortiGate"}, "profiles": ["record_integrity"]},
  "unmapped": {"cef_version": "0"}, "raw_data": "CEF:0|Fortinet|...", "raw_hash": "sha256:abc...", "attestation": {"chain_uid": "ulpf-001", "prev_event": "sha256:prev...", "digest": "sha256:this...", "serialization": "JCS"}
}
```

---

## 11. Data Design

### 11.1 OCSF Hybrid Choice

Base = **OCSF 1.4.0** required + **1.9** `record_integrity` simple SHA fields. We add `raw_data` + `raw_hash` + `unmapped` via `vendor_attributes` — stays valid OCSF (validator `schema.ocsf.io`).

> **Decision: OCSF hybrid vs ECS vs Pure raw keep vs Loki labels**
> *Why hybrid:* Pure raw loses analytics; pure OCSF loses forensics; hybrid does both in one record, judge can validate. ECS ties to Elastic, Loki labels poor for ML.

### 11.2 Schema Evolution

Extensions `extensions/perimeter/*.json` versioned. New field -> `unmapped` unless promoted. Ajv validates.

> **Decision: Ajv + Pydantic vs No validation**
> *Why validate:* Reject bad mapping before sink, catches drift early. No validation would sink corrupt OCSF to SIEM.

### 11.3 Validation

```python
class ULPFEvent(NetworkActivity):
    raw_data: str
    raw_hash: str  # SHA256 hex
    unmapped: dict = {}
    attestation: Attestation | None
```

Great Expectations `expect_table_row_count_to_equal_other_table` for `raw==normalized`.

### 11.4 AI/ML-Ready (Optional Tiny)

* Parquet `year/month/day/hour` for Spark/ClickHouse.
* Offline GeoIP + threat CSV (no API).
* Optional 384-d MiniLM-L6-v2 15MB quantized (offline) -> `embeddings` for KNN anomaly, sets `is_alert`.
* Sigma skeleton:
```yaml
title: Fortinet Deny Burst
logsource: {product: fortigate, category: network}
detection: {selection: {class_uid: 4001, activity_id: 2, src_endpoint.ip|cidr: '10.0.0.0/8'}, condition: selection | count() > 100}
```

> **Decision: Offline MiniLM 15MB vs GPT API vs No ML**
> *Why offline mini:* Fits Docker air-gap; GPT breaks `j`. No ML loses `h` marks. Optional keeps risk low.

---

## 12. Interface Specification & Beautiful UI

### 12.1 API

| Interface | Method | Payload | Notes | Why This Interface |
|-----------|--------|---------|-------|--------------------|
| `POST /api/v1/ingest` | HTTP | `{"host":"fgt01","raw":"CEF:0|..."}` | Forge demo | *Why POST not only Syslog:* File can be `curl` from forge, Syslog needs `nc` — both for demo flexibility |
| `POST /api/v1/parsers` | HTTP | YAML multipart | Validate+WASM 200ms | *Why multipart:* YAML file upload with hash, easy `curl -F` |
| `GET /api/v1/parsers` | HTTP | list health | — | Health dashboard |
| `GET /api/v1/trace/{id}` | HTTP | OCSF+prev/next | D3 graph | Lineage `d` |
| `POST /api/v1/rehydrate/{id}` | HTTP | `{"match":true}` | Proof `a` | Simple hash proof |
| `GET /api/v1/health` | HTTP | `{"lag":0,"parsers":6}` | Liveness | *Why not Prom only:* Judge can `curl` without Prom setup |
| `Kafka raw_logs/normalized_logs` | Kafka | JSON | 3/6 partitions | Replay |
| `MinIO s3://ulpf/` | S3 | Parquet Snappy 10k batch | Lake | *Why 10k:* Balances flush latency vs S3 PUT cost |
| `Syslog 514` | UDP/TCP | RFC5424 | Primary | Perimeter devices native |

Auth demo none (air-gapped), prod `X-API-Key`.

### 12.2 Beautiful UI Spec (React+Vite+Tailwind)

**Why React vs Streamlit/Grafana:**
*Streamlit:* Python quick but not beautiful, poor 100k virtualization, limited D3. *Grafana:* Generic SIEM, not parser studio (no YAML tester, no rehydrate proof). *React:* Bespoke dark SIEM theme, 60fps virtualized table (`tanstack-virtual`), split-pane, D3 lineage, judge wow in 2-min video.

**Layout:**
*Top Bar:* `ULPF • 100k/100k parsed • Health donut 98/2` amber drift banner if `unparsed>5%`.
*Left 60%:* Monospace Raw log list (CEF highlight) virtualized, search `src_ip, logid`. Click -> Right.
*Right 40%:* OCSF table (field: value) + badges `class 4001, allow/deny, severity`. Bottom `Unmapped` JSON collapsed.
*Bottom:* D3 lineage `prev_event -> event -> next` (draggable), `Rehydrate` button shows `SHA match ✓` green tick.
*Parsers Tab:* YAML editor + `Test` button: paste raw -> live OCSF diff green/red.

Colors: `bg-slate-900, card slate-800, accent blue-500, deny red-500, allow green-500, alert amber`.

---

## 13. Verification & Traceability

### 13.1 Test Matrix

| Test | Command | Pass Criteria | Maps to | Why This Test Proves Not Generic |
|------|---------|---------------|---------|-----------------------------------|
| Rehydrate | `pytest tests/test_lossless.py -k rehydrate --count=100k` | `raw==rehydrated` 100k fuzz hash match | a,d | Generic teams skip rehydrate proof |
| Determinism | `pytest tests/test_drain_masks.py::test_identical` | same line -> same id 3 runs | b | Generic LLM non-deterministic fails this |
| Hot-Plugin | `curl -F file=@juniper.yaml /parsers; sleep 0.3; kcat` | v2 in <500ms no restart lag0 | e,i | Generic needs restart, fails |
| Drift | `forge --drift new_field; watch unparsed` | LCU triggers canary promote | c,i | Generic manual update only |
| Dual Sink | `clickhouse-client --query "select count() from ulpf_events"` | kafka==parquet==pg | g | Generic only SIEM, no lake |
| Air-Gapped | `fresh VM no net, tar load, compose up, pytest` | all pass offline | j,k | Generic GPT API fails |
| Scale | `k6 run bench/replay.js 100k 60s` | 100k p99 <120ms 0 drops 68% compress | f,h | Generic no bench |

### 13.2 Demo Checklist (2 min Beautiful)

0-20s Problem 5 dialects -> 20-60s Live 100k ingest (forge -> Redpanda counter) -> 60-85s Add Juniper YAML hot -> 85-110s Beautiful split + D3 lineage + rehydrate green tick + healthy donut -> 110-120s `docker compose up` + beautiful dark UI reveal + Sigma auto-gen.

---

## 14. References

> All Sep 2026. Primary sources, not blogs.

1. OCSF 1.4.0 — `https://schema.ocsf.io/1.4.0/` & Release `https://github.com/ocsf/ocsf-schema/releases/tag/1.4.0` (2025-02-05).
2. OCSF 1.8 — `tag/1.8.0` (Mar 16 2026) — `ai_operation`.
3. OCSF 1.9 — `tag/1.9.0` — `record_integrity`.
4. OCSF Docs v1.17 Apr 2026 — `github.com/ocsf/ocsf-docs/blob/main/overview/understanding-ocsf.md`.
5. DeepParse — Shetaia & Kauffman, *Hybrid Log Parsing...*, EASE 2026 — `arxiv:2604.20553` & `NightBaRron1412/DeepParse` (97.6% PA, 100×).
6. LUNAR — Huang et al., *No More Labelled Examples?* ACM 2025-06 `doi:10.1145/3729377`.
7. Parse-LLM — *Prior-Free LLM Parser*, CIKM 2024 `doi:10.1145/3746252.3761363`.
8. LLM-SrcLog — `arxiv:2512.04474` — 1000× faster than per-line.
9. Drain — He et al., IEEE ICWS 2017.
10. Vector 0.40 WASM 2.0 — Johal 2026-05-03 `johal.in` — 1.2M/sec/vCPU 400μs.
11. Wasm-bpf — `arxiv:2408.04856v1` & `eunomia-bpf/wasm-bpf`.
12. Fluent Bit WASM — Chronosphere 2024-09-05.
13. Loki 3.0 + Fluent Bit 3.0 — Johal 2026-04-29 — 10.2GB/s 68% save.
14. LogHub 2.0 — `logpai/loghub`.
15. Vendor Docs — FortiOS 7.4 Log Ref, Palo Alto CEF, Cisco ASA Syslog.
16. SecBPMN2 Hybrid — Islam et al., *Hybrid LLM-Based Framework...*, `arxiv:2608.14370v1` — hybrid philosophy (BPMN domain, not log parsing, cited as related).
17. IEEE Lightweight Hybrid — *Lightweight Hybrid Framework for Semantic Normalization of Security Events*, IEEE Euromicro `11626222` — supports lightweight hybrid beats heavy transformer (title only, paywalled).
18. LogBERT — Guo et al., *Log Anomaly Detection via BERT*, IJCNN 2021 `10.1109/ijcnn52387.2021.9534113`; ADALog hybrid 2025 — downstream option, not core parser (why not core: see 3.4).

---

## 15. Appendices

### A. Sample Parser YAML — Fortinet (<50 LOC)

```yaml
# parsers/fortinet.yaml
name: fortinet
version: 1.2.0
vendor: Fortinet
class_uid: 4001
detection: {host_pattern: "FGT.*", raw_contains: "logid="}
masks: "artifacts/masks/fortinet.json"  # offline R1-8B
grok:
  - pattern: 'CEF:%{INT:cef_ver}\|%{DATA:vendor}\|%{DATA:product}\|%{DATA:ver}\|%{DATA:logid}\|%{DATA:msg}\|%{INT:sev}\|src=%{IP:src_ip} dst=%{IP:dst_ip}.*act=%{WORD:action}'
  - pattern: 'date=%{DATE:date} time=%{TIME:time} .*srcip=%{IP:src_ip} dstip=%{IP:dst_ip}.*action=%{WORD:action}'
ocsf_map:
  src_ip: src_endpoint.ip
  dst_ip: dst_endpoint.ip
  action: {source: action, value_map: {accept: 1, deny: 2}}
  bytes: connection_info.bytes
enrichment: {geoip: true, threat_intel: "data/threat.csv"}
```

### B. Compose (Docker Easy + Air-Gapped)

```yaml
# compose.yaml
services:
  redpanda: {image: redpanda/redpanda:v24.1, ports: ["9092:9092"]}
  ulpf-api: {build: ., ports: ["8000:8000"], depends_on: [redpanda, postgres, minio], volumes: ["./parsers:/app/parsers", "./artifacts/masks:/app/artifacts/masks"]}
  ollama: {image: ollama/ollama, volumes: ["ollama_models:/root/.ollama"]}
  postgres: {image: postgres:16, environment: {POSTGRES_DB: ulpf}}
  minio: {image: minio/minio, command: server /data}
  clickhouse: {image: clickhouse/clickhouse-server:24}
  ui: {build: ./ui, ports: ["3000:80"]}
# air-gapped: docker save redpanda ollama postgres minio clickhouse ulpf-api -o ulpf-airgap.tar
# on build host: ollama pull deepseek-r1:8b; docker compose up
```

### C. Glossary (1-liner)

* **OCSF 4001** = Network Activity; 4003 = HTTP; 4005 = DNS — category 4.
* **Mask-First** = replace vars before tree, stable templates.
* **WASM hot-reload** = swap parser 200ms no restart.
* **Simple hash** = SHA256(raw) proof, no blockchain.

### D. Master Decision Log (Copy for 2-Pager)

See Sec 3.3 table — print that alone for judges.

---

**Next Steps for 3:**
1. Dev A: `ulpf/parser/drain_engine.py` + `synth_masks` (DeepParse port).
2. Dev B: `ulpf/normalizer/mapper.py` + simple hash + dual sink + Docker.
3. Dev C: `ulpf/forge/` 100k + beautiful UI (React dark) + bench.

*Render DOT:* `for f in *.dot; do dot -Tpng $f -o $f.png; done` or https://dreampuf.github.io/GraphvizOnline/ . Edit directly in Obsidian — provenance in `.wiki-meta.json` hidden.
