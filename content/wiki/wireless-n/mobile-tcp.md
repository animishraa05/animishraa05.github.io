---
concept: Mobile TCP
aliases: [mobile-transport-layer, indirect-tcp, snooping-tcp]
tags: [networking, transport]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

# Mobile TCP

## The Problem
Standard TCP assumes packet loss is caused by network congestion (router buffers overflowing), and responds by reducing the congestion window. However, in wireless mobile networks, packet loss is often caused by signal fading, handoff, or temporary disconnection — not congestion. When TCP sees packet loss, it incorrectly throttles the connection, degrading performance by orders of magnitude.

## Core Idea
Mobile TCP adaptations modify the standard TCP protocol to handle wireless link characteristics: Indirect TCP (I-TCP) separates the wired and wireless parts of the connection, snooping TCP monitors the wireless link for fast local recovery, and Fast Retransmit/Fast Recovery allow quick recovery without full congestion control resets.

## How It Works

**Standard TCP Problem:**
1. TCP on the sender sees packet loss at any hop
2. TCP assumes congestion and halves the congestion window (cwnd)
3. Slow start re-builds the window from scratch
4. On wireless links where handoffs cause brief packet loss, this degrades performance drastically

**Indirect TCP (I-TCP):**
1. Connection is split at the foreign agent (gateway): wired part (sender ↔ FA) + wireless part (FA ↔ mobile)
2. On the wired segment, packets are never lost — I-TCP provides a reliable transport
3. FA performs local recovery of wireless losses
4. Wired sender never sees wireless losses → no congestion window throttling

**Snooping TCP:**
1. The base station (FA) monitors passing packets ("snoops")
2. Detects lost packets on the wireless link and performs local retransmission
3. Buffers packets to enable fast retransmission without sender involvement
4. Hides wireless losses from the sender's TCP

**Fast Retransmit / Fast Recovery:**
1. On detecting multiple duplicate ACKs, TCP does Fast Retransmit (retx without cwnd reset)
2. Fast Recovery allows continued transmission while rebuilding cwnd
3. Less aggressive than full Congestion Control

## Key Properties
- I-TCP: splits connection; end-to-end semantics lost; FA is a bottleneck
- Snooping TCP: FA local recovery; maintains end-to-end semantics
- Fast Retransmit: partial recovery without full cwnd halving
- All mobile TCP variants hide wireless link characteristics from the sender
- Trade-off: network layer transparency vs. performance

## Connections
- Built from: [[tcp|TCP]] — standard TCP that fails in mobile environments
- Built from: [[cellular-mobile-system|Cellular Mobile System]] — the environment where standard TCP fails
- Related: [[mobile-ip|Mobile IP]] — handles network layer (IP) mobility; different from transport layer mobility
- Related: [[congestion-control|Congestion Control]] — the TCP mechanism that misfires in mobile networks

## Edge Cases & Gotchas
- I-TCP breaks end-to-end semantics — FA crash loses data
- Snooping TCP: FA crash loses buffered packets
- Mobile IP and Mobile TCP address different problems: network vs. transport layer
- For real-time traffic (voice), TCP is fundamentally wrong — UDP with FEC/Raptor codes is better

## Sources
- [[wireless-n-summary|WirelessN.md]]