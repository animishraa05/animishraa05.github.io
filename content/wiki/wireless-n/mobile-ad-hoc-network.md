---
concept: Mobile Ad Hoc Network
aliases: [MANET, ad-hoc-network, mobile-mesh]
tags: [networking, manet]
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Infrastructure-based wireless networks (Wi-Fi, cellular) require pre-deployed base stations or access points. In disaster zones, battlefields, or remote areas, pre-deployed infrastructure doesn't exist. Mobile Ad Hoc Networks (MANETs) enable devices to communicate directly with each other without any pre-existing infrastructure, by dynamically forming multi-hop routes through intermediate devices.

## Core Idea
A Mobile Ad Hoc Network (MANET) is a self-configuring network of mobile devices that connect and route data through each other. Devices act as both hosts (running applications) and routers (forwarding packets for other devices). Routes are discovered and maintained dynamically as devices move.

## How It Works

**Key Characteristics:**
1. **Self-Organizing:** No central infrastructure; devices discover neighbors and form a network
2. **Multi-Hop Routing:** If the destination is out of range, intermediate devices forward the packet
3. **Dynamic Topology:** Devices move, join, and leave — topology changes continuously
4. **Distributed Operation:** All devices participate in routing, security, and network management

**Routing Protocols:**
- **Proactive (Table-Driven):** Routes maintained continuously; fast lookup but high overhead (e.g., DSDV, OLSR)
- **Reactive (On-Demand):** Routes discovered only when needed; low overhead but high delay (e.g., AODV, DSR)
- **Hybrid:** Combines proactive (local) and reactive (remote) approaches (e.g., ZRP)

**Applications:**
- Military: battlefield communication without fixed infrastructure
- Emergency: disaster response when base stations are down
- Sensor networks: environmental monitoring
- Vehicle-to-vehicle (V2V) communication

## Key Properties
- No infrastructure: self-healing, resilient to device failures
- Multi-hop: can connect devices far beyond single-hop range
- Dynamic topology: routes must be continuously maintained
- Limited resources: mobile devices have limited battery, CPU, and memory
- Security challenges: no trusted infrastructure; vulnerable to attacks on routing protocols
- Routing overhead increases with mobility

## Connections
- Built from: [[wireless-network|Wireless Network]] — the foundational wireless technology
- Related: [[ieee-802-11|IEEE 802.11]] — ad hoc mode in 802.11 enables MANET-like communication
- Related: [[routing-protocols|Routing Protocols]] — DSR, AODV, OLSR are designed for MANETs
- Related: [[mobile-opportunistic-network|Mobile Opportunistic Network]] — evolution of MANET for challenged networks
- Related: [[wireless-sensor-network|Wireless Sensor Network]] — a specific type of MANET

## Edge Cases & Gotchas
- MANET routing protocols have conflicting design goals: low overhead vs. fast convergence
- Battery is the primary constraint — routing must balance energy
- Security is critical: routing attacks (black holes, worm holes) are easy to launch
- Not suitable for real-time applications without explicit QoS support