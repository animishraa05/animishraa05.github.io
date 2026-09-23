---
concept: Virtual Circuit Network
aliases: []
tags: [networking, switching]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

Need ordering but still want packet efficiency -- can we reserve a logical path without reserving bandwidth like circuit?

## Formal Definition

Per Wikipedia: "A virtual circuit network sets up a logical path before data, packets carry VCI and follow same path, combining setup with packet switching."

## Explanation

Like booking a train seat but not the whole train -- you have reserved route but share tracks.

## How It Works

1. Signal setup reserves VCI along path
2. Packets tag VCI not full address
3. Routers forward via VCI table
4. Packets arrive in order
5. Teardown releases VCIs

## Visual Explanation

```dot
digraph virtual_circuit_network {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Setup"]
  B [label="VCI Forward"]
  C [label="Teardown"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_virtual_circuit_network {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Virtual Circuit Network" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Ordered delivery
- Per-flow state in routers
- Setup latency
- Fails if intermediate router reboots

## Real-World Example

```python
MPLS labels are VCIs
```

## Connections

- **Built from:** [[circuit-switching|Circuit Switching]] -- borrows setup idea
- **Built from:** [[packet-switching|Packet Switching]] -- borrows packet sharing
- **Contrasts with:** [[datagram-network|Datagram Network]] -- VC is connection-oriented
- **Related:** [[store-and-forward|Store-and-Forward]] -- VCs also store-forward

## Edge Cases & Gotchas

- Confusing with circuit -- VC shares bandwidth
- VCI reuse after teardown collides if stale
