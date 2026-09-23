---
concept: Switching Comparison
aliases: []
tags: [networking, switching]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

When do you pick circuit, packet/datagram or virtual circuit for a new network?

## Formal Definition

Per Wikipedia: "Comparison hinges on setup cost, resource sharing, ordering, robustness and flexibility across traffic types."

## Explanation

Circuit is private road, datagram is public road per car, virtual circuit is toll lane reservation.

## How It Works

1. List setup cost and delay
2. Compare sharing and utilization
3. Compare ordering guarantees
4. Check robustness to failures
5. Pick based on traffic -- voice vs bursty data

## Visual Explanation

```dot
digraph switching_comparison {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Circuit"]
  B [label="Datagram"]
  C [label="Virtual Circuit"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_switching_comparison {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Switching Comparison" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Circuit good for steady voice
- Datagram good for bursty internet
- Virtual circuit good for ATM/MPLS
- No single best for all

## Real-World Example

```python
| Circuit | Datagram | VC |
```

## Connections

- **Built from:** [[circuit-switching|Circuit Switching]] -- one side
- **Built from:** [[packet-switching|Packet Switching]] -- another
- **Built from:** [[virtual-circuit-network|Virtual Circuit Network]] -- third
- **Builds into:** [[broadcast-links|Broadcast Links]] -- links affect switching

## Edge Cases & Gotchas

- Claiming one always best
- Ignoring signaling overhead
