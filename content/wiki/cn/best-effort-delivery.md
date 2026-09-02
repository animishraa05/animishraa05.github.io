---
concept: Best Effort Delivery
aliases: [best effort, unreliable delivery]
tags: [networking, network-layer]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem
Network layers want to forward packets as fast as possible without the overhead of guaranteeing delivery. Some services (like IP) prioritize speed and simplicity over reliability.

## Core Idea
A delivery model where the network makes its "best effort" to deliver packets but provides no guarantees — packets can be lost, duplicated, or arrive out of order.

## How It Works
1. Network layer receives packet from transport layer
2. Attempts to route and forward packet toward destination
3. If link is congested or error occurs: packet may be dropped
4. No acknowledgments, retransmissions, or error recovery at this layer
5. Higher layers (e.g., TCP) must handle reliability if needed

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Sender [label="Sender"];
    Network [label="Network\n(Best Effort)", shape=diamond];
    Dest [label="Destination"];
    
    Sender -> Network [label="Packet 1"];
    Sender -> Network [label="Packet 2"];
    Network -> Dest [label="1 arrives"];
    Network [label="Packet 2 LOST", style=filled, fillcolor=red];
}
```

## Key Properties
- No delivery guarantees
- No order guarantees
- No error recovery (just detection via checksums)
- Minimal overhead — fast and simple

## Connections
- Built from: [[ip-protocol|IP Protocol]] — uses best-effort delivery
- Built from: [[connectionless-service|Connectionless Service]] — inherently best-effort
- Contrasts with: [[reliable-data-transfer|Reliable Data Transfer]] — guarantees vs no guarantees
- Related: [[udp|UDP]] — transport layer best-effort protocol

## Edge Cases & Gotchas
- Higher layers must implement reliability if needed (TCP does this on top of IP)
- Packet loss is expected and must be handled by applications or transport layer
- "Best effort" doesn't mean "no effort" — routers still try their best to forward