---
concept: Congestion Basics
aliases: []
tags: [networking, transport]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

Packets are lost even though links are up -- why does network slow itself?

## Formal Definition

Per Wikipedia: "Congestion is overload when offered load exceeds capacity; queue builds, drops occur, goodput collapses without control."

## Explanation

Like traffic jam -- too many cars entering highway slows everyone, even those already on it.

## How It Works

1. Load increases
2. Buffers fill
3. Drops increase
4. Retransmits add load
5. Collapse without backoff

## Visual Explanation

```dot
digraph congestion_basics {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Load"]
  B [label="Queue"]
  C [label="Drop"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_congestion_basics {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Congestion Basics" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Distinct from flow control (receiver) vs congestion (network)
- Needs feedback -- drops or ECN
- Backoff essential

## Real-World Example

```python
TCP backs off on loss
```

## Connections

- **Related:** [[circuit-switching|Circuit Switching]] -- circuit avoids congestion via reservation
- **Related:** [[packet-switching|Packet Switching]] -- packet suffers congestion
- **Builds into:** [[datagram-network|Datagram Network]] -- datagram needs congestion control
- **Related:** [[store-and-forward|Store-and-Forward]] -- congestion lives in buffers

## Edge Cases & Gotchas

- Adding bandwidth alone -- without control still collapses
- Confusing congestion with noise loss
