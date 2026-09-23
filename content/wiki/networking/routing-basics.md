---
concept: Routing Basics
aliases: []
tags: [networking, routing]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

A packet has destination IP -- which next hop should router pick?

## Formal Definition

Per Wikipedia: "Routing chooses next hop using tables built from protocols that exchange reachability and compute shortest path."

## Explanation

Routing is GPS for packets -- each intersection consults map and forwards toward destination.

## How It Works

1. Router learns routes via protocol
2. Builds forwarding table
3. Looks up destination on arrival
4. Forwards via best next hop
5. Updates on topology change

## Visual Explanation

```dot
digraph routing_basics {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Destination"]
  B [label="Routing Table"]
  C [label="Next Hop"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_routing_basics {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Routing Basics" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Decentralized -- each router decides
- Convergence time after failure
- Longest prefix match for IP
- May cause loops transiently

## Real-World Example

```python
ip route add 10.0.0.0/8 via 192.168.1.1
```

## Connections

- **Built from:** [[store-and-forward|Store-and-Forward]] -- routing decides where to forward
- **Related:** [[packet-switching|Packet Switching]] -- routing enables switching
- **Related:** [[datagram-network|Datagram Network]] -- datagrams need routing
- **Related:** [[network-topology|Network Topology]] -- topology informs routes

## Edge Cases & Gotchas

- Static routes stale after link fail
- Loop without TTL -- packet circles forever
