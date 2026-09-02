---
concept: Modulation
aliases: [digital-modulation, analog-modulation]
tags: [networking, modulation]
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Digital data (bits: 0s and 1s) cannot be directly transmitted over radio waves in the air. To transmit data wirelessly, the digital information must be converted into an analog waveform that can propagate through the radio channel. Additionally, low-frequency data would require impractically large antennas — modulation allows data to ride on high-frequency carriers that work with small, practical antennas.

## Core Idea
Modulation is the process of encoding digital information onto a high-frequency carrier wave by varying one or more of its properties: amplitude, frequency, or phase. The receiver then demodulates to recover the original data.

## How It Works
1. The digital data stream (bits) needs to be transmitted over the air
2. A high-frequency sinusoidal carrier wave is generated (e.g., 900 MHz for GSM)
3. The digital data modifies one or more properties of the carrier:
   - **Amplitude Shift Keying (ASK):** Bit 1 = high amplitude, Bit 0 = low amplitude
   - **Frequency Shift Keying (FSK):** Bit 1 = high frequency, Bit 0 = low frequency
   - **Phase Shift Keying (PSK):** Bit 1 = phase 0°, Bit 0 = phase 180° (or other phase shifts)
4. The modulated wave is transmitted via the antenna
5. At the receiver, the carrier is detected and the data is recovered through demodulation

## Key Properties
- Enables transmission of digital data over analog radio channels
- High-frequency carriers allow small antennas (antenna length ≈ wavelength/4)
- Allows multiple users to share the spectrum through different carrier frequencies (frequency division)
- Different modulation schemes have different bandwidth efficiencies and noise tolerances
- Trade-off: Higher-order modulation (more bits per symbol) gives higher data rates but is more vulnerable to noise

## Connections
- Built from: [[wireless-network|Wireless Network]] — modulation is essential for wireless transmission
- Built from: [[multiplexing|Multiplexing]] — different users use different carrier frequencies
- Related: [[frequency-shift-keying|FSK]] — specific digital modulation technique using frequency
- Related: [[minimum-shift-keying|MSK]] — continuous-phase variant of FSK used in GSM
- Related: [[spread-spectrum|Spread Spectrum]] — modulation technique that spreads signal across wide bandwidth

## Edge Cases & Gotchas
- Noisy channels degrade modulation — error correction coding is needed to recover data
- High-order modulation (e.g., 256-QAM) requires very clean signal conditions
- Phase modulation (PSK) is more robust to amplitude noise than ASK
- MSK and GMSK are used in cellular systems because of their spectral efficiency and constant envelope (power efficiency)