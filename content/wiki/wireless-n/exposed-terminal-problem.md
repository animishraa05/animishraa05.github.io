---
concept: Exposed Terminal Problem
aliases: [exposed-node, exposed-terminal]
tags: [networking, mac]
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
The complementary problem to the hidden terminal: sometimes a node correctly detects that a neighbor is transmitting, but the detection causes it to unnecessarily refrain from transmitting. The node misinterprets nearby transmission as a reason to wait, even though its own transmission would not interfere with the ongoing one (because the intended receivers are far apart). This wastes available bandwidth and reduces network efficiency.

## Core Idea
The exposed terminal problem occurs when a node (C) that is within range of an active transmitter (B) unnecessarily defers its own transmission, even though its signal would not interfere with B's reception (because C's intended receiver D is far away). C is "exposed" to B's signal but doesn't realize its own signal won't cause problems.

## How It Works
1. Node B is transmitting to node A (B is within range of A, not within range of C)
2. Node C wants to transmit to node D (D is far from both A and B)
3. C senses the channel and detects B's ongoing transmission
4. C incorrectly concludes it cannot transmit without causing interference
5. C waits unnecessarily, even though its signal to D would not interfere with B's signal to A
6. Bandwidth is wasted — C could have successfully transmitted to D simultaneously

The key insight: if the intended receivers are sufficiently separated, simultaneous transmissions are possible without collision.

## Key Properties
- Waste of bandwidth: node C unnecessarily waits when transmission would succeed
- Caused by over-conservative carrier sensing (no distinction between harmful and harmless interference)
- More subtle than hidden terminal — requires understanding of receiver locations
- Can be partially solved by RTS/CTS exchanges (MACA) which announce intended receivers
- Not as severe as hidden terminal but still reduces network efficiency significantly

## Connections
- Related: [[hidden-terminal-problem|Hidden Terminal Problem]] — the complementary problem; both arise from range limitations
- Related: [[maca|MACA]] — MACA's RTS/CTS handshake also helps exposed terminals by announcing clear receiver zones
- Related: [[csma|CSMA]] — carrier sensing that causes the exposed terminal problem
- Related: [[near-far-terminal|Near/Far Terminal Effect]] — another wireless MAC efficiency problem

## Edge Cases & Gotchas
- The exposed terminal problem is less severe than the hidden terminal problem in terms of call quality
- It mainly affects throughput (capacity), not call success rates
- Directional antennas can help — C can transmit in a direction different from B's reception zone
- RTS/CTS helps resolve both hidden and exposed terminal problems by explicitly announcing receiver locations