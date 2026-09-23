# Software Requirements Specification (SRS)
# Universal Log Pre-processing Framework (ULPF)

**Problem Statement:** SIH26156 (NTRO)  
**Team Stack:** Python, React, WASM  

---
## 1 Introduction

### 1.1 Purpose
This document specifies the software requirements and architecture for the Universal Log Pre-processing Framework (ULPF). The system converts any perimeter network device log into a standardized, lossless, analytics-ready OCSF representation for SIEM and data lake platforms.

### 1.2 Scope
*   **In-Scope Devices:** Perimeter hardware (Cisco ASA, Juniper SRX, Palo Alto NGFW, Fortinet FortiGate, Checkpoint, Proxy, VPN).
*   **Supported Formats:** Syslog (RFC3164/5424), JSON, CSV, CEF, LEEF.
*   **Key Capabilities:** Deterministic parsing, offline LLM mask synthesis, OCSF normalization, lossless simple-hash traceability, air-gapped deployment.
*   **Validation Method:** 100k EPS Synthetic Log Forge (to prove scale without requiring physical firewall hardware).

### 1.3 Definitions & Acronyms
*   **OCSF:** Open Cybersecurity Schema Framework.
*   **Drain3:** Fixed-depth tree log parser for deterministic, high-speed execution.
*   **WASM:** WebAssembly — sandboxed, hot-reloadable runtime for parsers.
*   **LCU:** Log Contrastive Unit — a group of logs differing only in parameters.
*   **Air-Gapped:** Deployable with zero internet egress (all models vendored).

---

## 2. System Architecture (The "Fabric")

The ULPF is designed as a high-throughput data fabric, separated into three distinct planes:

1.  **Data Plane:** Ingestion → WASM Registry → Drain3 → OCSF Mapper → Hasher → Dual Sink.
2.  **Control Plane:** FastAPI Backend + React Parser Studio UI.
3.  **Synthesis Plane (Offline):** Local LLM (DeepSeek-R1-8B) for one-time parser mask generation.

### 2.1 System Context & Data Flow

![ULPF_SRS2 Diagram 1](./ULPF_SRS2_diagram_1.png)

### 2.2 Component Architecture

![ULPF_SRS2 Diagram 2](./ULPF_SRS2_diagram_2.png)

---

## 3. Core Design Decisions (Why This, Not That)

| Component | Chosen Technology | Why This? | Rejected Alternative (Why Not?) |
| :--- | :--- | :--- | :--- |
| **Parser Engine** | **DeepParse (Drain3 + LLM Offline)** | Deterministic O(N) speed, air-gap safe. LLM is only used once per format to generate masks. | *Per-line LLM:* 100x slower, non-deterministic, violates air-gap requirement. |
| **Schema** | **OCSF 1.9.0 Hybrid** | Vendor-neutral industry standard. Supports `record_integrity` attestation for forensics. | *ECS/Splunk CIM:* Creates vendor lock-in, violating PS generalization goal. |
| **Integrity Proof** | **Simple Hash Chain (`prev_event`)** | Meets PS lossless requirement, extremely fast, easily explainable to judges in 10s. | *Merkle Trees/Blockchain:* Over-engineered for demo, adds unnecessary latency. |
| **Queue** | **Redpanda** | Single binary, KRaft mode. Kafka API compatible but 200MB footprint. | *Apache Kafka:* Needs 3 containers (ZooKeeper), too heavy for 16GB laptops. |
| **Plugins** | **WASM (`wasmtime-py`)** | Memory-sandboxed. Bad parser YAML cannot crash the pipeline. Hot-reloads in 200ms. | *Native Python Plugins:* A crash in a custom parser kills the entire ingestion pipeline. |
| **Database** | **ClickHouse + MinIO** | Columnar storage saves 68% space. 10x faster scans for analytics. | *Elasticsearch:* JVM requires 2-4GB RAM, inverted index bloats storage. |
| **Demo Setup** | **Synthetic Forge (Faker+Jinja)** | Generates 100k EPS locally without needing physical firewall hardware. | *Real PCAPs:* Hardware intensive, difficult to inject drift for auto-heal demo. |

---

## 4. Functional Requirements

