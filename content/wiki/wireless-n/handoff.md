---
concept: Handoff
aliases: [handover, handoff-types, hard-handoff, soft-handoff]
tags: [networking, cellular]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
When a mobile user moves from one cell to another while on a call, the call must be transferred from the old base station to the new one without interrupting the call. If this is not done seamlessly, the call drops. Handoff management is a critical mobility function that maintains continuous connectivity as users move across cell boundaries.

## Core Idea
Handoff is the process of transferring an active call from one base station to another as the mobile moves across cell boundaries. There are two types: hard handoff (break-before-make, used in GSM with FDMA/TDMA) where the old connection is dropped before establishing the new one, and soft handoff (make-before-break, used in CDMA) where the new connection is established before dropping the old one.

## How It Works

**Hard Handoff (GSM — Break Before Make):**
1. As the mobile moves, signal strength from the current BTS decreases
2. BSC detects the need for handoff when signal falls below a threshold
3. BSC commands the mobile to retune to a new frequency channel (new BTS)
4. Old connection is dropped; new connection is established on the new channel
5. A gap in transmission occurs; if timing is off, the call drops
6. GSM uses hard handoff because FDMA/TDMA channels are dedicated and cannot be shared

**Soft Handoff (CDMA — Make Before Break):**
1. Mobile maintains connection with both old and new base stations simultaneously
2. Both links are active; the stronger signal is used for voice
3. Once the new link is confirmed stable, the old link is dropped
4. Seamless handover with no dropped calls
5. CDMA uses soft handoff because all users share the same frequency — multiple links can coexist

## Key Properties
- Hard Handoff (GSM): break-before-make; simple but risk of dropped calls
- Soft Handoff (CDMA): make-before-break; seamless but more complex
- Handoff decisions based on signal strength, quality, distance
- Intra-BSC handoff: handled by BSC alone (faster, no MSC involvement)
- Inter-BSC handoff: BSC coordinates with MSC (slower, more overhead)
- Excessive handoffs (ping-pong effect) waste resources and degrade quality

## Connections
- Built from: [[cellular-mobile-system|Cellular Mobile System]] — handoff is what makes mobility possible
- Built from: [[gsm-architecture|GSM Architecture]] — BSC and MSC coordinate handoffs
- Built into: [[gsm|GSM]] — GSM uses hard handoff because of FDMA/TDMA
- Related: [[soft-handoff|Soft Handoff]] — CDMA's handoff technique
- Related: [[dropped-call-rate|Dropped Call Rate]] — metric used to evaluate handoff performance

## Edge Cases & Gotchas
- Ping-pong handoff: rapid oscillation between two cells wastes resources
- Handoff latency must be minimal to avoid perceptive gaps in voice
- In CDMA, soft handoff creates a macro-diversity benefit — combining signals from multiple BTSs improves quality
- Hard handoff in GSM was acceptable for 2G voice but problematic for 3G data

## Sources
- [[wireless-n-summary|WirelessN.md]]