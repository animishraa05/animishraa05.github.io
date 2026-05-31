---
concept: Page Fault
aliases: [Page Fault Exception, Minor/Major Page Fault]
tags: [systems, memory]
sources_count: 1
last_source: io.md
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

In paged virtual memory, a process may reference a page that isn't currently in RAM. The CPU needs to know this page isn't present so the OS can fetch it from disk.

## Core Idea

A page fault occurs when a program accesses a page not loaded in RAM, triggering the OS to fetch the page from disk (swap space) into a free frame.

## How It Works

1. CPU accesses a virtual address
2. MMU looks up page table, finds page not present (valid bit = 0)
3. CPU raises a page fault exception
4. OS checks if access is legal, finds free frame
5. OS schedules disk read to load page from swap
6. Page loaded, update page table, restart instruction

```dot
digraph pagefault {
  rankdir=TB;
  node [shape=box, style=filled];
  
  CPU [label="CPU\naccesses page", fillcolor=lightyellow];
  MMU [label="MMU\npage not present", fillcolor=orange];
  OS [label="OS\nload from swap", fillcolor=lightblue];
  Disk [label="Swap Space\n(page stored here)", fillcolor=lightgray];
  RAM [label="RAM\nfree frame", fillcolor=lightgreen];
  
  CPU -> MMU;
  MMU -> OS [label="page fault exception", style=dashed, color=red];
  OS -> Disk [label="read page"];
  Disk -> RAM [label="DMA transfer"];
  RAM -> MMU [label="update page table", style=dashed];
}
```

## Key Properties

- Minor page fault: page is in memory but not in process's page table
- Major page fault: page must be loaded from disk (slow!)
- Too many page faults = thrashing (system slow)
- Handled by OS, transparent to process

## Connections

- **Built from:** [[paging|Paging]], [[page-table|Page Table]]
- **Builds into:** [[demand-paging|Demand Paging]], [[thrashing|Thrashing]]
- **Related:** [[swap-space|Swap Space]], [[virtual-memory|Virtual Memory]]
- **Contrasts with:** [[segmentation|Segmentation]] (different memory model)

## Edge Cases & Gotchas

- Invalid access (segfault) raises SIGSEGV, not page fault
- Copy-on-write: page fault used to duplicate pages
- Page fault handling is expensive (disk I/O)

## Sources

- [[io-summary|I/O System Source Summary]]
