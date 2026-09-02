---
concept: FCFS
aliases: [First Come First Serve, FCFS Disk Scheduling]
tags: [systems, storage]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

When multiple I/O requests arrive for disk access, we need a simple, fair way to decide the order of servicing them.

## Core Idea

FCFS (First Come First Serve) processes disk I/O requests in the exact order they arrive, like a queue at a store.

## How It Works

1. Request queue maintains arrival order
2. Disk arm services requests in FIFO order
3. No reordering or optimization

```dot
digraph fcfs {
  rankdir=LR;
  node [shape=box, style=filled];
  
  Queue [label="Request Queue\n[100, 50, 150, 30]", fillcolor=lightyellow];
  Order [label="Service Order\n100 → 50 → 150 → 30", fillcolor=lightgreen];
  Disk [label="Disk Arm\nfollows order", fillcolor=orange];
  
  Queue -> Order -> Disk;
}
```

## Key Properties

- Simplest disk scheduling algorithm
- Fair (no starvation)
- Can be very inefficient (long seek times)
- Example: queue [100, 50, 150, 30] → services in that order

## Connections

- **Built from:** [[disk-scheduling|Disk Scheduling]], [[disk-structure|Disk Structure]]
- **Builds into:** [[sstf|SSTF]], [[scan-scheduling|SCAN]]
- **Related:** [[disk-structure|Disk Structure]]
- **Contrasts with:** [[sstf|SSTF]] (optimizes vs simple FIFO)

## Edge Cases & Gotchas

- Can cause wild swings across disk (poor performance)
- No consideration of seek distance
- Simple but often impractical for real systems