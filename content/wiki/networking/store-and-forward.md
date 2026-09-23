---
concept: Store-and-Forward
aliases: []
tags: [networking, switching]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

How do routers handle a packet that arrives faster than it can be sent out?

## Formal Definition

Per Wikipedia: "Store-and-forward buffers the entire packet before forwarding, enabling error check and rate adaptation."

## Explanation

Like post office -- clerk receives whole letter, checks address, then hands to next carrier, not letter-by-letter.

## How It Works

1. Packet arrives at input port
2. Stored in buffer
3. Checked for errors
4. Routing table consulted
5. Forwarded to output port

## Visual Explanation

```dot
digraph store_and_forward {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Ingress"]
  B [label="Buffer"]
  C [label="Egress"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_store_and_forward {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Store-and-Forward" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Enables error detection
- Needs memory for queue
- Adds store delay
- Contrasts with cut-through

## Real-World Example

```python
packet -> buffer -> lookup -> forward
```

## Connections

- **Built from:** [[packet-switching|Packet Switching]] -- store-forward is packet technique
- **Contrasts with:** [[circuit-switching|Circuit Switching]] -- circuit reserves path
- **Related:** [[broadcast-links|Broadcast Links]] -- broadcasts still need buffering
- **Builds into:** [[packet-switching|Packet Switching]] -- refines

## Edge Cases & Gotchas

- Buffer bloat -- too much buffering adds latency
- Assuming zero copy -- actually copied
