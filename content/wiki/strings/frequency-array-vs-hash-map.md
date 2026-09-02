---
title: Frequency Array vs Hash Map — Character Hashing Tradeoffs
type: comparison
tags: [dev, hashing]
created: 2026-07-05
updated: 2026-07-05
---

## Framing

When solving character frequency problems, the first implementation decision is: frequency array (`int freq[26]`) or hash map (`unordered_map<char,int>`)? Both are O(1) for access, both solve the same Phase 1 problem, but they differ significantly in performance, memory, flexibility, and determinism. This synthesis compares them across the dimensions that matter in coding interviews and competitive programming.

## Comparison

| Dimension | Frequency Array | Hash Map |
|---|---|---|
| **Access time** | True O(1) — single CPU instruction | Average O(1) — hash + possible chain walk |
| **Worst-case** | O(1) always | O(n) with hash collisions |
| **Memory** | Fixed O(\|Σ\|) — e.g., 104 bytes for 26 ints | O(m) where m = distinct keys, but higher per-entry overhead |
| **Character range** | Must be known and small (e.g., a–z) | Any hashable type — char, string, int, custom |
| **ASCII math** | Requires `ch - 'a'` and `i + 'a'` | None — direct key usage |
| **Iteration order** | Deterministic (0–25 index order) | Non-deterministic (bucket layout) |
| **Sparse data** | Wastes iteration over empty slots | Only visits present entries |
| **Stack vs heap** | Stack allocation (fast, no fragmentation) | Heap allocation (slower, may fragment) |
| **Implementation complexity** | Trivial — 1 line declaration | Slightly more — need `#include <unordered_map>` |
| **Rehashing** | Never | Amortized O(n) when load factor exceeded |

## When to Choose Each

### Choose frequency array when:
- The problem guarantees a limited character set (e.g., "string of lowercase letters")
- Maximum performance is required (time-critical section, embedded systems)
- Deterministic output order is needed (alphabetical by default)
- Memory is constrained and the domain is small

### Choose hash map when:
- The character set is unknown or mixed (uppercase, digits, symbols)
- Keys are not characters (word frequencies, integer frequencies)
- The input is sparse over a large domain (better memory for few distinct keys)
- The problem involves Unicode or extended character sets

## Insights Beyond Individual Concepts

The array-vs-map choice reveals a deeper principle in software engineering: **the best data structure depends on the constraints of the problem, not on abstract asymptotic analysis.** Both are "O(1)" but the constants differ by orders of magnitude. A naive preference for maps (because they are more flexible) misses the performance advantage of arrays, and a naive preference for arrays (because they are faster) misses the flexibility advantage of maps.

The interview answer that demonstrates mastery is the conditional one: "It depends on the character range." This shows the candidate understands the tradeoffs rather than having memorized a rule.

## Connections

- [[frequency-array|Frequency Array]] — the array-based approach, fastest for known domains
- [[unordered-map-frequency|Unordered Map for Frequency Counting]] — the map-based approach, most flexible
- [[known-range-assumption|Known Range Assumption]] — the precondition that makes arrays viable
- [[hash-map-flexibility|Hash Map Flexibility]] — the key advantage of maps
- [[memory-efficiency-array|Memory Efficiency of Frequency Array]] — why arrays use less memory
- [[direct-array-access|Direct Array Access]] — why arrays are faster at the hardware level
- [[hash-collision-overhead|Hash Collision Overhead]] — the hidden cost of maps
- [[ascii-math-elimination|ASCII Math Elimination]] — one of the ergonomic benefits of maps
- [[unordered-map-non-determinism|Unordered Map Non-Determinism]] — the ordering tradeoff of maps
- [[interview-decision-framework|Array vs Hash Map Decision Framework]] — the practical decision process