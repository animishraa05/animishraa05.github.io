---
title: "Paging vs Segmentation — Memory Management Compared"
type: synthesis
tags: [systems, memory]
created: 2026-04-30
updated: 2026-04-30
---

## Framing

Compare two memory management schemes: **paging** (fixed-size chunks) vs **segmentation** (variable-size logical units). Both enable virtual memory but with different trade-offs.

## Comparison

| Feature | Paging | Segmentation |
| --- | --- | --- |
| **Size** | Fixed (e.g., 4KB pages) | Variable (code, data, stack) |
| **Fragmentation** | Internal (last page wasted) | External (gaps between segments) |
| **Addressing** | Page number + offset | Segment number + offset |
| **Table** | Page table (one per process) | Segment table (base + limit) |
| **Sharing** | Harder (page-granularity) | Easier (share entire segment) |
| **Protection** | Per-page bits | Per-segment (code=read/exec, data=rw) |
| **Growth** | Automatic (new pages) | Explicit (segment grow/shrink) |

## Key Insights

1. **Paging eliminates external fragmentation** but wastes space inside pages (internal fragmentation)
2. **Segmentation matches program structure** (code, data, stack are natural segments) but causes external fragmentation
3. **Paging is transparent** to the programmer; segmentation is visible (segment registers)
4. **Modern OSs combine both**: outer segmentation (for protection) with inner paging (for no external fragmentation) — this is called **paged segmentation**
5. **x86 architecture** uses paged segmentation: segment selector → linear address → page table → physical

## Synthesis

No single scheme wins — paging solves fragmentation but loses program semantics; segmentation preserves semantics but fragments memory. The best systems (like modern x86) use **both**: segmentation for protection and logical structure, paging for efficient physical memory use.

## Connections

- [[wiki/io/paging|Paging]] — fixed-size memory management
- [[segmentation|Segmentation]] — variable-size logical units
- [[page-table|Page Table]] — used in paging
- [[segment-table|Segment Table]] — used in segmentation
- [[virtual-memory|Virtual Memory]] — both enable virtual memory
- [[internal-fragmentation|Internal Fragmentation]] — paging's weakness
- [[external-fragmentation|External Fragmentation]] — segmentation's weakness