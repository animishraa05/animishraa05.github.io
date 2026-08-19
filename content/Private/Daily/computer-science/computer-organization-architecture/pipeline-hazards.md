---
title: "Pipeline Hazards"
topic: "computer-organization-architecture"
scraped_date: [[2026-03-29]]
---

# Pipeline Hazards
A [[PIPELINE|pipeline]] hazard is any condition that causes a [[PIPELINE|pipeline]] to stall or operate inefficiently, disrupting the smooth flow of instruction execution. Hazards reduce overall performance by introducing extra clock cycles, called 'stalls' or 'bubbles', into the [[PIPELINE|pipeline]].

Pipeline hazards are broadly classified into three types:

1. Structural Hazards
2. Data Hazards
3. Control Hazards

![pipeline_hazards](images_pipeline_hazards.webp)

## 1. Structural Hazards

A structural hazard, also called a resource conflict, occurs when two or more instructions require access to the same hardware resource simultaneously, and the hardware cannot support the required parallel access.

For example:

![memory](Daily/computer-science/computer-organization-architecture/images/memory.webp)

- In clock cycle 4, suppose instruction I1 is accessing memory to load data, and instruction I4 is trying to fetch its instruction from memory at the same time.
- Since both operations use the same memory module, they cannot proceed concurrently.
- As a result, one of them (say I4) is stalled until the resource becomes free, creating a bubble in the [[PIPELINE|pipeline]].

Common resources involved in conflicts:

- ALU or functional units
- Memory
- Registers
- Buses

Solution to Structural Hazards:To minimize such stalls, one common technique is Resource Duplication or Memory Split, where:

- Instruction Memory (Code Memory) stores program instructions.
- Data Memory stores program data.

This separation allows simultaneous access—one stage can fetch instructions while another accesses data—thus avoiding memory-related structural dependencies.

## 2. Data Hazards

A data hazard occurs when instructions exhibit data dependencies such that one instruction depends on the result of a previous instruction that has not yet completed in the [[PIPELINE|pipeline]].

Example:

> I1: I1: ADD R1, R2, R3 → R0 ← R1 + R2 orI2: MUL R3, R0, R4 → R3 ← R0 × R4

I1: I1: ADD R1, R2, R3 → R0 ← R1 + R2 or

I2: MUL R3, R0, R4 → R3 ← R0 × R4

Here, I2 depends on the result of I1 because I2 needs the updated value of R0 produced by I1.

Types of Data Dependencies:

- True Dependency (Read After Write - RAW): A later instruction needs a value that an earlier instruction writes.
- Anti-dependency (Write After Read - WAR): A later instruction writes to a location that an earlier instruction is reading.
- Output Dependency (Write After Write - WAW): Two instructions write to the same destination register or memory location.

Solutions for Data Hazards:

- Forwarding (Data Bypassing): Transfers results directly from one [[PIPELINE|pipeline]] stage to another before they are written to registers.
- [[PIPELINE|Pipeline]] Interlocks: Detection hardware automatically inserts stalls until data becomes available.
- Instruction Scheduling: Compiler rearranges instructions to reduce dependencies.

## 3. Control Hazards

A control hazard (also known as a branch hazard) arises when the flow of instruction execution is altered by branch or jump instructions. Since fetching the next instruction depends on the outcome of a branch, the [[PIPELINE|pipeline]] may fetch the wrong instructions before knowing the actual branch direction.

Example:

> BEQ R1, R2, LABEL ADD R3, R4, R5 SUB R6, R7, R8

BEQ R1, R2, LABEL

ADD R3, R4, R5

SUB R6, R7, R8

If the branch condition (BEQ) is true, the next instruction should be fetched from LABEL. However, by the time the branch is resolved, the [[PIPELINE|pipeline]] may already have fetched the next sequential instructions (ADD, SUB). These must be discarded, causing wasted cycles.

`BEQ`

`LABEL`

Causes of Control Hazards:

- Conditional branches (BEQ, BNE, etc.)
- Jump instructions
- Calls and returns

Solutions for Control Hazards:

- Branch Prediction: Hardware predicts the outcome of a branch to continue fetching before the condition resolves.
- Delayed Branching: The compiler reorders instructions so that useful work is done in the delay slot.
- Branch Target Buffers (BTB): Store the target addresses of previously executed branches.
- Speculative Execution: The processor executes instructions from the predicted path; results are committed only if the prediction is correct.