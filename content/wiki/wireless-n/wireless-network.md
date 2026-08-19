---
concept: Wireless Network
aliases: [wireless-networking, mobile-communications]
tags: [networking, wireless]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Standard wired networks use dedicated physical cables for communication. In mobile environments, users need to communicate while moving, without being tethered to a fixed infrastructure. Wireless networks replace cables with radio waves, but this introduces new challenges: shared medium (anyone can intercept), signal degradation over distance, interference from obstacles, and limited bandwidth due to regulated spectrum.

## Core Idea
A wireless network is a communication network where devices exchange data using radio waves through an open medium (air) instead of physical cables. The core challenge is managing the shared, unreliable radio channel while supporting device mobility.

## How It Works
1. Data from the application layer is converted into digital bits
2. Bits are modulated onto a carrier radio wave (converting digital to analog)
3. The modulated signal is transmitted via an antenna into the air
4. The signal travels through the radio channel, subject to multipath propagation and fading
5. The receiving antenna captures the signal, and demodulation recovers the bits
6. The bits are reassembled into the original data for the application

Wireless networks operate in regulated frequency bands (e.g., 800 MHz–900 MHz for GSM, 2.4 GHz for Wi-Fi/Bluetooth).

## Key Properties
- Shared medium: Anyone within range can potentially receive the signal — security is a concern
- Broadcast nature: A single transmission can reach multiple receivers
- No dedicated path: Devices compete for the same radio spectrum
- Mobility support: Users can move between cells while maintaining connectivity
- Signal degradation: Strength drops with distance (inverse square law) and is affected by obstacles
- Limited bandwidth: Spectrum is regulated and shared among many users and services

## Connections
- Built from: [[modulation|Modulation]] — without modulating data onto a carrier, wireless transmission is impossible
- Built from: [[multiplexing|Multiplexing]] — without multiplexing, multiple users cannot share the spectrum
- Built from: [[multipath-propagation|Multipath Propagation]] — signals rarely travel in a straight line through the air
- Related: [[cellular-mobile-system|Cellular Mobile System]] — the architecture that makes wide-area wireless possible

## Edge Cases & Gotchas
- Signal can be blocked by buildings, walls, and even people (shadowing)
- Rain and atmospheric conditions can absorb radio waves (especially at higher frequencies)
- The same frequency cannot be reused in adjacent cells without causing co-channel interference
- Mobile devices have limited battery power — transmission must be energy-efficient

## Sources
- [[wireless-n-summary|WirelessN.md]]