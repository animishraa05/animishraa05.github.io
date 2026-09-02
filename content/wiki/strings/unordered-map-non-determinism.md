---
concept: Unordered Map Non-Determinism
aliases: [unspecified iteration order, hash map ordering, non-deterministic traversal]
tags: [dev, hashing]
created: 2026-07-05
updated: 2026-07-05
---

## Formal Definition

Unordered map non-determinism refers to the property that `std::unordered_map` does not guarantee any specific iteration order, and the order may change between program runs, library versions, or after rehashing. The iteration order is determined by the internal bucket layout, which depends on the hash function, load factor, and insertion history.

## Explanation

When you iterate a frequency array (0–25), the order is always a, b, c, ..., z. When you iterate an `unordered_map<char, int>`, the order depends on how the hash function distributes keys across buckets. For "banana", you might get `{a:3, b:1, n:2}` in one run and `{b:1, n:2, a:3}` in another. This matters when output order is part of the problem specification or test cases.

## How It Works

1. Each key is hashed to a bucket index: `bucket = hash(key) % bucket_count`
2. Insertion order within a bucket is the order of insertion into that bucket's chain
3. Iteration visits buckets in order of bucket index, then entries within each bucket
4. When the map rehashes (grows), all entries are rehashed — bucket assignments change
5. The hash function may use a random seed (SSO/ASLR) to prevent hash DoS attacks, making order vary across executions

## Visual Explanation

```dot
digraph non_determinism {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]

  SRC [label="Source:\n{a:3, b:1, n:2}"]
  RUN1 [label="Run 1:\na=3, b=1, n=2"]
  RUN2 [label="Run 2:\nb=1, n=2, a=3" fillcolor="#ffe5cc]
  RUN3 [label="Run 3:\nn=2, a=3, b=1" fillcolor="#ffe5cc]

  SRC -> RUN1
  SRC -> RUN2
  SRC -> RUN3
}
```

## Semantic Network

```dot
graph semantic_non_determinism {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Unordered Map Non-Determinism" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  PRE1 [label="Hash Collision Overhead" fillcolor="#cce5ff"]
  PRE2 [label="Hash Map Flexibility" fillcolor="#cce5ff"]
  OUT1 [label="Map Traversal Method" fillcolor="#d4edda]
  CON1 [label="Frequency Array" fillcolor="#ffe5cc"]
  REL1 [label="Interview Decision Framework" fillcolor="#f0f0f0"]
  REL2 [label="Array vs Hash Map Tradeoffs" fillcolor="#f0f0f0"]

  THIS -- PRE1 [label="built from" style=dashed]
  THIS -- PRE2 [label="built from" style=dashed]
  THIS -- OUT1 [label="builds into"]
  THIS -- CON1 [label="contrasts with" style=dotted]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="related"]
}
```

## Key Properties

- Iteration order is not a bug — it is a design feature (performance over determinism)
- Order can change between: compilers, standard library versions, program runs, and before/after rehashing
- Frequency arrays guarantee deterministic, sorted-by-index order
- If order matters, copy to a vector and sort, or use `std::map` (tree-based, ordered)
- Non-determinism affects output formatting, not correctness of frequency values

## Connections

- Built from: [[hash-collision-overhead|Hash Collision Overhead]] — bucket layout drives iteration order
- Built from: [[hash-map-flexibility|Hash Map Flexibility]] — the flexibility tradeoff includes non-determinism
- Builds into: [[map-traversal-method|Hash Map Traversal Method]] — traversal must account for unspecified order
- Contrasts with: [[frequency-array|Frequency Array]] — arrays give predictable, index-based order
- Related: [[interview-decision-framework|Array vs Hash Map Decision Framework]] — determinism is a decision factor

## Edge Cases & Gotchas

- Automated test suites that compare output as strings will fail if they expect a specific order from unordered_map
- Using `std::map` instead guarantees order but costs O(log n) per operation — not always necessary
- For "first non-repeating character" problems, re-traversing the original string (not the map) avoids the ordering issue entirely
- If the problem says "print frequencies in any order," unordered_map is fine; if it says "print in alphabetical order," use an array or a sorted container
- The non-determinism is a concern for reproducibility in debugging — a bug that depends on iteration order may not reproduce consistently