---
concept: Packet Switching
aliases: [packet switching, datagram switching]
tags: [networking, switching, data-link]
created: 2026-04-11
updated: 2026-04-11
---

## The Problem
You need to send data across a network shared by many users. If you dedicate the entire channel to one conversation (like a phone call), most of the channel sits idle during pauses. That's wasteful. How do you share a single physical medium among thousands of conversations efficiently?

## Core Idea
Break the data into small chunks called **packets**. Each packet carries the destination address. Packets from different conversations share the same physical links. Each packet may take a different route to the destination. The receiver reassembles them in order.

## How It Works
1. Data is segmented into packets of bounded size
2. Each packet gets a header with: source address, destination address, sequence number, error-checking info
3. Packets are forwarded independently by intermediate nodes (routers)
4. Different packets may take different paths
5. Destination reassembles based on sequence numbers

## Key Properties
- **Statistical multiplexing** — link capacity is shared dynamically, not pre-allocated
- **No dedicated path** — packets from the same conversation compete with others for bandwidth
- **Store-and-forward** — each router receives the full packet, checks it, then forwards
- **Robust** — if one path fails, packets can reroute through other paths

## Connections
- Contrasts with: [[circuit-switching|Circuit Switching]] — dedicated path vs shared, fixed bandwidth vs dynamic
- Related: [[point-to-point-links|Point-to-Point Links]] — packets are the unit of communication on point-to-point networks
- Related: [[osi-model-layers|OSI Model — Seven Layers]] — packets are Network Layer (L3) units
- Built from: [[layered-architecture-networking|Layered Architecture in Networking]] — packets exist because of layering
- Related: [[broadcast-links|Broadcast Links]] — in broadcast networks, all nodes receive every packet but only process addressed ones

## Edge Cases & Gotchas
- **Out-of-order delivery** — packets may arrive in different order than sent; reassembly must handle this
- **Packet loss** — if a router's buffer is full, it drops packets; higher layers must detect and retransmit
- **Head-of-line blocking** — a delayed packet at the front of a queue can block packets behind it
- **Not the same as message switching** — message switching sends the entire message as one unit; packet switching breaks it into smaller pieces