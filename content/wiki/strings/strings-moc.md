---
title: Strings — Map of Content
tags: [dev, hashing]
created: 2026-07-05
updated: 2026-07-05
---

> Map of Content for all pages derived from [[./strings-summary|Strings (Character Hashing in C++)]].

---

## Core Paradigm

- [[two-phase-hashing|Two-Phase Hashing Paradigm]] — the fundamental model
- [[hashing-store-phase|Hashing Store Phase (Phase 1)]] — building the frequency structure
- [[hashing-retrieval-phase|Hashing Retrieval Phase (Phase 2)]] — querying the structure

## Data Structures

- [[frequency-array|Frequency Array]] — fixed-size array for known domains
- [[unordered-map-frequency|Unordered Map for Frequency Counting]] — hash map for flexible domains
- [[direct-array-access|Direct Array Access]] — hardware-level O(1) array indexing
- [[hash-collision-overhead|Hash Collision Overhead]] — performance cost of hash maps

## Mappings & Conversions

- [[character-to-index-mapping|Character-to-Index Mapping]] — `ch - 'a'`
- [[index-to-character-conversion|Index-to-Character Conversion]] — `i + 'a'`
- [[ascii-math-elimination|ASCII Math Elimination]] — maps remove the need for ASCII math

## Key Properties & Assumptions

- [[known-range-assumption|Known Range Assumption]] — when arrays work
- [[memory-efficiency-array|Memory Efficiency of Frequency Array]] — fixed 104-byte footprint
- [[hash-map-flexibility|Hash Map Flexibility]] — any hashable key type
- [[map-traversal-method|Hash Map Traversal Method]] — iterating key-value pairs
- [[unordered-map-non-determinism|Unordered Map Non-Determinism]] — unspecified iteration order

## Problem Patterns (Phase 2)

- [[most-frequent-character|Most Frequent Character via Hashing]] — traverse for max
- [[first-non-repeating-character|First Non-Repeating Character via Hashing]] — re-traverse input
- [[anagram-detection-via-hashing|Anagram Detection via Hashing]] — compare two structures
- [[character-hashing-use-cases|Character Hashing Use Cases]] — catalog of all patterns

## Decision Making

- [[interview-decision-framework|Array vs Hash Map Decision Framework]] — choosing the right tool
- [[frequency-array-vs-hash-map|Frequency Array vs Hash Map]] — detailed comparison
- [[two-phase-hashing-patterns|Two-Phase Hashing Patterns]] — catalog of Phase 2 strategies
