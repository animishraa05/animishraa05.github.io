---
concept: Bluetooth
aliases: [bluetooth-standard, IEEE-802-15-1]
tags: [networking, wpan]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Wired cables for peripherals (mouse, keyboard, headset) are inconvenient. Wi-Fi was designed for network connectivity, not device-to-device personal area networking. Bluetooth provides short-range, low-power, low-cost wireless connectivity between personal devices without the overhead of Wi-Fi or the complexity of network setup.

## Core Idea
Bluetooth (IEEE 802.15.1) is a wireless personal area network (WPAN) standard for short-range device-to-device communication. It operates in the 2.4 GHz ISM band, uses FHSS to avoid interference with Wi-Fi and other devices, and is designed for low power consumption and simple pairing.

## How It Works

**Physical and MAC Layer:**
- **Radio Layer:** 2.4 GHz ISM band; FHSS with 1,600 hops/second across 79 channels
- **Baseband Layer:** Time slots of 625 µs; synchronous connections for voice, asynchronous for data
- **LMP (Link Manager Protocol):** Manages link setup, authentication, encryption
- **L2CAP (Logical Link Control and Adaptation Protocol):** Multiplexes multiple channels, handles QoS
- **RFCOMM:** Emulates serial port (RS-232) for legacy device support
- **SDP (Service Discovery Protocol):** Discovers services on paired devices

**Architecture:**
- **Piconet:** One master + up to 7 active slaves; all communication goes through master
- **Scatternet:** Multiple piconets interconnected through shared slaves
- **Master/Slave roles:** Determined at pairing; masters control frequency hopping

**Versions:**
- **Bluetooth 1.0/1.0b:** Initial; 723 kbps; many interoperability issues
- **Bluetooth 2.0 + EDR:** 3 Mbps; faster pairing
- **Bluetooth 3.0 + HS:** 24 Mbps; uses Wi-Fi for high-speed data transfer
- **Bluetooth 4.0 + LE:** Bluetooth Low Energy; 1 Mbps; years of battery life (IoT)
- **Bluetooth 5.0:** 2 Mbps + LE; improved range and broadcast (Beacons)
- **Bluetooth 5.1:** Direction finding (AoA/AoD) for indoor positioning
- **Bluetooth 5.3+:** LE Audio; Auracast; LC3 codec

## Key Properties
- Master/slave architecture: master controls the piconet timing
- FHSS: 1,600 hops/second avoids narrowband interference; no co-channel interference
- Low power: designed for battery-powered devices (LE variants especially)
- Simple pairing: no network setup required; devices discover and pair
- Coexists with Wi-Fi in 2.4 GHz band without interference due to FHSS
- Range: ~10 m for standard, up to 200 m for extended range (Bluetooth 5.0+)

## Connections
- Related: [[ieee-802-11|IEEE 802.11]] — both operate in 2.4 GHz but coexist without interference
- Related: [[ieee-802-15|IEEE 802.15]] — Bluetooth IS the 802.15.1 standard
- Related: [[spread-spectrum|Spread Spectrum]] — Bluetooth uses FHSS spread spectrum
- Related: [[wifi-zigbee-comparison|Wi-Fi vs Bluetooth vs ZigBee]] — comparison of short-range wireless standards
- Related: [[frequency-hopping-spread-spectrum|FHSS]] — Bluetooth's specific spread spectrum technique

## Edge Cases & Gotchas
- The 2.4 GHz ISM band is shared by Wi-Fi, Bluetooth, microwave ovens, cordless phones, and ZigBee — interference is managed by FHSS
- Range is limited (10 m) — not suitable for longer-range applications
- Security was weak in early versions (Bluetooth 1.0); PIN-based pairing was vulnerable
- BLE (Bluetooth Low Energy) is a different physical layer from classic Bluetooth

## Sources
- [[wireless-n-summary|WirelessN.md]]