---
title: "Instruction Pipelining"
topic: "computer-organization-architecture"
tags: [pipelining, instruction-pipeline, gate-cse, coa]
scraped_date: 2026-03-29
---

# Instruction Pipelining

Instruction pipelining overlaps execution of multiple instructions to improve throughput.

## 5-Stage RISC Pipeline

1. **IF (Instruction Fetch)** - Fetch from memory, increment PC
2. **ID (Instruction Decode)** - Decode, read registers, generate control
3. **EX (Execute)** - ALU operation, calculate address
4. **MEM (Memory Access)** - Read/write data memory
5. **WB (Write Back)** - Write result to register

## Pipeline Timing

**Non-Pipelined (n instructions):**
```
Total cycles = 5n
```

**Pipelined (n instructions):**
```
Total cycles = 5 + (n-1) = n + 4
```

## Speedup Formula

```
Speedup = Time_without_pipeline / Time_with_pipeline

For large n: Speedup ≈ k (number of stages)
```

## Pipeline Hazards

### 1. Structural Hazards
- Hardware resource conflict
- Solution: Duplicate resources or stall

### 2. Data Hazards

**RAW (Read After Write) - True Dependency**
```
I1: ADD R1, R2, R3    ; R1 = R2 + R3
I2: SUB R4, R1, R5    ; Needs R1 from I1
```

**WAR (Write After Read) - Anti Dependency**
```
I1: ADD R1, R2, R3    ; Reads R2
I2: SUB R2, R4, R5    ; Writes R2
```

**WAW (Write After Write) - Output Dependency**
```
I1: ADD R1, R2, R3    ; Writes R1
I2: SUB R1, R4, R5    ; Writes R1
```

**Solutions:**
- Forwarding/Bypassing
- Stalling (insert bubbles)
- Register Renaming

### 3. Control Hazards (Branch Hazards)

**Solutions:**
- Branch Prediction (Static/Dynamic)
- Delayed Branch
- Branch Target Buffer (BTB)

## Average CPI

```
Actual CPI = Ideal CPI + Stall_cycles_per_instruction

Actual CPI = 1 + (Stall_frequency × Stall_penalty)
```

## Pipeline Efficiency

```
Efficiency = Speedup / Number_of_stages

For large n: Efficiency ≈ 1 (100%)
```
