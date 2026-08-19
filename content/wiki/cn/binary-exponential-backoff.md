---
concept: Binary Exponential Backoff
aliases: [exponential backoff, BEB]
tags: [networking, data-link]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem
After a collision, if all devices retry immediately, they'll collide again. A randomized waiting mechanism is needed to reduce the probability of repeated collisions.

## Core Idea
An algorithm where the maximum random wait time doubles after each successive collision, reducing retry attempts when the network is congested.

## How It Works
1. First collision: wait random time between 0 and 1 slot time
2. Second collision: wait random time between 0 and 2 slot times
3. Third collision: wait random time between 0 and 4 slot times
4. Nth collision: wait random time between 0 and 2^N slot times (capped at 1024)
5. After successful transmission, the backoff counter resets

## Visual Explanation
```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Collision [label="Collision"];
    Backoff [label="Random wait:\n0 to 2^N slots"];
    Success [label="Success?", shape=diamond];
    
    Collision -> Backoff -> Success;
    Success -> Collision [label="No, N++"];
    Success -> "Reset N=0" [label="Yes"];
}
```

## Key Properties
- Reduces collision probability under high load
- Wait time grows exponentially with repeated collisions
- Capped at maximum backoff (e.g., 1024 slots in Ethernet)
- Used in CSMA/CD and some wireless protocols

## Connections
- Built from: [[csma-cd|CSMA/CD]] — uses this backoff algorithm
- Related: [[collision|Collision]] — triggers backoff
- Related: [[jam-signal|Jam Signal]] — sent before backoff
- Related: [[random-access|Random Access]] — broader category of protocols using backoff

## Edge Cases & Gotchas
- Maximum backoff limit prevents excessive wait times
- Many collisions can still cause long delays (exponential growth)
- Not used in modern full-duplex Ethernet (no collisions to back off from)

## Sources
- [[cn-summary|Computer Networks Gemini Conversation]]
