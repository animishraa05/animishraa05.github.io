---
concept: Demand Paging
aliases: [On-Demand Paging, Lazy Loading Pages]
tags: [systems, memory]
sources_count: 1
last_source: io.md
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

Loading an entire process into RAM at startup is wasteful — many pages may never be used. We need a way to load pages only when they're actually needed.

## Core Idea

Demand paging loads pages from disk only when they are first accessed (on-demand), reducing RAM usage and startup time.

## How It Works

1. Process starts, page table marked with all pages "not present"
2. Process runs, accesses first page → page fault
3. OS loads that page from disk into RAM
4. Subsequent accesses hit RAM (no fault)
5. If RAM is full, evicts a page (LRU, FIFO, etc.)

```dot
digraph demand {
  rankdir=LR;
  node [shape=box, style=filled];
  
  Proc [label="Process\nneeds page X", fillcolor=lightyellow];
  Fault [label="Page Fault\npage not in RAM", fillcolor=salmon];
  Load [label="OS loads\npage X from disk", fillcolor=lightblue];
  RAM [label="RAM\npage X now present", fillcolor=lightgreen];
  
  Proc -> Fault [label="access"];
  Fault -> Load [label="trap to OS"];
  Load -> RAM;
}
```

## Key Properties

- Lazy loading: pages loaded only when needed
- Reduces initial RAM usage
- First access is slow (disk read), subsequent fast
- Basis for virtual memory systems

## Connections

- **Built from:** [[wiki/io/paging|Paging]], [[page-fault|Page Fault]]
- **Builds into:** [[virtual-memory|Virtual Memory]], [[wiki/io/thrashing|Thrashing]]
- **Related:** [[swap-space|Swap Space]], [[page-replacement|Page Replacement]]
- **Contrasts with:** [[prepaging|Prepaging]] (load pages before needed)

## Edge Cases & Gotchas

- Too many page faults = thrashing
- Page fault handling overhead (~1ms for disk read)
- Critical processes may need pages locked in RAM (mlock)

## Sources

- [[io-summary|I/O System Source Summary]]
