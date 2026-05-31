---
concept: DAMA Protocol
aliases: [DAMA, demand-assigned-multiple-access, reservation-aloha]
tags: [networking, mac]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

# DAMA Protocol

## The Problem
Fixed channel assignment (FAMA) permanently allocates channels to cells, causing waste when some cells are lightly loaded while others are overloaded. In satellite and cellular systems where traffic is bursty and unpredictable, a dynamic allocation mechanism that assigns channels only when needed is far more efficient.

## Core Idea
DAMA (Demand Assigned Multiple Access) is a combination of random access (Aloha) for requesting channels and fixed assignment (TDM) for actual data transmission. Channels are allocated on-demand from a central pool and returned when the session ends, maximizing resource utilization.

## How It Works

**Explicit Reservation DAMA (Reservation Aloha):**
1. Time is divided into reservation phases and transmission phases
2. During the reservation phase, stations send short request packets using Slotted Aloha
3. Collisions in the reservation phase only destroy the tiny request packet, not data
4. The base station/satellite collects successful requests and broadcasts a reservation list (TDM pattern)
5. During the transmission phase, stations transmit exactly in their assigned slots
6. Zero collisions during data transmission because slots are explicitly reserved

**Implicit Reservation (PRMA — Packet Reservation Multiple Access):**
1. Time is divided into frames, each with a fixed number of slots
2. The base station broadcasts a reservation status vector (e.g., "ACDABA-F") each frame
3. New stations contend for free slots using Aloha during their first successful transmission
4. If successful, all future occurrences of that slot are automatically reserved for that station (implicit)
5. When the station stops transmitting, the base station marks the slot as free in the next frame

## Key Properties
- DAMA (explicit): two-phase structure (contention + transmission); very organized
- PRMA (implicit): one-phase structure; first successful packet grants reservation automatically
- Explicit reservation: guaranteed slots but wastes bandwidth on request packets
- Implicit reservation: zero request overhead; efficient for voice calls but initial collision risk
- PRMA is optimized for periodic traffic (e.g., voice) where continuous slot allocation is needed
- Both schemes protect actual data transmission from collisions

## Connections
- Built from: [[reservation-aloha|Reservation Aloha]] — DAMA is a form of reservation Aloha
- Related: [[prma|PRMA]] — PRMA is an implicit reservation variant of DAMA
- Related: [[slotted-aloha|Slotted Aloha]] — DAMA uses Slotted Aloha for the contention/reservation phase
- Related: [[multiplexing|Multiplexing]] — both TDMA and DAMA are multiplexing schemes
- Related: [[ieee-802-11|IEEE 802.11]] — 802.11 PCF and HCF have reservation-like mechanisms

## Edge Cases & Gotchas
- Explicit DAMA: higher delay under light load (must go through request phase first)
- PRMA: voice activity detection is critical — if a voice call ends but the speaker is silent (no packet), the reservation is released
- PRMA drop probability must be kept very low (e.g., 1%) for voice quality
- PRMA requires a voice activity detector to efficiently use slots during silence periods

## Sources
- [[wireless-n-summary|WirelessN.md]]