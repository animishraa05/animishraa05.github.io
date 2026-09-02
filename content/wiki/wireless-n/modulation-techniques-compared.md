---
title: Modulation Techniques Compared
type: comparison
tags: [networking, modulation]
created: 2026-04-21
updated: 2026-04-21
---

## Framing
This synthesis compares the digital modulation techniques covered in the wireless communications source: FSK, MSK, and GMSK. These techniques differ in how they represent binary data on a carrier wave and in their spectral efficiency.

## Comparison

| Property | FSK (Standard) | MSK | GMSK |
|---|---|---|---|
| **Phase** | Discontinuous (reset at each bit) | Continuous | Continuous |
| **Frequency Separation** | Arbitrary (can be large) | Minimum orthogonal (1/2T) | Minimum (Gaussian filtered) |
| **Spectral Efficiency** | Low (frequency splatter) | High (tight bandwidth) | Highest (Gaussian filter tightens) |
| **Phase Reset** | Yes — at every bit | No | No |
| **Complexity** | Low | Medium | Medium |
| **Used In** | Simple paging, remote controls | Military radio | GSM (2G) cellular |
| **Noise Resistance** | Moderate | High | High |

## Key Insights

### Why Phase Continuity Matters
Standard FSK resets the carrier wave at each bit boundary. If the previous bit ended at a negative phase, the new bit starts from zero phase, creating a sharp discontinuity. These discontinuities generate high-frequency components ("frequency splatter") that waste bandwidth and interfere with adjacent channels. MSK and GMSK eliminate discontinuities entirely, producing tight, well-contained spectra.

### The Minimum Shift Condition
MSK uses the minimum possible frequency separation for orthogonality: Δf = 1/(2T), where T is the bit duration. Two signals separated by exactly this amount have zero cross-correlation — the receiver can perfectly distinguish them. Any smaller separation would make the signals indistinguishable.

### From MSK to GMSK
GMSK applies a Gaussian filter before MSK modulation, pre-shaping the frequency pulses. This further reduces spectral sidelobes, making the signal even more bandwidth-efficient. GSM chose GMSK because its constant envelope property allows efficient power amplification — the power amplifier can operate at maximum output without distorting the signal.

### Real-World Progression
In practice, all modern digital systems have moved beyond standard FSK: FSK → CPFSK → MSK → GMSK → QPSK/OQPSK. Higher-order modulation schemes (16-QAM, 64-QAM, 256-QAM) are now used in LTE and 5G for even higher data rates.

## Connections
- [[frequency-shift-keying|FSK]] — standard FSK with phase reset
- [[minimum-shift-keying|MSK]] — continuous-phase FSK
- [[modulation|Modulation]] — foundational concept
- [[spread-spectrum|Spread Spectrum]] — modulation technique that spreads signal across wide bandwidth