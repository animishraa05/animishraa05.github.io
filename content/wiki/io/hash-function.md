---
concept: Hash Function
aliases: [Hash Algorithm, Scattering Function]
tags: [systems, data-structures]
sources_count: 1
last_source: io.md
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

We need a deterministic way to convert arbitrary-sized keys (strings, numbers) into fixed-size array indices for O(1) lookup.

## Core Idea

A hash function maps keys to integer values (array indices) such that equal keys always produce the same hash value, and the distribution is as uniform as possible.

## How It Works

1. Take input key (string, number, object)
2. Apply mathematical transformation (e.g., modulo, multiplication, bit shifting)
3. Output is an integer in range [0, table_size-1]
4. Good hash functions minimize collisions

```dot
digraph hash_fn {
  rankdir=TB;
  node [shape=box, style=filled];
  
  Input [label="Input Keys\n'Alice', 42, 'Bob'", fillcolor=lightyellow];
  Function [label="Hash Function\nh(key)", fillcolor=orange];
  
  subgraph cluster_output {
    label="Hash Values";
    fillcolor=lightgray;
    H1 [label="h('Alice') = 3", fillcolor=lightgreen];
    H2 [label="h(42) = 7", fillcolor=lightgreen];
    H3 [label="h('Bob') = 3 ← collision!", fillcolor=salmon];
  }
  
  Input -> Function;
  Function -> H1;
  Function -> H2;
  Function -> H3;
}
```

## Key Properties

- Deterministic: same key → same hash always
- Uniform distribution minimizes collisions
- Fast to compute (shouldn't be slower than the data structure it serves)
- Examples: division method, multiplication method, universal hashing

## Connections

- **Built from:** [[hashing|Hashing]]
- **Builds into:** [[separate-chaining|Separate Chaining]], [[linear-probing|Linear Probing]]
- **Related:** [[collision-resolution|Collision Resolution]], [[load-factor|Load Factor]]
- **Contrasts with:** [[random-number-generator|Random Number Generator]] (hash is deterministic, not random)

## Edge Cases & Gotchas

- Poor hash functions cause clustering (many collisions)
- String hashing must handle variable lengths
- Cryptographic hash functions are overkill for hash tables (too slow)
- Changing hash function requires rehashing entire table

## Sources

- [[io-summary|I/O System Source Summary]]