### 4.1 Ingestion & Queueing
*   **FR-ING-01:** System SHALL accept logs via Syslog UDP/TCP (RFC3164/5424), HTTP POST, and file polling.
*   **FR-ING-02:** System SHALL buffer incoming raw logs in a durable Redpanda queue to handle burst backpressure.
*   **FR-ING-03:** System SHALL provide a Synthetic Forge to generate up to 100k EPS of realistic CEF/Syslog data for 5 vendors (Fortinet, Palo Alto, Cisco, Juniper, Checkpoint).

### 4.2 Parsing (Neuro-Symbolic)
*   **FR-PAR-01:** System SHALL execute parsing deterministically using a fixed-depth (depth=5, sim=0.4) Drain3 tree.
*   **FR-PAR-02:** System SHALL support offline LLM mask synthesis (`synth_masks`), generating regex masks from 50 entropy-sampled logs.
*   **FR-PAR-03:** System SHALL hot-reload parser plugins in a WASM sandbox without pipeline restarts (<200ms swap time).
*   **FR-PAR-04:** System SHALL trigger drift auto-healing (via LUNAR Log Contrastive Units) when the `unparsed_rate` exceeds 5% over 5 minutes.

### 4.3 Normalization & OCSF
*   **FR-NRM-01:** System SHALL map parsed fields to OCSF v1.9.0 (e.g., Class 4001 Network Activity).
*   **FR-NRM-02:** System SHALL retain 100% of the original log in the `raw_data` field and unparsed attributes in the `unmapped` dictionary.

### 4.4 Traceability & Integrity
*   **FR-INT-01:** System SHALL compute a SHA-256 hash of the raw log (`raw_hash`).
*   **FR-INT-02:** System SHALL chain events using the `prev_event` hash (simple hashing) using OCSF's `record_integrity` profile to guarantee forensic sequencing.
*   **FR-INT-03:** System SHALL expose a `/rehydrate` API that rebuilds the raw log from the normalized fields and mathematically proves zero data loss (`hash(rehydrated) == raw_hash`).

### 4.5 Storage & UI
*   **FR-STR-01:** System SHALL output a dual-sink: (1) SIEM-ready JSON via Kafka, (2) 10k-event Parquet batches to MinIO/ClickHouse.
*   **FR-UI-01:** System SHALL provide a bespoke React/Vite/Tailwind dashboard featuring a 60fps virtualized log view, D3.js lineage trace graphs, and a real-time EPS health donut.

---

## 5. Non-Functional Requirements

*   **NFR-01 (Throughput):** 100,000 EPS sustained on a single vCPU (extrapolated via WASM performance logic) with 10k batching.
*   **NFR-02 (Latency):** p99 latency < 120ms from ingestion to SIEM queue.
*   **NFR-03 (Air-Gapped):** System MUST deploy via `docker compose up` from a pre-loaded `.tar` file with zero outbound internet connections (Ollama LLM runs locally).
*   **NFR-04 (Lossless):** 100% accuracy on raw rehydration (`pytest fuzz 100k` = 0 errors).
*   **NFR-05 (Determinism):** Same log line must yield the exact same `template_id` across restarts.

---

## 6. Verification & Traceability (Demo Strategy)

To ensure maximum points from the SIH evaluation jury, the demo will follow this exact sequence:

| Capability to Prove | Demo Action | Pass Criteria |
| :--- | :--- | :--- |
| **High Throughput** | Run Synthetic Forge (`k6 run bench.js`). | Dashboard shows 100k EPS; CPU remains stable; Redpanda lag stays low. |
| **Lossless Traceability** | Click "Rehydrate" on a normalized OCSF event in the UI. | Green checkmark appears showing `rehydrated_hash == original_raw_hash`. |
| **Plug & Play** | Upload `juniper.yaml` via Parser Studio UI. | Pipeline begins parsing Juniper logs in <500ms with zero system restart. |
| **Drift Auto-Heal** | Inject 2% mutated logs (new `policy_id`) via Forge. | UI shows amber alert; LLM triggers in background; canary promotes new mask. |
| **Air-Gapped** | Disconnect host Wi-Fi before starting Docker Compose. | All services (including LLM mask synthesis) operate perfectly offline. |
