---
source: Strings (Character Hashing in C++)
source_path: sources/Strings.md
content_hash: dfdc41d2743237dbd07e5dc623c91bac5ec1944e3955b28110a0f400bd4db3bd
ingested: 2026-07-05
concepts_count: 22
---

## Concepts Extracted

### Existing concepts (updated):
- [[character-to-index-mapping|Character-to-Index Mapping]] — `ch - 'a'` ASCII offset technique
- [[direct-array-access|Direct Array Access]] — hardware-level O(1) array indexing
- [[frequency-array|Frequency Array]] — fixed-size counting structure for known domains
- [[hash-collision-overhead|Hash Collision Overhead]] — the hidden cost of hash maps
- [[hashing-retrieval-phase|Hashing Retrieval Phase]] — Phase 2: querying the structure
- [[hashing-store-phase|Hashing Store Phase]] — Phase 1: building the structure
- [[index-to-character-conversion|Index-to-Character Conversion]] — `i + 'a'` reverse mapping
- [[two-phase-hashing|Two-Phase Hashing Paradigm]] — store then use
- [[unordered-map-frequency|Unordered Map for Frequency Counting]] — flexible frequency mapping

### New concept pages created:
- [[most-frequent-character|Most Frequent Character via Hashing]] — max frequency via structure traversal
- [[first-non-repeating-character|First Non-Repeating Character via Hashing]] — order-preserving Phase 2
- [[anagram-detection-via-hashing|Anagram Detection via Hashing]] — comparing two frequency structures
- [[ascii-math-elimination|ASCII Math Elimination]] — maps remove need for `ch - 'a'`
- [[known-range-assumption|Known Range Assumption]] — arrays require known, bounded domains
- [[memory-efficiency-array|Memory Efficiency of Frequency Array]] — fixed 104-byte overhead
- [[hash-map-flexibility|Hash Map Flexibility]] — any hashable key type
- [[map-traversal-method|Hash Map Traversal Method]] — iterating key-value pairs
- [[unordered-map-non-determinism|Unordered Map Non-Determinism]] — unspecified iteration order
- [[character-hashing-use-cases|Character Hashing Use Cases]] — catalog of Phase 2 patterns
- [[interview-decision-framework|Array vs Hash Map Decision Framework]] — when to choose each

### Synthesis pages created:
- [[frequency-array-vs-hash-map|Frequency Array vs Hash Map — Character Hashing Tradeoffs]] — structured comparison
- [[two-phase-hashing-patterns|Two-Phase Hashing Patterns]] — catalog of Phase 2 strategies

## Key Takeaways

1. Character hashing follows a universal two-phase pattern: store frequencies, then query them
2. The Phase 1 code is nearly identical across all frequency problems — only the data structure (array vs map) varies
3. Phase 2 is where problem-specific logic lives: max finding, order-sensitive traversal, comparison, constraint checking
4. The choice between frequency array and hash map hinges on whether the character range is known and small (choose array) or large/unknown (choose map)
5. "It depends on the character range" is the interview answer that demonstrates understanding of tradeoffs
6. Beginners stop after Phase 1; strong candidates think about Phase 2 before writing any code

## Open Questions

- What is the exact performance crossover point where a hash map becomes faster than a frequency array? It depends on domain size, string length, and hardware — but a benchmark on modern hardware would be valuable
- How do modern C++ hash map implementations (e.g., Abseil flat_hash_map, folly F14) change the array-vs-map tradeoff? These use open addressing and are significantly faster than std::unordered_map
- For very large alphabets (Unicode full range), what is the most memory-efficient frequency counting approach? A hash map over the appearing characters, or a trie/adaptation?
- How does the two-phase paradigm generalize beyond frequency counting? The store-then-query pattern applies to graph problems (build adjacency list, then traverse), database indexing (build index, then query), and more — is there a formal characterization?
