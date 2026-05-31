---
concept: CDMA
aliases: [code-division-multiple-access, spread-spectrum-cdma]
tags: [networking, cdma]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

# CDMA

## The Problem
In FDMA and TDMA systems, each user gets an exclusive frequency band or time slot. Adding more users means taking away resources from others. CDMA takes a fundamentally different approach: all users share the same frequency at the same time, distinguished only by unique pseudo-random codes. This allows soft capacity (interference-limited) and soft handoff, but requires sophisticated power control.

## Core Idea
CDMA (Code Division Multiple Access) is a spread-spectrum digital cellular technology where all users transmit on the same frequency simultaneously. Each user's signal is spread with a unique orthogonal code; the receiver uses the code to extract its signal from the mixture. The system is interference-limited, not hard-capacity-limited.

## How It Works
1. **Spreading:** Each user's data bits are combined (XOR) with a high-rate chipping sequence (e.g., 128 chips per bit in IS-95)
2. **Orthogonal Codes:** Walsh functions or other orthogonal code sets ensure each user's spread signal is distinguishable
3. **All Users Share:** All voice and data transmissions use the same 1.25 MHz bandwidth
4. **At the Receiver:** The despreading correlator correlates the received signal with the intended user's code
5. **Processing Gain:** The ratio of spread bandwidth to information bandwidth; provides processing gain (interference rejection)
6. **Power Control:** Essential — strong users drown out weak users; base station commands all mobiles to equalize received power
7. **Soft Handoff:** Mobile connects to multiple base stations during handoff; both signals are combined

## Key Properties
- All users share the same 1.25 MHz band (IS-95) or wider band (3G, 4G)
- Soft capacity: capacity is limited by total interference, not fixed channel count
- Soft handoff: make-before-break; multiple BTS links combined at the receiver
- Near/far problem is severe: requires strict power control
- Processing gain: spreading provides resistance to narrowband interference
- Voice activity detection: slots are freed during silence, increasing capacity

## Connections
- Built from: [[spread-spectrum|Spread Spectrum]] — CDMA is the fundamental spread spectrum technique
- Built from: [[near-far-terminal|Near/Far Terminal Effect]] — the problem that defines CDMA power control requirements
- Built from: [[power-control|Power Control]] — the critical requirement for CDMA
- Related: [[soft-handoff|Soft Handoff]] — CDMA's handoff mechanism provides macro-diversity
- Related: [[wcdma|WCDMA]] — the UMTS 3G version of CDMA
- Related: [[is-95|IS-95]] — the first CDMA cellular standard (2G)

## Edge Cases & Gotchas
- CDMA capacity is not fixed — more users = more interference = degraded quality for all
- Without power control, the near/far effect limits capacity to a handful of users
- First CDMA networks (IS-95) had capacity close to GSM; 3G CDMA (WCDMA) significantly improved
- Processing gain (Spreading factor) decreases as data rates increase

## Sources
- [[wireless-n-summary|WirelessN.md]]