---
concept: GPRS
aliases: [general-packet-radio-service, 2-5G]
tags: [networking, gsm]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

# GPRS

## The Problem
GSM was designed primarily for voice (circuit-switched). Data was an afterthought, limited to 9.6 kbps. As the internet grew, there was massive demand for wireless packet data (email, web browsing, WAP). GPRS added packet-switched data service to GSM without replacing the voice infrastructure — "2.5G."

## Core Idea
GPRS (General Packet Radio Service) adds packet-switching capability to the existing GSM circuit-switched voice network. It creates a parallel packet network (using the same air interface and base stations) optimized for bursty data traffic instead of continuous voice.

## How It Works
1. **Architecture Addition:** Two new network elements are added to GSM:
   - **SGSN (Serving GPRS Support Node):** Handles packet routing, mobility, and authentication for data
   - **GGSN (Gateway GPRS Support Node):** Interfaces GPRS to the internet (IP networks)
2. **Channel Allocation:** Data uses physical channels differently than voice:
   - Up to 8 timeslots can be combined for a single user
   - Channels are dynamically allocated only when data traffic exists
   - No dedicated circuit — shared, packet-based
3. **New Air Interface:**
   - Uses the same TDMA/FDMA frame structure but with new channel coding schemes (CS-1 to CS-4, up to 21.4 kbps per timeslot)
   - Theoretical maximum: 171.2 kbps (8 timeslots × 21.4 kbps)
   - Practical: 40–50 kbps typical, up to 115 kbps in best conditions
4. **Data Packets:** All data is in IP packets, routed through the GPRS backbone
5. **Always-On:** No dial-up — IP address is assigned and connection is always available

## Key Properties
- Packet-switched: bandwidth used only when transmitting data, not continuously
- Dynamic allocation: 1–8 timeslots per user based on traffic
- Theoretical max: 171.2 kbps; typical 40–50 kbps
- Always-on IP connection; no circuit establishment delay
- Works simultaneously with voice (uses different channel set from voice)
- First deployed in 2000; enabled first mobile internet era

## Connections
- Built from: [[gsm-architecture|GSM Architecture]] — GPRS builds on existing GSM infrastructure
- Built into: [[gsm|GSM]] — GPRS is an integral part of GSM Phase 2+ specifications
- Builds into: [[edge|EDGE]] — EDGE (3G) builds on GPRS infrastructure
- Related: [[wcdma|WCDMA]] — the competing 3G technology
- Related: [[short-message-service|SMS]] — SMS was separate from GPRS; both now use the GPRS backbone

## Edge Cases & Gotchas
- GPRS was never intended for streaming video or high-speed data — too slow
- First-gen GPRS was often sold as "wireless internet" with poor throughput
- Billing: early GPRS was charged per packet (kilobyte), causing bill shocks
- Handover between voice and data: GSM handles voice first; data gets preempted

## Sources
- [[../wireless-n-summary|WirelessN.md]]