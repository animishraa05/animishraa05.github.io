---
title: "Introduction to Computer Organization and Architecture"
topic: "computer-organization-architecture"
tags: [coa, computer-organization, gate-cse]
scraped_date: 2026-03-29
---

# Introduction to Computer Organization and Architecture

## Computer Organization vs Architecture

| Computer Organization | Computer Architecture |
|----------------------|----------------------|
| Physical implementation | Logical design |
| Hardware details | Instruction set design |
| Memory technology, interfaces | Instruction formats, addressing modes |

## Five Functional Units

1. **Input Unit** - Keyboard, Mouse, Scanner
2. **Output Unit** - Monitor, Printer, Speaker
3. **Memory Unit** - RAM, ROM, Cache
4. **ALU** - Arithmetic and Logic operations
5. **Control Unit** - Coordinates all operations

## Information Flow

```
Input → Memory → ALU → Memory → Output
              ↑
              ↓
            Control Unit
```

## Von Neumann vs Harvard Architecture

**Von Neumann:**
- Single memory for data and instructions
- Sequential execution
- Bottleneck: Single bus

**Harvard:**
- Separate memories for data and instructions
- Parallel access
- Higher performance

## Performance Metrics

```
Execution Time = (Instruction Count × CPI) / Clock Rate

CPU Time = CPU Clock Cycles × Clock Cycle Time

MIPS = Instruction Count / (Execution Time × 10^6)
```

## Amdahl's Law

```
Speedup = 1 / [(1 - P) + (P / S)]
```

Where P = enhanced portion, S = speedup of enhanced portion

## Flynn's Classification

| Type | Description | Example |
|------|-------------|---------|
| SISD | Single Instruction, Single Data | Traditional PC |
| SIMD | Single Instruction, Multiple Data | GPU |
| MISD | Multiple Instruction, Single Data | Rare |
| MIMD | Multiple Instruction, Multiple Data | Multiprocessor |
