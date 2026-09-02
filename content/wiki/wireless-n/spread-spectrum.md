---
concept: Spread Spectrum
aliases: [spread-spectrum-techniques, FHSS, DSSS]
tags: [networking, spread-spectrum]
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Transmitting a narrowband signal over a single frequency makes it vulnerable to jamming, interception, and interference. Additionally, in dense urban environments, many signals compete for the same limited bandwidth, causing mutual interference. Spread spectrum addresses both problems by intentionally spreading the signal across a much wider frequency band than necessary.

## Core Idea
Spread spectrum is a modulation technique that spreads the information signal across a bandwidth far wider than the minimum required. The signal appears as low-power background noise, is resistant to narrowband interference, enables multiple users to share the same band (CDMA), and is difficult to intercept.

## How It Works
There are two primary techniques:

**DSSS (Direct Sequence Spread Spectrum):**
1. The original data bits are combined (XOR) with a high-rate pseudo-random chipping sequence (e.g., 11 chips per bit)
2. The resulting wideband signal is modulated onto a carrier and transmitted
3. The receiver uses the same chipping sequence to despread — narrowband noise is suppressed, desired signal is recovered
4. Used in Wi-Fi (802.11b) and GPS

**FHSS (Frequency Hopping Spread Spectrum):**
1. Transmitter and receiver hop between frequencies according to a shared pseudo-random pattern
2. Each hop is a short dwell on a narrow band; the next hop jumps to a different frequency
3. Interference on any single frequency corrupts only one hop, not the entire transmission
4. Used in Bluetooth (1,600 hops per second)

## Key Properties
- DSSS: Continuous spread; wideband noise filtering; higher complexity
- FHSS: Discrete hopping; simple to implement; resistant to partial jamming
- Both provide low probability of intercept (stealth communication)
- CDMA capability: Multiple users share the same band with different codes (DSSS) or hopping patterns (FHSS)
- FHSS is cheaper and simpler; DSSS is more spectrally efficient

## Connections
- Built from: [[modulation|Modulation]] — spread spectrum is a specific modulation technique
- Built from: [[multipath-propagation|Multipath Propagation]] — DSSS spreading codes help filter out multipath interference
- Related: [[frequency-hopping-spread-spectrum|FHSS]] — Bluetooth's spread spectrum technique
- Related: [[direct-sequence-spread-spectrum|DSSS]] — Wi-Fi's spread spectrum technique
- Related: [[code-division-multiple-access|CDMA]] — uses spread spectrum codes for multiple access

## Edge Cases & Gotchas
- DSSS requires precise code synchronization — timing errors corrupt the despreading process
- FHSS hop sequences must be synchronized between transmitter and receiver; losing sync loses communication
- FHSS devices must hop fast enough to avoid being jammed on any single frequency
- DSSS spreading codes must have good autocorrelation properties to minimize ISI