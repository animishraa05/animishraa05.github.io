---
concept: Collision Resolution
aliases: [Hash Collision Handling, Collision Handling]
tags: [systems, data-structures]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

Two different keys may hash to the same index (collision). The hash table needs a strategy to store both values at the same index.

## Core Idea

Collision resolution techniques handle cases where multiple keys map to the same hash table index, using either chaining (linked lists) or probing (search for next available slot).

## How It Works

Two main approaches:

**1. Separate Chaining**: Each index has a linked list of all key-value pairs that hashed there
**2. Open Addressing (Probing)**: Find another empty slot using a probe sequence

```dot
digraph collision {
  rankdir=TB;
  node [shape=box, style=filled];
  
  subgraph cluster_chain {
    label="Separate Chaining";
    Idx [label="Index 3", fillcolor=lightblue];
    List [label="Linked List\n(Alice, Bob, Charlie)", fillcolor=lightgreen];
    Idx -> List;
  }
  
  subgraph cluster_probe {
    label="Linear Probing";
    T0 [label="3: Alice", fillcolor=lightyellow];
    T1 [label="4: Bob ← probed here", fillcolor=lightgreen];
    T0 -> T1 [label="collision, probe next"];
  }
}
```

## Key Properties

- **Separate Chaining**: Simple, performance degrades with long chains
- **Linear Probing**: Fast when table isn't full, but causes clustering
- **Quadratic Probing**: Reduces clustering, but may not probe all slots
- **Double Hashing**: Uses second hash function, best open addressing method



## Semantic Network

```dot
graph semantic_Collision_Resolution {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Collision Resolution" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- **Built from:** [[hashing|Hashing]], [[hash-function|Hash Function]]
- **Builds into:** [[separate-chaining|Separate Chaining]], [[linear-probing|Linear Probing]]
- **Related:** [[double-hashing|Double Hashing]], [[quadratic-probing|Quadratic Probing]]
- **Contrasts with:** [[hash-function|Hash Function]] (prevents vs handles collisions)

## Edge Cases & Gotchas

- Long chains in chaining → degrades to O(n) search
- Clustering in probing → many consecutive occupied slots
- Deletion in open addressing is tricky (can't just remove, need tombstones)
- Load factor > 0.7 → performance drops sharply