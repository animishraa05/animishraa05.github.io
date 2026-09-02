---
concept: Acknowledgment
aliases: [ACK, ack]
tags: [networking, transport]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem
The sender needs to know whether the receiver successfully received a packet. Without feedback, the sender would never know if data was lost or corrupted.

## Core Idea
A control message sent by the receiver back to the sender confirming successful receipt of data, typically referencing the sequence number of the received data.

## How It Works
1. Receiver gets a packet, validates it (checksum, etc.)
2. Receiver sends ACK with sequence number (or expected next sequence number)
3. Sender receives ACK and knows data was delivered
4. If sender doesn't receive ACK within timeout, it retransmits the data
5. Cumulative ACKs acknowledge all data up to a certain sequence number

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Sender [label="Sender"];
    Rcvr [label="Receiver"];
    
    Sender -> Rcvr [label="Data (seq=100)"];
    Rcvr -> Sender [label="ACK (ack=101)", style=filled, fillcolor=lightgreen];
}
```

## Key Properties
- Confirms successful delivery to sender
- Can be cumulative (acknowledge multiple packets at once)
- Can be piggybacked on data packets (in full-duplex protocols)
- Timeout + lack of ACK triggers retransmission

## Connections
- Built from: [[reliable-data-transfer|Reliable Data Transfer]] — core mechanism
- Built from: [[sequence-numbers|Sequence Numbers]] — ACKs reference these
- Related: [[piggybacking|Piggybacking]] — ACK attached to data packet
- Related: [[cumulative-acknowledgment|Cumulative Acknowledgment]] — acknowledges through seq num
- Contrasts with: [[negative-acknowledgment|Negative Acknowledgment]] — NAK signals failure

## Edge Cases & Gotchas
- ACK loss can cause unnecessary retransmission (sender times out)
- Duplicate ACKs can signal packet loss (used in TCP fast retransmit)
- Piggybacked ACKs may be delayed if no data to send (timer limits delay)