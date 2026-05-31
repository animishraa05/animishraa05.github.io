---
concept: Hidden Terminal Problem
aliases: [hidden-node, hidden-terminal]
tags: [networking, mac]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

# Hidden Terminal Problem

## The Problem
In wired Ethernet, CSMA/CD (Carrier Sense Multiple Access with Collision Detection) allows nodes to detect collisions while transmitting. In wireless networks, when a device is transmitting, it cannot hear any incoming signals because its own transmission drowns out all incoming signals at its own radio. This means nodes cannot detect collisions in progress, and a special problem emerges: nodes that are out of each other's range (hidden from each other) can both transmit to a common receiver, causing a collision at the receiver that neither sender can detect.

## Core Idea
The hidden terminal problem occurs when two nodes (A and C) cannot detect each other directly (they are "hidden"), but both are within range of a common receiver (B). A and C both sense the channel and find it free (because neither can hear the other), so both transmit to B simultaneously, causing a collision at B that neither A nor C can detect.

## How It Works
1. Node A begins transmitting to node B
2. Node C, which is not within range of A, checks the channel — it cannot hear A's transmission
3. C concludes the channel is free
4. C begins transmitting to B
5. Both signals arrive at B simultaneously → **Collision**
6. A and C complete their transmissions without knowing a collision occurred
7. B receives garbled data and cannot decode either message

Standard CSMA fails because carrier sense only detects local transmissions, not hidden nodes.

## Key Properties
- Occurs due to range limitations: A and C cannot sense each other's transmissions
- Collision happens at the receiver (B), not at the transmitters
- Transmitters cannot detect the collision (collision detection fails in wireless)
- Common in large cells, ad hoc networks, and networks with obstacles between nodes
- Requires a specialized MAC protocol to solve

## Connections
- Related: [[maca|MACA]] — the MAC protocol that solves this using RTS/CTS exchange
- Related: [[exposed-terminal-problem|Exposed Terminal Problem]] — the complementary problem in wireless MAC
- Related: [[near-far-terminal|Near/Far Terminal Effect]] — another wireless MAC problem
- Related: [[csma-cd|CSMA/CD]] — the Ethernet protocol that fails in this wireless scenario
- Related: [[csma|CSMA]] — the foundational carrier sense technique that fails for hidden nodes

## Edge Cases & Gotchas
- The hidden terminal problem is inherent to wireless networks and cannot be fully eliminated
- The RTS/CTS handshake reduces efficiency due to extra control packets
- Not all wireless protocols use collision avoidance (802.11b uses CSMA/CA with ACK instead)
- In dense ad hoc networks, hidden terminals can form chains of 3+ nodes

## Sources
- [[wireless-n-summary|WirelessN.md]]