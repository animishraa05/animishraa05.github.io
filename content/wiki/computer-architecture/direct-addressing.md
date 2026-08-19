---
concept: Direct Addressing
aliases: [Absolute Addressing, Memory Direct Addressing]
tags: [systems, cpu]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem
We need to access specific memory locations (variables, data structures). Embedding the memory address directly in the instruction allows the CPU to access that fixed location.

## Core Idea
Direct Addressing specifies the exact memory address of the operand within the instruction. The CPU reads/writes to that specific memory location.

## How It Works
1. Instruction includes the memory address (e.g., 1234h)
2. CPU fetches the instruction, extracts the address
3. CPU performs a memory read/write to that address
4. Example: `MOV AX, [1234h]` — loads data from memory address 1234h into AX
5. Requires one memory access (in addition to instruction fetch)

```dot
digraph direct_addr {
  rankdir=LR;
  node [shape=box, style=filled];
  
  Instr [label="Instruction\n(MOV AX, [1234h])\nOpcode | Address: 1234h", fillcolor=lightyellow];
  Mem [label="Memory\nAddr 1234h: data", fillcolor=lightblue];
  CPU [label="CPU\nAX ← data", fillcolor=orange];
  
  Instr -> Mem [label="read from\n1234h"];
  Mem -> CPU;
}
```

## Key Properties
- Simple and intuitive — address is fixed at compile time
- Limited address range: address size limited by instruction format
- Used for accessing global variables, fixed data structures
- Slower than register addressing (requires memory access)

## Connections
- **Built from:** [[addressing-mode|Addressing Mode]], [[memory-address|Memory Address]]
- **Contrasts with:** [[immediate-addressing|Immediate Addressing]] — value in instruction, not address
- **Contrasts with:** [[indirect-addressing|Indirect Addressing]] — address in register, not instruction
- **Related:** [[memory|Memory]], [[effective-address|Effective Address]]

## Edge Cases & Gotchas
- Address is fixed at compile time (can't change at runtime)
- Limited address range (e.g., 16-bit address = 64KB max)
- Position-independent code can't use direct addressing (addresses change)

## Sources
- [[computer-architecture-summary|Computer Architecture Source Summary]]
