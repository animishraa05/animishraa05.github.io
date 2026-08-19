---
concept: Minimum Shift Keying
aliases: [MSK, minimum-shift-keying, continuous-phase-FSK]
tags: [networking, modulation]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Standard FSK resets the carrier wave at every bit boundary, causing phase discontinuities (sharp corners) that generate "frequency splatter" — unwanted high-frequency components that waste bandwidth and interfere with adjacent channels. MSK was designed to solve this specific problem while maintaining the minimum possible frequency separation for orthogonality.

## Core Idea
MSK is a continuous-phase frequency shift keying technique where the carrier frequency shifts between two values (for bit 1 and bit 0) without any phase reset. The frequency separation is kept at the mathematical minimum required for the receiver to distinguish the two signals. This produces a smooth, unbroken waveform with no frequency splatter.

## How It Works
1. **Phase Memory:** Unlike standard FSK, MSK does NOT reset the carrier wave at bit boundaries. The new frequency starts exactly where the previous frequency ended — a continuous phase transition.
2. **Minimum Frequency Separation:** The frequency shift Δf = 1/(2T) where T is the bit duration — this is the minimum possible separation for orthogonal signals (where the cross-correlation is zero).
3. **Continuous Phase FSK (CPFSK):** MSK is a special case of CPFSK with minimum frequency separation.
4. **Waveform construction (Even/Odd Split Method):** Data bits are split into even and odd positions; each is stretched to 2 slots. Reference waves (low frequency completing half cycle per slot, high frequency completing full cycle per slot) are copied or inverted based on the data bit. The resulting signal is smooth throughout.

The smooth waveform avoids sharp discontinuities, which means no high-frequency spectral leakage.

## Key Properties
- Continuous phase: no phase reset, no frequency splatter
- Minimum orthogonal frequency separation: Δf = 1/(2T)
- High spectral efficiency: bandwidth is very tight and well-contained
- Constant envelope: power amplifier operates at maximum efficiency
- Used as the basis for GMSK (Gaussian MSK) in GSM
- QPSK can be viewed as two orthogonal MSK signals combined

## Connections
- Built from: [[frequency-shift-keying|FSK]] — MSK is the continuous-phase variant of FSK
- Built from: [[modulation|Modulation]] — MSK is a digital modulation technique
- Related: [[gsm|GSM]] — GSM uses GMSK (Gaussian MSK), which applies a Gaussian filter to MSK
- Related: [[phase-shift-keying|PSK]] — PSK (especially QPSK) is related to MSK and used alongside it in many systems
- Related: [[direct-sequence-spread-spectrum|DSSS]] — both MSK and DSSS are spectrally efficient digital modulation techniques
- Related: [[spread-spectrum|Spread Spectrum]] — MSK is a continuous-phase spread spectrum modulation technique

## Edge Cases & Gotchas
- MSK is rarely used directly in its raw form — GMSK (with Gaussian filtering) is the practical variant
- The continuous phase property is critical — even small timing errors can break orthogonality
- MSK and offset-QPSK (OQPSK) are closely related; OQPSK uses the same even/odd bit splitting method
- In practice, MSK is filtered with a Gaussian filter before transmission to further smooth transitions

## Sources
- [[wireless-n-summary|WirelessN.md]]