---
concept: DMA Controller
aliases: [DMAC, DMA Controller Hardware]
tags: [systems, io]
created: 2026-04-30
updated: 2026-04-30
---

# DMA Controller

## The Problem
The CPU should not waste cycles copying data between I/O devices and memory. But without a dedicated hardware controller, there's no way to transfer data directly — someone (the CPU) must handle each byte.

## Core Idea
The DMA Controller (DMAC) is a specialized hardware component that manages data transfers between I/O devices and memory without CPU intervention, using bus mastering to directly access memory.

## How It Works
1. CPU programs the DMAC with: source address, destination address, transfer count
2. DMAC takes control of the system bus (bus arbitration)
3. DMAC generates memory addresses and transfer signals
4. Data moves directly between device and memory via DMAC
5. DMAC decrements count for each transfer, increments addresses
6. When count reaches zero, DMAC raises an interrupt to notify CPU

```dot
digraph dmac {
  rankdir=TB;
  node [shape=box, style=filled];
  
  CPU [label="CPU", fillcolor=lightyellow];
  DMAC [label="DMA Controller\n(address, count,\ncontrol regs)", fillcolor=orange];
  Mem [label="Main Memory", fillcolor=lightblue];
  Device [label="I/O Device", fillcolor=lightgray];
  
  CPU -> DMAC [label="program\n(address, count)"];
  DMAC -> Mem [label="direct\naccess", color=red];
  DMAC -> Device [label="direct\ntransfer", color=red];
  DMAC -> CPU [label="interrupt\ndone", style=dashed, color=green];
}
```

## Key Properties
- Contains registers for source address, destination address, transfer count, control
- Can operate in different modes (burst, cycle stealing, transparent)
- Requires bus arbitration logic to coordinate with CPU for bus access
- Typically supports multiple channels for different devices

## Connections
- **Built from:** [[system-bus|System Bus]], [[device-controller|Device Controller]]
- **Builds into:** [[dma|DMA]] — DMAC is the hardware that implements DMA
- **Related:** [[io-devices|I/O Devices]], [[buffering|Buffering]]
- **Contrasts with:** [[cpu|CPU]] — DMAC handles transfers, CPU free to do other work

## Edge Cases & Gotchas
- Bus contention: CPU and DMAC both need bus access — arbitration required
- Cache coherency: CPU cache may not see DMAC-written data (need cache flush/invalidate)
- Wrong register programming (bad address/count) can corrupt memory
- Some systems have limited DMA channels — resource contention possible

## Sources
- [[computer-architecture-summary|Computer Architecture Source Summary]]
