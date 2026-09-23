# ULPF-SRS.md - Master Q&A, Edge Cases & Counters
**Purpose:** This document contains all potential edge cases, critical questions, and robust engineering counters that judges or teammates might raise regarding the Universal Log Pre-processing Framework (ULPF) architecture.

---

## 🛡️ 1. Security & Evasion Edge Cases

### Edge Case 1.1: The 4.9% Evasion Attack (Drift Threshold Evasion)
**The Problem:** The system triggers AI auto-heal only when `unparsed_rate > 5%`. A smart attacker sends malicious, unmappable logs at a rate of 4.9%. The AI never wakes up, logs go to the `unmapped` bucket, and SIEM alerts (monitoring OCSF mapped fields) miss them.
**The Counter:**
1. **Dual-Condition Trigger:** We don't rely only on percentage. Trigger = `(unparsed_rate > 5%) OR (unparsed_count > 10,000 per min)`.
2. **IoC on 'Unmapped':** The SIEM has a specific rule: A sudden spike in `unmapped` data from a specific IP is flagged as an Indicator of Compromise (IoC).
3. **LUNAR Density Clustering:** LUNAR runs unsupervised clustering. Even below 5%, if a dense cluster of identical new malformed logs appears, LUNAR flags it as a structural anomaly.
**🗣️ Pitch for Judges:** *"Sir, attackers trying to hide under the 5% radar will trigger our absolute count threshold or our SIEM 'Unmapped Spike' alert. Furthermore, our LUNAR algorithm detects dense anomalous clusters regardless of percentage."*

---

## 🚀 2. Scale & Distributed Systems Edge Cases

### Edge Case 2.1: Hash Chaining Race Conditions (Distributed Order Loss)
**The Problem:** We use `prev_event` to chain hashes for lossless traceability. In a distributed Redpanda queue with multiple partitions and consumers, logs process concurrently. How do you prevent race conditions and maintain strict ordering for the chain?
**The Counter:**
1. **Deterministic Partitioning:** We set the Partition Key = `Device_IP` (e.g., `fortinet-10.0.0.5`). Redpanda guarantees all logs from that IP go to exactly *one* partition.
2. **Strict FIFO:** Redpanda guarantees strict First-In-First-Out ordering *within a single partition*.
3. **Single Thread Isolation:** One partition is processed by exactly one WASM consumer thread. That thread holds the `last_processed_hash` in memory. No locks, no race conditions.
**🗣️ Pitch for Judges:** *"We use deterministic partition routing by Device IP. Because Redpanda guarantees strict FIFO per partition and binds one thread per partition, logs from a specific firewall are hashed purely sequentially. No distributed race conditions can occur."*

### Edge Case 2.2: The DDoS Buffer Drop (Data Loss vs. Backpressure)
**The Problem:** The SRS mentions a 128MB ring buffer (`drop-oldest`). In a massive DDoS attack (500k EPS), a 128MB RAM buffer fills in <1 second. New logs force old logs to drop before hashing. This breaks the "Zero Data Loss" promise.
**The Counter:**
1. **Disk-Backed Retention:** In a true production setup, Redpanda is configured to spill over to fast NVMe storage rather than just dropping from RAM.
2. **Decoupling Ingestion:** Ingestion (Syslog) to Redpanda is decoupled from parsing. The queue absorbs the shock while parsers scale up.
**🗣️ Pitch for Judges:** *"For the 100k demo, a ring buffer suffices. In production, we configure Redpanda with NVMe disk-backed retention to absorb massive DDoS spikes without dropping a single log before hashing."*

---

## 🧠 3. AI & Parsing Edge Cases

### Edge Case 3.1: LLM Hallucinations (Silent Data Corruption)
**The Problem:** DeepSeek-R1-8B hallucinates and creates an overly greedy regex mask (e.g., `.*`) that swallows multiple fields into one. The WASM parser accepts it, `unparsed_rate` drops to 0%, but the data in the Data Lake is garbage.
**The Counter:**
1. **Human-in-the-loop (Canary Phase):** Blind automation is dangerous. The AI synthesizes the mask, but it is put in a "Canary" state in the Parser Studio UI.
2. **Live YAML Tester:** An analyst tests the new mask against a sample of the unparsed logs inside the UI. Only after verifying the diff (green/red highlights) does the analyst click 'Deploy'.
**🗣️ Pitch for Judges:** *"We do not blindly trust LLMs in production. The AI does the heavy lifting of writing the regex, but it must pass a human-in-the-loop Canary test in our UI before hot-reloading into WASM."*

### Edge Case 3.2: WASM Cold Start & Overhead
**The Problem:** Hot-reloading a parser takes time. If the WASM binary is too large, compiling and swapping it might cause a latency spike, backing up the Redpanda queue.
**The Counter:**
1. **Pre-compiled Caching:** The YAML is converted to WASM and cached. The swap happens in <200ms.
2. **Sandboxed Memory:** WASM limits memory to 8MB per instance. A bad parser regex cannot infinitely loop and cause an Out-Of-Memory (OOM) crash on the host.

---

## 🔌 4. Deployment & SIH Rule Edge Cases

### Edge Case 4.1: Air-Gap Strictness (Model Loading)
**The Problem:** SIH explicitly requires solutions to run without internet (Air-gapped). Running an LLM usually requires an API key (OpenAI) or downloading massive weights at runtime.
**The Counter:**
1. **Quantized Models:** We use `DeepSeek-R1-8B Q4` via Ollama. The model is quantized to 3.5GB.
2. **Docker Tarball:** The entire stack (including the LLM weights and Redpanda binary) is packaged using `docker save` into a single `.tar` file. On a fresh judge VM, we `docker load` and `docker compose up` with zero egress.

### Edge Case 4.2: Proving 1 Billion Logs/Day
**The Problem:** A laptop cannot process 1 billion logs per day in a 2-minute demo. How do we prove scalability without the hardware?
**The Counter:**
1. **The Math Proof:** We demonstrate 100k EPS on a single core using WASM and the Synthetic Forge. We extrapolate: `100k EPS * 60s * 60m * 24h`.
2. **Storage Proof:** We show ClickHouse compressing Parquet files by 68%, mathematically proving that storing 1B logs won't exhaust standard enterprise disk space.
