---
title: Open Questions
tags: [meta, open-questions]
updated: 2026-04-11
---

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

### Strings / Character Hashing

- **What is the exact performance crossover point where a hash map becomes faster than a frequency array?** — raised by [[strings/strings-summary|Strings (Character Hashing in C++)]]. Related: [[strings/frequency-array|Frequency Array]], [[strings/unordered-map-frequency|Unordered Map for Frequency Counting]]. Status: open
- **How do modern C++ hash map implementations (Abseil flat_hash_map, folly F14) change the array-vs-map tradeoff?** — raised by [[strings/strings-summary|Strings (Character Hashing in C++)]]. Related: [[strings/hash-map-flexibility|Hash Map Flexibility]], [[strings/hash-collision-overhead|Hash Collision Overhead]]. Status: open
- **For very large alphabets (Unicode full range), what is the most memory-efficient frequency counting approach?** — raised by [[strings/strings-summary|Strings (Character Hashing in C++)]]. Related: [[strings/known-range-assumption|Known Range Assumption]], [[strings/memory-efficiency-array|Memory Efficiency of Array]]. Status: open
- **How does the two-phase paradigm (store-then-query) generalize beyond frequency counting?** — raised by [[strings/strings-summary|Strings (Character Hashing in C++)]]. Related: [[strings/two-phase-hashing|Two-Phase Hashing Paradigm]]. Status: open

### Operating Systems

- **How do modern kernel-bypass technologies (io_uring, DPDK) reshape the traditional user/kernel mode tradeoff?** — raised by [[os/os-summary|OS Source Summary]]. Related: [[os/system-calls|System Calls]], [[os/kernel-mode|Kernel Mode]], [[os/mode-switching|Mode Switching]]. Status: open
- **Can the safety guarantees of microkernels be achieved without the IPC performance penalty using hardware acceleration?** — raised by [[os/os-summary|OS Source Summary]]. Related: [[os/microkernel|Microkernel]], [[os/monolithic-kernel|Monolithic Kernel]], [[os/inter-process-communication|Inter-Process Communication]]. Status: open
- **Why did true distributed OSes (Plan 9) fail to gain adoption while pseudo-distributed systems (Kubernetes) thrive?** — raised by [[os/os-summary|OS Source Summary]]. Related: [[os/distributed-operating-system|Distributed Operating System]]. Status: open
- **How do modern CPU vulnerabilities (Spectre, Meltdown, MDS) change the security calculus for kernel architecture design?** — raised by [[os/os-summary|OS Source Summary]]. Related: [[os/kernel|Kernel]], [[os/cpu-privilege-rings|CPU Privilege Rings]], [[os/security-and-protection|Security and Protection]]. Status: open

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

- **Open questions:** 11 (7 + 4 new)
- **Under investigation:** 0
- **Answered:** 0

_This file grows deliberately. Don't let it accumulate without pursuing answers._
