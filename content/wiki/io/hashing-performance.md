---
title: "Hashing Performance — Collision Resolution Techniques Compared"
type: synthesis
tags: [systems, data-structures]
created: 2026-04-30
updated: 2026-04-30
---

## Framing

Compare four collision resolution techniques for hash tables: **separate chaining**, **linear probing**, **quadratic probing**, and **double hashing** — analyzing their performance, clustering behavior, and practical trade-offs.

## Comparison

| Technique | Best Case | Average Case | Worst Case | Clustering | Deletion |
| --- | --- | --- | --- | --- | --- |
| **Separate Chaining** | O(1) | O(1) | O(n) | None | Easy |
| **Linear Probing** | O(1) | O(1) | O(n) | Primary clustering | Tombstones |
| **Quadratic Probing** | O(1) | O(1) | O(n) | Secondary clustering | Tombstones |
| **Double Hashing** | O(1) | O(1) | O(n) | Minimal | Tombstones |

## Key Insights

1. **Separate chaining is simplest** — each slot has a linked list; performance depends on chain length (load factor α)
2. **Linear probing causes primary clustering** — long runs of occupied slots form, increasing probe lengths
3. **Quadratic probing reduces primary clustering** but causes secondary clustering (same initial hash = same probe sequence)
4. **Double hashing is best** — different step size per key eliminates most clustering, probes all slots if table size is prime
5. **Load factor α ≤ 0.7** is critical — all methods degrade rapidly above this threshold
6. **Open addressing (probing) uses less memory** (no linked list pointers) but requires more careful load factor management

## Synthesis

The choice depends on use case: **separate chaining** for simplicity and easy deletion; **double hashing** for best theoretical performance; **linear probing** only for very low load factors. All methods require good hash functions and load factor monitoring.

## Connections

- [[hashing|Hashing]] — the fundamental technique
- [[separate-chaining|Separate Chaining]] — linked lists at each slot
- [[linear-probing|Linear Probing]] — probe next slot
- [[quadratic-probing|Quadratic Probing]] — probe with i² skip
- [[double-hashing|Double Hashing]] — two hash functions
- [[load-factor|Load Factor]] — critical for all methods
- [[hash-function|Hash Function]] — quality affects all methods