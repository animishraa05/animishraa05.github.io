---
concept: Paging
aliases: [Memory Paging, Paged Memory Management]
tags: [systems, memory]
sources_count: 1
last_source: io.md
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

Contiguous memory allocation requires a process to be loaded in one continuous block of RAM, causing external fragmentation (wasted gaps between processes). We need non-contiguous allocation.

## Core Idea

Paging divides processes into fixed-size pages and RAM into page frames, allowing non-contiguous allocation and eliminating external fragmentation.

## How It Works

1. Process is divided into **pages** (e.g., 4KB each)
2. RAM is divided into **page frames** of same size
3. **Page table** maps each page to a frame in RAM
4. CPU generates logical address = page number + offset
5. MMU uses page table to translate to physical address = frame number + offset

```dot
digraph paging {
  rankdir=TB;
  node [shape=box, style=filled];
  
  subgraph cluster_proc {
    label="Process (Virtual Memory)";
    P0 [label="Page 0", fillcolor=lightgreen];
    P1 [label="Page 1", fillcolor=lightgreen];
    P2 [label="Page 2", fillcolor=lightgreen];
  }
  
  PT [label="Page Table\nmaps pages to frames", fillcolor=orange];
  
  subgraph cluster_ram {
    label="RAM (Physical Memory)";
    F5 [label="Frame 5", fillcolor=lightblue];
    F2 [label="Frame 2", fillcolor=lightblue];
    F7 [label="Frame 7", fillcolor=lightblue];
  }
  
  P0 -> PT [label="Page 0 →"];
  P1 -> PT [label="Page 1 →"];
  P2 -> PT [label="Page 2 →"];
  PT -> F5;
  PT -> F2;
  PT -> F7;
}
```

## Key Properties

- Eliminates external fragmentation (pages can be anywhere)
- Fixed-size pages simplify allocation
- Page table overhead per process
- Internal fragmentation within pages (last page may not be full)

## Connections

- **Built from:** [[virtual-memory|Virtual Memory]], [[page-table|Page Table]]
- **Builds into:** [[page-fault|Page Fault]], [[demand-paging|Demand Paging]]
- **Related:** [[segmentation|Segmentation]], [[tlb|TLB]]
- **Contrasts with:** [[segmentation|Segmentation]] (fixed vs variable size)

## Edge Cases & Gotchas

- Internal fragmentation: last page partially filled wastes space
- Page table size grows with process size (use multi-level page tables)
- Every memory access needs page table lookup (slow → use TLB)

## Sources

- [[io-summary|I/O System Source Summary]]
