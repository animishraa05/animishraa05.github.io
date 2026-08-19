---
title: "Disk Scheduling Algorithms — Performance and Trade-offs"
type: synthesis
tags: [systems, storage]
created: 2026-04-30
updated: 2026-04-30
---

## Framing

Compare disk scheduling algorithms — **FCFS**, **SSTF**, **SCAN**, **C-SCAN**, **LOOK**, and **C-LOOK** — analyzing seek time reduction, fairness, and practical performance.

## Comparison

| Algorithm | Avg Seek | Starvation | Wait Time Uniformity | Notes |
| --- | --- | --- | --- | --- |
| **FCFS** | Worst | No | Poor | Simple, fair, but slow |
| **SSTF** | Better | Yes (edge tracks) | Poor | Greedy, may starve |
| **SCAN** | Good | No | Medium | Elevator, reverses at end |
| **C-SCAN** | Good | No | Better | One direction only |
| **LOOK** | Good | No | Medium | Stops at last request |
| **C-LOOK** | Good | No | Best | One direction, stops at last |

## Key Insights

1. **FCFS is fair but slow** — no optimization, serves as baseline
2. **SSTF minimizes seek** but can starve requests at disk edges (greedy = not globally optimal)
3. **SCAN (elevator) eliminates starvation** by sweeping back and forth, like an elevator serving floors
4. **C-SCAN improves uniformity** — always goes in one direction, jumps back (no service on return)
5. **LOOK is practical SCAN** — doesn't go to physical disk end if no requests there
6. **C-LOOK is best practical** — combines C-SCAN uniformity with LOOK efficiency

## Synthesis

Modern systems typically use **LOOK or C-LOOK** (often called "deadline" or "noop" schedulers). The SCAN family beats FCFS and SSTF by eliminating starvation while maintaining good performance. Modern disks also do internal scheduling (NCQ) that may override OS scheduling.

## Connections

- [[disk-scheduling|Disk Scheduling]] — overview of all algorithms
- [[fcfs|FCFS]] — first come first serve
- [[sstf|SSTF]] — shortest seek time first
- [[scan-scheduling|SCAN]] — elevator algorithm
- [[c-scan|C-SCAN]] — circular SCAN
- [[look-scheduling|LOOK]] — SCAN variant
- [[c-look|C-LOOK]] — C-SCAN variant
- [[disk-structure|Disk Structure]] — why seek time matters
