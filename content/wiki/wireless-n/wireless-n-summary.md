---
source: Wireless Networks (Mobile Communications)
source_path: sources/WirelessN.md
content_hash: wirelessN-20260421
ingested: 2026-04-21
concepts_count: 25
tags: [networking, wireless]
---

# WirelessN.md — Source Summary

## What Was Extracted

This source covers Jochen Schiller's "Mobile Communications" (2nd Edition, Pearson) course material on wireless networks. It includes Units 1–5: wireless fundamentals, MAC protocols, cellular mobile systems, GSM architecture, and emerging technologies. The source contains detailed Hinglish explanations of technical concepts, making it an excellent study resource.

## Concepts Extracted (25)

### Unit 1: Wireless Basics
- [[wireless-network|Wireless Network]]
- [[multipath-propagation|Multipath Propagation]]
- [[channel-fading|Channel Fading]]
- [[modulation|Modulation]]
- [[multiplexing|Multiplexing]]
- [[spread-spectrum|Spread Spectrum]]
- [[frequency-shift-keying|FSK]]
- [[minimum-shift-keying|MSK]]
- [[antenna-types|Antenna Types]]

### Unit 2: MAC Layer
- [[hidden-terminal-problem|Hidden Terminal Problem]]
- [[exposed-terminal-problem|Exposed Terminal Problem]]
- [[near-far-terminal|Near/Far Terminal Effect]]
- [[maca|MACA Protocol]]
- [[dama|DAMA Protocol]]

### Unit 3: Cellular Mobile Systems
- [[cellular-mobile-system|Cellular Mobile System]]
- [[frequency-reuse|Frequency Reuse]]
- [[co-channel-interference|Co-Channel Interference]]
- [[cell-sectoring|Cell Sectoring]]
- [[handoff|Handoff]]

### Unit 4: GSM Architecture
- [[gsm-architecture|GSM Architecture]]
- [[gsm-services|GSM Services]]
- [[gprs|GPRS]]

### Unit 5: WLAN and WPAN
- [[ieee-802-11|IEEE 802.11]]
- [[bluetooth|Bluetooth]]
- [[wimax|WiMAX]]
- [[zigbee|ZigBee]]

### Transport and Ad Hoc
- [[mobile-tcp|Mobile TCP]]
- [[mobile-ad-hoc-network|Mobile Ad Hoc Network]]

## Syntheses Created (2)

- [[modulation-techniques-compared|Modulation Techniques Compared]] — FSK, MSK, GMSK comparison
- [[wireless-mac-problems-compared|Wireless MAC Problems Compared]] — Hidden, Exposed, Near/Far comparison

## Key Takeaways

1. **Wireless is fundamentally different from wired** due to the shared medium, range limitations, and mobility. CSMA/CD fails; wireless requires RTS/CTS (MACA) for collision avoidance and power control.

2. **Cellular architecture enables infinite scaling** through frequency reuse. The key trade-off is C/I (signal quality) vs. N (cluster size, capacity).

3. **Modulation evolves toward continuity:** FSK → MSK → GMSK. Phase continuity eliminates frequency splatter, enabling spectral efficiency. GSM uses GMSK.

4. **GSM is the foundational 2G cellular system.** Three subsystems (RSS, NSS, OSS) manage radio access, switching/routing, and operations/security respectively. HLR and VLR manage subscriber location.

5. **Short-range wireless standards coexist through spread spectrum:** Wi-Fi (DSSS), Bluetooth (FHSS), and ZigBee (DSSS) all operate in 2.4 GHz without destroying each other.

6. **Mobile TCP adaptations (I-TCP, Snooping TCP)** hide wireless link characteristics from the sender's TCP to prevent misfired congestion control.

## Open Questions

- How does 5G NR's flexible numerology change frequency reuse planning?
- What is the role of beamforming in modern cellular (massive MIMO) vs. traditional sectoring?
- How do LPWAN technologies (LoRa, SigFox) compare to ZigBee for IoT?

## Domain Tags
networking, wireless

## Connections

- [[wireless-network|Wireless Network]] — foundational concept covered
- [[cellular-mobile-system|Cellular Mobile System]] — Unit 3 coverage
- [[gsm-architecture|GSM Architecture]] — Unit 4 coverage
- [[ieee-802-11|IEEE 802.11]] — Unit 5 coverage
- [[modulation-techniques-compared|Modulation Techniques Compared]] — synthesis created
- [[wireless-mac-problems-compared|Wireless MAC Problems Compared]] — synthesis created
- [[hidden-terminal-problem|Hidden Terminal Problem]] — Unit 2 coverage
- [[frequency-reuse|Frequency Reuse]] — Unit 3 coverage
- [[multiplexing|Multiplexing]] — Unit 1 coverage
- [[spread-spectrum|Spread Spectrum]] — Unit 1 coverage