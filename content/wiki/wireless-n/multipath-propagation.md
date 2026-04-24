---
concept: Multipath Propagation
aliases: [multipath-fading, multipath-effect]
tags: [networking, wireless]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

# Multipath Propagation

## The Problem
When a radio signal is transmitted, it does not travel in a single straight line to the receiver. Instead, it bounces off buildings, walls, vehicles, and other obstacles, creating multiple copies of the same signal that travel different paths. Each path has a different length, so these copies arrive at the receiver at different times. This causes signal distortion called Inter-Symbol Interference (ISI), where adjacent symbols overlap in time.

## Core Idea
Multipath propagation is the phenomenon where a transmitted radio signal arrives at the receiver via multiple paths (direct, reflected, diffracted, scattered), each with different delays and amplitudes. The receiver sees a composite of all these copies.

## How It Works
1. The transmitter sends a single signal pulse
2. The signal takes multiple paths: direct line-of-sight, reflection off buildings, diffraction over obstacles, scattering from rough surfaces
3. Each path has a different physical length, causing different travel times
4. The receiver captures all copies simultaneously — they add up (superpose)
5. If path delays are significant relative to the bit period, adjacent bits overlap — this is ISI
6. The composite signal can be stronger (constructive) or weaker (destructive) depending on phase alignment

The delay spread (difference between earliest and latest arriving paths) determines the severity of ISI.

## Key Properties
- Causes Inter-Symbol Interference (ISI) when delay spread exceeds bit duration
- Results in frequency-selective fading — some frequencies are boosted, others are attenuated
- More severe in urban environments with many reflecting surfaces
- Can be exploited using diversity techniques (multiple receive antennas)
- Doppler spread from motion causes time-varying multipath effects

## Connections
- Built from: [[channel-fading|Channel Fading]] — the constructive/destructive combination of multipath signals causes fading
- Related: [[modulation|Modulation]] — modulation scheme choice affects how vulnerable the signal is to multipath-induced ISI
- Related: [[diversity-antenna|Diversity Antenna]] — using multiple antennas reduces multipath problems
- Related: [[direct-sequence-spread-spectrum|DSSS]] — spreading code helps filter out multipath noise

## Edge Cases & Gotchas
- In dense urban areas, multipath can create 10+ distinct signal paths
- High-speed mobility (e.g., in a car) causes rapidly changing multipath patterns
- Simple amplitude-based received signal strength indicators (RSSI) cannot distinguish multipath components
- OFDM (used in Wi-Fi, 4G, 5G) converts one wide band into many narrow subcarriers, each less affected by frequency-selective multipath

## Sources
- [[../wireless-n-summary|WirelessN.md]]