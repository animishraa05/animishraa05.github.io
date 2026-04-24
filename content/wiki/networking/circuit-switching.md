---
concept: Circuit Switching
aliases: [circuit switching, circuit-switched network]
tags: [networking, switching]
created: 2026-04-11
updated: 2026-04-11
---

# Circuit Switching

## The Problem
Two parties need a guaranteed, dedicated communication channel for the duration of their conversation. They need consistent latency and no interference from other traffic. How do you guarantee this on a shared physical infrastructure?

## Core Idea
Before any data is sent, a **dedicated physical path** is established through the network from source to destination. This path is reserved exclusively for this conversation for its entire duration. No other traffic can use the reserved resources. When the conversation ends, the circuit is torn down and resources are freed.

## How It Works
1. **Connection setup** — source sends a setup request; each intermediate node reserves bandwidth on its outgoing link
2. **Data transfer** — once the circuit is established, data flows continuously along the reserved path
3. **Connection teardown** — when done, a teardown signal frees all reserved resources

## Key Properties
- **Reserved bandwidth** — the full capacity of the reserved path is guaranteed to this conversation
- **Fixed latency** — no queuing delays from competing traffic once the circuit is established
- **Setup overhead** — the initial setup takes time; short-lived communication pays this cost disproportionately
- **Resource waste during silence** — if no data is being sent, the reserved bandwidth sits idle

## Connections
- Contrasts with: [[packet-switching|Packet Switching]] — dedicated vs shared, fixed vs dynamic, no setup vs setup cost
- Related: [[connection-oriented-service|Connection-Oriented Service]] — circuit switching is the physical implementation of connection-oriented service
- Related: [[client-server-model|Client-Server Model]] — the connection setup mirrors the connect-communicate-release pattern

## Edge Cases & Gotchas
- **Wasted capacity** — human conversations have ~50% silence time; circuit switching reserves bandwidth even during silence
- **Scalability limit** — the number of simultaneous circuits is bounded by the number of physical channels
- **Not just telephony** — optical networks (WDM) use circuit-switching-like wavelength reservation
- **Modern hybrid** — MPLS and ATM blend circuit-switching predictability with packet-switching flexibility

## Sources
- [[../sources/computer-networks-intro-summary|Computer Networks — Introduction (raw source)]]
