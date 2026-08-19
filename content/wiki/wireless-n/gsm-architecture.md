---
concept: GSM Architecture
aliases: [GSM, global-system-for-mobile]
tags: [networking, gsm]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
A cellular mobile network requires coordinated management of radio resources, call routing, subscriber databases, and mobility across many cells and thousands of users. Simply connecting base stations to the public switched telephone network (PSTN) is insufficient — the network needs specialized subsystems to handle radio access, switching, authentication, and network operations.

## Core Idea
GSM architecture is organized into three hierarchical subsystems: RSS (Radio Subsystem — handles the air interface), NSS (Network and Switching Subsystem — handles call routing and databases), and OSS (Operation Subsystem — handles network management and security). Users only see Mobile Stations (MS) and BTS antenna masts, but the entire infrastructure is coordinated.

## How It Works

**RSS (Radio Subsystem):**
- **MS (Mobile Station):** User device with Mobile Equipment (ME, identified by IMEI) and SIM card (identified by IMSI)
- **BTS (Base Transceiver Station):** Physical antenna and transceivers; performs radio modulation/demodulation, channel coding, error correction
- **BSC (Base Station Controller):** Controls multiple BTSs; allocates radio resources, manages intra-BSC handovers

**NSS (Network and Switching Subsystem):**
- **MSC (Mobile Switching Center):** High-performance digital ISDN switch; call setup, routing, inter-BSC handover
- **HLR (Home Location Register):** Central database of all subscribers; permanent data (IMSI, services), current location
- **VLR (Visitor Location Register):** Temporary database attached to each MSC; caches subscriber data from HLR for fast access
- **GMSC (Gateway MSC):** Interface between GSM and external networks (PSTN, ISDN); routes incoming calls

**OSS (Operation Subsystem):**
- **AUC (Authentication Center):** Generates security triplets (RAND, SRES, Kc) for SIM authentication and call encryption
- **EIR (Equipment Identity Register):** Tracks device IMEI numbers; maintains white/grey/black lists
- **OMC (Operation and Maintenance Center):** Network monitoring, alarm management, remote configuration

**Key Interfaces:**
- **Um interface:** MS ↔ BTS (air interface, wireless radio)
- **Abis interface:** BTS ↔ BSC (wired links, 16/64 kbps)
- **A interface:** BSC ↔ MSC (2 Mbps PCM)
- **O interface:** BSC/MSC ↔ OMC (SS7 signaling)

## Connections
- Built from: [[cellular-mobile-system|Cellular Mobile System]] — GSM is the most widely deployed 2G cellular system
- Built into: [[gsm-services|GSM Services]] — bearer, tele, and supplementary services
- Built into: [[gsm-air-interface|GSM Air Interface]] — Um interface protocols
- Related: [[handoff|Handoff]] — inter-BSC/inter-MSC handovers are MSC functions
- Related: [[gsm-location-updates|Location Updates]] — HLR/VLR update mechanism for mobility
- Related: [[authentication-center|AUC]] — security subsystem for SIM verification

## Edge Cases & Gotchas
- N=7 cluster is standard; smaller clusters (N=4) increase capacity but reduce C/I ratio
- Sectoring: 3 sectors per cell is common; reduces co-channel interference by factor of 3
- GSM frequency bands: GSM 900 (890–915/935–960 MHz), GSM 1800 (1710–1785/1805–1880 MHz), GSM 1900 (1850–1910/1930–1990 MHz)
- GSM-Rail (GSM-R): specialized variant for railroad control with priority calls and VGCS/VBS

## Sources
- [[wireless-n-summary|WirelessN.md]]