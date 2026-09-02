---
concept: MACA Protocol
aliases: [MACA, multiple-access-with-collision-avoidance]
tags: [networking, mac]
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Standard CSMA (Carrier Sense Multiple Access) fails in wireless networks because: (1) collision detection is impossible (a node can't hear while transmitting), and (2) the hidden terminal problem means nodes that are out of range don't sense each other's transmissions. MACA (Multiple Access with Collision Avoidance) was designed to solve these wireless MAC problems using a control packet handshake before data transmission.

## Core Idea
MACA is a MAC protocol that solves the hidden terminal problem through a four-way handshake using RTS (Request to Send) and CTS (Clear to Send) control packets. Before transmitting data, the sender requests permission from the receiver, and the receiver announces a reservation that other stations can hear, preventing hidden nodes from transmitting during the reserved data period.

## How It Works
1. **RTS (Request to Send):** Node A sends a short RTS packet to the intended receiver (Node B), containing the data length and sender address
2. All nodes within range of A hear the RTS and record the intended receiver (B) and the reservation duration
3. **CTS (Clear to Send):** Node B replies with a CTS packet containing the same reservation duration
4. All nodes within range of B (including the hidden node C) hear the CTS and defer their transmissions for the reserved duration
5. **DATA transmission:** A transmits data to B
6. **ACK:** B acknowledges successful data reception
7. The hidden node C hears either the RTS (from A) or the CTS (from B) and waits, preventing collision at B

## Key Properties
- Eliminates the hidden terminal problem by making hidden nodes defer through CTS
- Reduces exposed terminal problem by announcing intended receiver zones
- Control packets (RTS/CTS) are short, so collisions during control packets only waste small packets
- Requires a NAV (Network Allocation Vector) mechanism to track reservations
- Used as the basis for IEEE 802.11's CSMA/CA protocol
- RTS/CTS exchange adds overhead but significantly improves performance in high-contention scenarios

## Connections
- Built from: [[hidden-terminal-problem|Hidden Terminal Problem]] — MACA directly solves this
- Built from: [[exposed-terminal-problem|Exposed Terminal Problem]] — MACA's RTS/CTS also mitigates this
- Related: [[near-far-terminal|Near/Far Terminal Effect]] — a different MAC problem solved by power control, not MACA
- Related: [[csma-cd|CSMA/CD]] — the Ethernet protocol that fails without these mechanisms
- Related: [[ieee-802-11|IEEE 802.11]] — 802.11's CSMA/CA is based on MACA's RTS/CTS mechanism
- Related: [[reservation-aloha|Reservation Aloha]] — another reservation-based MAC protocol

## Edge Cases & Gotchas
- RTS/CTS overhead reduces efficiency in low-traffic scenarios
- Not all hidden node scenarios are solved — nodes that cannot hear RTS or CTS (third-order hidden nodes) remain problematic
- Control packet collisions still occur with pure Aloha within RTS/CTS exchange
- In practice, RTS/CTS is only enabled for data frames exceeding a certain length threshold