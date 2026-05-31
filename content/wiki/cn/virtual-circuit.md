---
concept: Virtual Circuit
aliases: [logical circuit, virtual connection]
tags: [networking, transport]
created: 2026-04-30
updated: 2026-04-30
---

# Virtual Circuit

## The Problem
Circuit switching reserves physical resources but is inefficient. Packet switching is efficient but packets may take different paths. Some services need the benefits of both: a logical "dedicated path" without reserving physical resources.

## Core Idea
A logical connection where packets follow the same path through the network using pre-established routing state, without dedicating physical transmission resources.

## How It Works
1. Connection establishment sets up routing state at each intermediate switch/router
2. All packets in the flow follow the same path using the virtual circuit identifier
3. No need for full destination address in each packet — just the VC ID
4. Resources are allocated logically, not physically
5. Connection teardown releases the VC state

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    A [label="Sender"];
    R1 [label="Router 1\n(VC table)"];
    R2 [label="Router 2\n(VC table)"];
    B [label="Receiver"];
    
    A -> R1 [label="VC ID: 123", color=blue];
    R1 -> R2 [label="VC ID: 456", color=blue];
    R2 -> B [label="VC ID: 789", color=blue];
    
    note [label="All packets use\nsame logical path", shape=note];
}
```

## Key Properties
- Logical path maintained for connection duration
- Packets share same route without per-packet routing decisions
- VC identifiers are local to each link (swapped at each hop)
- Contrasts with datagram: no per-packet routing vs per-packet routing

## Connections
- Built from: [[connection-oriented-service|Connection-Oriented Service]] — uses virtual circuits
- Built from: [[circuit-switching|Circuit Switching]] — inspiration for VC concept
- Contrasts with: [[datagram|Datagram]] — independent per-packet routing
- Related: [[three-way-handshake|Three-Way Handshake]] — establishes VC state

## Edge Cases & Gotchas
- VC state at routers means router failures break all active VCs
- VC ID spaces are link-local, requiring translation at each hop
- Not used in modern IP networks (uses datagram approach instead)

## Sources
- [[cn-summary|Computer Networks Gemini Conversation]]
