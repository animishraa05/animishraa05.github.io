---
title: "Semaphore Types — Binary vs Counting Semaphores Compared"
type: synthesis
tags: [systems, concurrency]
created: 2026-04-30
updated: 2026-04-30
---

## Framing

Compare **binary semaphores** (mutex) versus **counting semaphores** (resource pools) — their use cases, behavior, and when to use each.

## Comparison

| Feature | Binary Semaphore | Counting Semaphore |
| --- | --- | --- |
| **Values** | 0 or 1 only | 0 to N (N = resource count) |
| **Use Case** | Mutual exclusion (critical section) | Resource pool management |
| **Initial Value** | 1 (unlocked) | N (available resources) |
| **Negative Value** | Never negative | Negative = number of waiters |
| **Example** | File lock, mutex | Buffer slots, printer pool |

## Key Insights

1. **Binary semaphore = mutex** — ensures only one process enters critical section
2. **Counting semaphore = resource counter** — tracks pool of identical resources
3. **Both use same wait()/signal() operations** — the difference is initialization and interpretation
4. **Binary semaphores can be implemented with counting** (just set N=1), but not vice versa
5. **Classic use: producer-consumer** — uses counting (empty, full) + binary (mutex)
6. **Priority inversion** affects both types — high-priority process blocked by lower-priority holder

## Synthesis

Binary semaphores are a special case of counting semaphores (N=1). Use **binary for mutual exclusion**, **counting for resource pools**. The producer-consumer problem elegantly combines both: counting semaphores (empty, full) manage buffer slots, while a binary semaphore (mutex) protects the buffer data structure.

## Connections

- [[semaphore|Semaphore]] — the general concept
- [[binary-semaphore|Binary Semaphore]] — mutex use case
- [[counting-semaphore|Counting Semaphore]] — resource pool use case
- [[producer-consumer|Producer-Consumer Problem]] — uses both types
- [[mutex|Mutex]] — binary semaphore synonym
- [[wait-operation|wait() Operation]] — used by both
- [[signal-operation|signal() Operation]] — used by both
