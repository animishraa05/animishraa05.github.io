---
concept: Device Controller
aliases: [I/O Controller, Hardware Controller]
tags: [systems, io]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

The CPU cannot directly manipulate hardware signals (move disk arm, read magnetic flux). It needs a hardware intermediary that understands both the CPU's bus interface and the device's physical interface.

## Core Idea

A device controller is a hardware component that interfaces between the system bus and the physical I/O device, containing registers for commands, data, and status, plus local buffers for data transfer.

## How It Works

1. CPU (via driver) writes commands and parameters to controller's registers
2. Controller parses registers to determine operation (read/write/seek)
3. Controller executes operation on the physical device
4. Data transfers to/from controller's local buffer
5. Controller raises interrupt when operation completes
6. CPU reads status register to check success/failure

```dot
digraph controller {
  rankdir=LR;
  node [shape=box, style=filled];
  
  CPU [label="CPU", fillcolor=lightyellow];
  Bus [label="System Bus\n(Data/Addr/Ctrl)", fillcolor=lightblue];
  
  subgraph cluster_ctrl {
    label="Device Controller";
    fillcolor=orange;
    
    CtrlRegs [label="Control Registers\n(command, status)"];
    DataBuf [label="Data Buffer\n(local)"];
    Logic [label="Control Logic\n(state machine)"];
    
    CtrlRegs -> Logic;
    Logic -> DataBuf;
  }
  
  Device [label="I/O Device\n(e.g., Disk, NIC)", fillcolor=lightgray];
  
  CPU -> Bus [label="writes commands"];
  Bus -> CtrlRegs [label="register writes"];
  Logic -> Device [label="physical signals"];
  Device -> DataBuf [label="data", style=dashed];
  CtrlRegs -> Bus [label="interrupt", style=dashed];
}
```

## Key Properties

- Contains three types of registers: control, data, and status
- Has local buffer to hold data during transfer
- Can operate asynchronously from CPU (using DMA)
- Sits on the system bus, addressed like memory (memory-mapped I/O)

## Connections

- **Built from:** [[system-bus|System Bus]], [[io-system|I/O System]]
- **Builds into:** [[io-request-to-hardware|I/O Request to Hardware Operation]]
- **Related:** [[device-driver|Device Driver]], [[dma|DMA]], [[interrupt-handler|Interrupt Handler]]
- **Contrasts with:** [[device-driver|Device Driver]] (software vs hardware)

## Edge Cases & Gotchas

- Register addresses vary by device — driver must know the correct addresses
- Local buffer size limits transfer size per operation
- Status register must be read before another command is issued
- Some controllers have buggy implementations causing race conditions