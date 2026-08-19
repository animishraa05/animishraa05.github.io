---
concept: Segmentation
aliases: [Segmented Memory, Variable-Size Partitioning]
tags: [systems, memory]
sources_count: 1
last_source: io.md
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

Paging uses fixed-size pages, which don't match program structure (code, data, stack are different logical units). We need variable-size chunks that match program semantics.

## Core Idea

Segmentation divides memory into variable-size logical units (segments) like code, data, stack, each with a segment table mapping to physical memory.

## How It Works

1. Program divided into segments (code, data, stack, heap)
2. Each segment has: base address, limit (size)
3. Segment table maps segment number → (base, limit)
4. Address = segment number + offset within segment
5. Hardware checks offset < limit (protection)

```dot
digraph seg {
  rankdir=LR;
  node [shape=box, style=filled];
  
  SegTable [label="Segment Table\nSeg0: base=1000, limit=500\nSeg1: base=1500, limit=300", fillcolor=orange];
  Segs [label="Segments\nCode, Data,\nStack, Heap", fillcolor=lightblue];
  
  SegTable -> Segs [label="maps to"];
}
```

## Key Properties

- Variable-size segments (no internal fragmentation)
- Matches program structure (logical units)
- External fragmentation (gaps between segments)
- Easier sharing (share entire segment)

## Connections

- **Built from:** [[virtual-memory|Virtual Memory]], [[wiki/io/paging|Paging]]
- **Builds into:** [[paging-vs-segmentation|Paging vs Segmentation]]
- **Related:** [[segment-table|Segment Table]], [[external-fragmentation|External Fragmentation]]
- **Contrasts with:** [[wiki/io/paging|Paging]] (variable vs fixed size)

## Edge Cases & Gotchas

- External fragmentation: gaps between segments
- Segment table overhead per process
- Segment bounds checking required (hardware)

## Sources

- [[io-summary|I/O System Source Summary]]
