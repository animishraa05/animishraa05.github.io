---
concept: WiMAX
aliases: [IEEE-802-16, wimax-standard]
tags: [networking, wlan]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

# WiMAX

## The Problem
Wi-Fi has limited range (100 m outdoors) and is designed for local area networking. Cellular networks provide wide area coverage but are operator-controlled and expensive. WiMAX was designed to provide metropolitan-scale broadband wireless access with higher data rates than Wi-Fi and wider coverage than Wi-Fi, while being standards-based and equipment-interoperable.

## Core Idea
WiMAX (IEEE 802.16) is a metropolitan area wireless broadband standard providing fixed, nomad, and mobile broadband access. It operates in the 2.5 GHz and 3.5 GHz bands, provides up to 75 Mbps over 50 km ranges, and uses OFDM for efficient multi-path handling and scalability.

## How It Works

**Physical Layer:**
- OFDM: up to 2048 subcarriers for efficient spectrum use and multi-path resistance
- Bands: 2.5–2.7 GHz (mobile WiMAX) and 3.3–3.8 GHz (fixed WiMAX)
- Channel bandwidth: 3.5–10 MHz (scalable)
- Modulation: QPSK to 64-QAM (adaptive based on channel conditions)
- MIMO: beamforming and spatial multiplexing for capacity

**MAC Layer:**
- Connection-oriented: each flow has a unique CID (Connection ID)
- QoS: five service classes (UGS, rtPS, nrtPS, BE, ertPS)
- ARQ: automatic repeat request for reliable delivery
- Bandwidth request/grant mechanism (similar to DOCSIS cable modem)

**Architecture:**
- Base station (BS): provides coverage for metro area
- Subscriber station (SS): customer premise equipment
- Two profiles: FDD and TDD

**Versions:**
- **802.16-2004 (fixed):** Line-of-sight; up to 50 km; 75 Mbps
- **802.16e-2005 (mobile):** Non-line-of-sight; mobility support; MIMO; up to 75 Mbps
- **802.16j:** Relay (multihop) extension
- **802.16m (WiMAX Release 2):** Advanced; 4G competitor to LTE

## Key Properties
- Metropolitan scale: up to 50 km coverage (vs. 100 m for Wi-Fi)
- Standards-based: equipment from multiple vendors is interoperable
- QoS: five service classes for real-time and data applications
- OFDM for efficient spectrum and multi-path resistance
- Both fixed (line-of-sight) and mobile (non-line-of-sight) profiles

## Connections
- Related: [[ieee-802-11|IEEE 802.11]] — Wi-Fi's competitor for local area networking
- Related: [[wimax-vs-wifi|WiMAX vs Wi-Fi]] — comparison of metropolitan vs. local area wireless
- Related: [[lte|LTE]] — WiMAX's main competitor as 4G technology
- Related: [[ofdm|OFDM]] — the modulation technique used in WiMAX, Wi-Fi, and LTE
- Related: [[zigbee|ZigBee]] — another 802.15 standard for low-rate WPAN

## Edge Cases & Gotchas
- WiMAX spectrum is licensed — operators must buy licenses
- WiMAX never achieved the scale that LTE did (Wi-Fi won local, LTE won mobile)
- Many WiMAX operators migrated to LTE
- Line-of-sight fixed WiMAX (802.16-2004) was an alternative to DSL but never scaled
- Mobile WiMAX (802.16e) was the first 4G contender but lost to LTE

## Sources
- [[wireless-n-summary|WirelessN.md]]