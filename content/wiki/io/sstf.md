---
concept: SSTF
aliases: [Shortest Seek Time First, SSTF Disk Scheduling]
tags: [systems, storage]
sources_count: 1
last_source: io.md
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

FCFS can cause the disk arm to travel long distances unnecessarily. We need a smarter approach that minimizes seek time.

## Core Idea

SSTF (Shortest Seek Time First) always picks the request closest to the current disk head position, minimizing seek time.

## How It Works

1. Keep track of current disk head position
2. For each new request, calculate seek distance from current position
3. Service the request with smallest seek distance
4. Repeat until queue empty

```dot
digraph sstf {
  rankdir=LR;
  node [shape=box, style=filled];
  
  Pos [label="Current Head\nPos: 50", fillcolor=lightyellow];
  Queue [label="Queue\n[30, 70, 120]", fillcolor=lightblue];
  Next [label="Next: 30\n(seek=20)", fillcolor=lightgreen];
  
  Pos -> Queue;
  Queue -> Next [label="pick closest"];
}
```

## Key Properties

- Reduces average seek time vs FCFS
- Can cause starvation for distant requests
- Greedy algorithm (local optimum, not global)
- Pros: faster than FCFS. Cons: may starve edge requests

## Connections

- **Built from:** [[disk-scheduling|Disk Scheduling]], [[fcfs|FCFS]]
- **Builds into:** [[scan-scheduling|SCAN]], [[c-scan|C-SCAN]]
- **Related:** [[disk-structure|Disk Structure]]
- **Contrasts with:** [[fcfs|FCFS]] (optimized vs simple)

## Edge Cases & Gotchas

- Starvation: requests at disk edges may never be served if center is busy
- Not optimal globally (greedy choice)
- Must recalculate distances after each service

## Sources

- [[io-summary|I/O System Source Summary]]
