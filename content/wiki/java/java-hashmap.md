---
concept: Java HashMap
aliases: [Hash Table, Key-Value Map, Hash Bucket]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Storing and looking up data by a key (not an index) is a fundamental need — finding a user by ID, looking up a configuration value by name, caching computed results. Without a hash-based map, these lookups would require scanning a list, which is O(n) and scales poorly.

## Core Idea

**HashMap** implements the `Map` interface using a hash table. It stores key-value pairs, computes a hash code of the key to determine an index, and provides O(1) average-time performance for put, get, and remove operations. Keys must have properly implemented `hashCode()` and `equals()`.

## How It Works

The internal structure is an array of "buckets" (nodes). When `put(key, value)` is called, `key.hashCode()` is computed and transformed into a bucket index. If the bucket is empty, a new node is placed. If occupied, `equals()` is used to check for key equality — if the same key exists, the value is replaced; otherwise, a collision is resolved by chaining (linked list or tree).

## Visual Explanation

```dot
digraph java_hashmap {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  Map [label="HashMap<K,V>" fillcolor="#ffe5cc"]
  Buckets [label="Bucket Array\n[0] [1] [2] ...[15]"]
  Bucket0 [label="[0]: null"]
  Bucket1 [label="[1]: Node(key=A, val=1)\n           ↓\n       Node(key=B, val=2)"]
  Bucket2 [label="[2]: Node(key=C, val=3)"]
  Get [label="get(key=A)\nhash→index=1\nscan chain→found"]
  Put [label="put(key=D,val=4)\nhash→index=2\ncollision→chain"]

  Map -> Buckets
  Buckets -> Bucket0
  Buckets -> Bucket1
  Buckets -> Bucket2
  Map -> Get
  Map -> Put
}
```

## Semantic Network

```dot
graph semantic_hashmap {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="HashMap" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  COLL [label="Collections" fillcolor="#cce5ff"]
  OBJ [label="Object Class" fillcolor="#cce5ff"]
  AL [label="ArrayList" fillcolor="#f0f0f0"]
  TREEM [label="TreeMap" fillcolor="#f0f0f0"]

  THIS -- COLL [label="built from"]
  THIS -- OBJ [label="built from"]
  THIS -- AL [label="related"]
  THIS -- TREEM [label="contrasts with"]
}
```

## Key Properties

- **O(1) average time**: For get, put, remove with good hash distribution
- **O(n) worst case**: When all keys hash to the same bucket (Java 8+ converts long chains to trees)
- **Load factor**: Default 0.75 — when 75% full, capacity doubles (rehashing)
- **Null keys**: HashMap allows one null key (stored in bucket [0])

## Connections

- **Built from:** [[java-object-class|Java Object Class]] — relies on hashCode() and equals() for correct operation
- **Built from:** [[java-collections-framework|Java Collections Framework]] — implements the Map interface
- **Contrasts with:** [[java-comparable-and-comparator|Comparable & Comparator]] — HashMap uses hash codes; TreeMap uses comparison for ordering
- **Related:** [[java-collections-framework|Collections Framework]] — HashSet is internally backed by a HashMap

## Edge Cases & Gotchas

- **Mutable keys**: Changing fields used in hashCode() after insertion makes the key "lost" in the map
- **Hash collision performance**: Bad hashCode() implementation degrades performance to O(n)
- **Rehashing cost**: When the map resizes, all entries are rehashed — an O(n) operation
- **Not thread-safe**: Use `ConcurrentHashMap` for concurrent access

## Sources

- [[java1-summary|Java Tutorial — Source Summary]] — HashMap
