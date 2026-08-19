---
concept: Multiplexing
aliases: [frequency-division-multiplexing, time-division-multiplexing]
tags: [networking, multiplexing]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
The radio spectrum is a limited, shared resource. Multiple users and multiple data streams need to coexist in the same geographical area without colliding with each other. How do multiple independent communications share the same physical medium (air) simultaneously?

## Core Idea
Multiplexing is the technique of combining multiple signals into a single shared medium for transmission. The key strategies are: dividing by space (SDMA), by frequency (FDMA), by time (TDMA), or by code (CDMA).

## How It Works
1. **SDMA (Space Division Multiple Access):** Use directional antennas to isolate signals in different physical directions. Cells reuse the same frequencies because they are geographically separated.
2. **FDMA (Frequency Division Multiple Access):** Assign each user a unique frequency band. All users transmit simultaneously on different frequencies. Filters at the receiver isolate the desired signal. (Used in analog FM radio.)
3. **TDMA (Time Division Multiple Access):** Assign each user a unique time slot within a repeating frame. All users share the same frequency but transmit at different times. (Used in GSM.)
4. **CDMA (Code Division Multiple Access):** All users transmit on the same frequency at the same time. Each user's signal is spread with a unique orthogonal code. Receivers use the code to extract their signal. (Used in 3G cellular.)

## Key Properties
- SDMA: Requires directional or sectorized antennas; enables frequency reuse across cells
- FDMA: Simple to implement; guard bands needed to prevent adjacent channel interference
- TDMA: Requires strict time synchronization; allows one transmitter to use the full frequency bandwidth during its slot
- CDMA: All users share all resources; soft capacity (interference-limited); requires sophisticated power control
- Can be combined: GSM uses both FDMA (carrier frequencies) and TDMA (time slots within each frequency)

## Connections
- Built from: [[modulation|Modulation]] — multiplexing allows different modulated carriers to coexist
- Built into: [[gsm|GSM]] — GSM uses FDMA + TDMA for channel access
- Built into: [[cellular-mobile-system|Cellular Mobile System]] — frequency reuse is a form of space-division multiplexing
- Related: [[code-division-multiple-access|CDMA]] — code-based multiplexing
- Related: [[frequency-reuse|Frequency Reuse]] — spatial multiplexing through geographical separation

## Edge Cases & Gotchas
- Guard bands (FDMA) and guard times (TDMA) waste some capacity to prevent interference
- CDMA is interference-limited — adding more users degrades quality for all users (soft capacity)
- TDMA requires precise synchronization — clock drift can cause slot misalignment
- CDMA codes must be orthogonal to minimize self-interference

## Sources
- [[wireless-n-summary|WirelessN.md]]