---
concept: Buffering
aliases: [I/O Buffering, Buffer Cache]
tags: [systems, io]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

Devices operate at different speeds (CPU is fast, disk is slow, keyboard is very slow). Data transfer between them needs temporary storage to bridge the speed gap.

## Core Idea

Buffering is the use of temporary storage (in memory) to hold data while it's being transferred between devices or between a device and an application.

## How It Works

1. Data from slow device stored in buffer (memory)
2. Fast device/CPU can read from buffer at its own speed
3. Buffer decouples producer and consumer of data
4. Can be single buffer, double buffer, or circular buffer

```dot
digraph buffer {
  rankdir=LR;
  node [shape=box, style=filled];
  
  Slow [label="Slow Device\n(disk, keyboard)", fillcolor=lightgray];
  Buf [label="Buffer\n(memory)", fillcolor=lightyellow];
  Fast [label="Fast Device/CPU", fillcolor=lightgreen];
  
  Slow -> Buf [label="fill buffer"];
  Buf -> Fast [label="consume"];
}
```

## Key Properties

- Decouples speed differences between devices
- Can be single, double, or circular buffer
- Block devices use buffer cache (disk blocks)
- Character devices use line buffers or raw mode



## Semantic Network

```dot
graph semantic_Buffering {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Buffering" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- **Built from:** [[io-system|I/O System]], [[device-independent-io-software|Device-Independent I/O Software]]
- **Builds into:** [[io-request-to-hardware|I/O Request to Hardware Operation]]
- **Related:** [[device-driver|Device Driver]], [[dma|DMA]]
- **Contrasts with:** [[no-buffering|No Buffering]] (unbuffered I/O is slow)

## Edge Cases & Gotchas

- Buffer overflow if consumer too slow
- Buffer too small = frequent I/O operations
- Buffer too large = wasted memory