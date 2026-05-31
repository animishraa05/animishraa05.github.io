---
concept: TCP Packet Drop
aliases: [packet loss, dropped packet, TCP retransmission]
tags: [networking, tcp]
sources_count: 1
last_source: https.md
created: 2026-04-30
updated: 2026-04-30
---

# TCP Packet Drop

## The Problem

Packets can get lost in the network (router congestion, cable issues, buffer overflow). Without handling packet loss, data transfers would fail randomly and unpredictably.

## Core Idea

When a TCP packet is dropped (lost in network), TCP detects the loss (via timeout or duplicate ACKs) and retransmits the packet. This ensures reliable delivery despite unreliable underlying networks.

## How It Works

1. **Packet sent**: TCP sends packet with sequence number
2. **Packet lost**: Router drops packet (congestion, error)
3. **Timeout**: Sender doesn't receive ACK within timeout
4. **Retransmit**: Sender resends the packet
5. **Congestion control**: TCP reduces sending rate (slow start, congestion avoidance)

TCP treats packet drops as a signal of network congestion.

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Sender [label="Sender"];
    Packet [label="Packet #100\nLOST"];
    Timeout [label="Timeout\n(no ACK)"];
    Retry [label="Retransmit\nPacket #100"];
    Receiver [label="Receiver"];
    
    Sender -> Packet [label="send"];
    Packet -> Timeout [label="lost"];
    Timeout -> Retry -> Receiver;
}
```

## Key Properties

- Detected via timeout or 3 duplicate ACKs
- Triggers retransmission automatically
- Reduces congestion window (slows down sending)
- Part of TCP's reliability guarantees

## Connections

- **Built from:** [[tcp-handshake|TCP Handshake]] — TCP connection must exist
- **Related:** [[congestion-control|Congestion Control]] — packet drop triggers slowdown
- **Related:** [[timeout|Timeout]] — mechanism to detect lost packets
- **Contrasts with:** [[udp|UDP]] — UDP doesn't handle packet loss

## Edge Cases & Gotchas

- Too-short timeout = unnecessary retransmissions
- Too-long timeout = slow recovery
- Congestion collapse if many TCP flows don't back off
- Some networks drop packets intentionally (policing)

## Sources

- [[https-summary|HTTP HTTPS DNS URL Source]]
