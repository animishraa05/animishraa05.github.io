---
concept: TCP Handshake
aliases: [TCP three-way handshake, SYN, SYN-ACK, ACK]
tags: [networking, tcp]
sources_count: 2
last_source: https.md
created: 2026-04-12
updated: 2026-04-30
---

## The Problem

Before sending any application data, how do two machines ensure they can actually communicate? Networks are unreliable—packets get lost, duplicated, reordered. Without establishing a reliable connection first, data transfer would be chaos.

## Core Idea

TCP uses a three-way handshake to establish a reliable connection: Client sends SYN → Server responds with SYN-ACK → Client confirms with ACK. This exchange ensures both sides are ready to send and receive data reliably before any actual data flows.

## How It Works

1. **SYN**: Client sends SYN (synchronize) with a random sequence number
2. **SYN-ACK**: Server acknowledges with SYN-ACK (its own sequence number + acknowledges client's)
3. **ACK**: Client confirms with ACK, completing the handshake
4. **Established**: Connection is now open—both sides can send data

This happens before TLS handshake (for HTTPS) and before any HTTP request. It's the foundation of reliable communication.

## Key Properties

- Three packets: SYN → SYN-ACK → ACK
- Establishes sequence numbers for reliable, ordered delivery
- Before this: no guarantee packets will reach
- After this: TCP guarantees delivery, ordering, no duplication
- Takes 1 RTT (round-trip time) to complete
- Part of TCP, not HTTP—HTTP runs on top of TCP

## Connections
- **Built from:** [[socket|Socket]] — TCP handshake creates socket connections
- **Built from:** [[arp-protocol|ARP Protocol]] — IP to MAC resolution before TCP
- **Builds into:** [[tls-handshake|TLS Handshake]] — TLS runs after TCP is established
- **Builds into:** [[http-protocol|HTTP Protocol]] — HTTP runs over TCP connections
- **Builds into:** [[tcp-packet-drop|TCP Packet Drop]] — TCP handles lost packets
- **Related:** [[ip-address|IP Address]] — TCP routes packets to IP addresses

## Edge Cases & Gotchas

- Handshake adds latency—connection reuse (keep-alive) avoids repeated handshakes
- SYN flood attacks exploit the half-open state
- TLS 1.3 reduces handshake to 1 round trip (1-RTT) vs 2 in TLS 1.2
- UDP doesn't have handshake—it's unreliable but faster

## Sources

- [[backend-engineering-basics-summary|Backend Engineering Basics]]