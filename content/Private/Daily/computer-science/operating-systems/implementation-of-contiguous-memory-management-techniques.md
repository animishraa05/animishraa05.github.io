---
title: "Implementation of Contiguous Memory Management Techniques"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Implementation of Contiguous Memory Management Techniques
Memory Management Techniques are basic techniques that are used in managing the memory in the operating system. They are classified broadly into two categories:

- Contiguous
- Non-contiguous

Contiguous memory allocation is a memory allocation strategy. As the name implies, we utilize this technique to assign contiguous blocks of memory to each task. Thus, whenever a process asks to access the main memory, we allocate a continuous segment from the empty region to the process based on its size. In this technique, memory is allotted in a contiguous way to the processes. Contiguous Memory Management has two types:

- Fixed (or Static) Partition
- Variable (or Dynamic) Partitioning

Let's understand these in detail.

![Memory-Management-Techniuqes](images_memory-management-techniuqes.webp)

## Fixed Partition Scheme

In the fixed partition scheme, memory is divided into fixed number of partitions. Fixed means number of partitions are fixed in the memory. In the fixed partition, in every partition only one process will be accommodated. Degree of multi-programming is restricted by number of partitions in the memory. Maximum size of the process is restricted by maximum size of the partition. Every partition is associated with the limit registers.

Limit Registers has two limits:

- Lower Limit which is the starting address of the partition.
- Upper Limit which is ending address of the partition.

![1](Daily/computer-science/operating-systems/images/1.webp)

### Advantages Fix partition scheme

- Easy for the operating system to manage because partitions are predefined.
- No need for complex calculations or dynamic resizing; reduces OS workload.
- Assigning a process to a free partition is quick and efficient.
- Since partitions are fixed, memory does not break into scattered free spaces.

### Disadvantages Fix partition scheme

- Maximum process size should always be less than equal to maximum partition size.
- The degree of multiprogramming is directly proportional to the number of partitions.
- If a process of 19kb wants to allocate and we have free space which is not continuous we are not able to allocate the space.
- Internal Fragmentation is found in fixed partition scheme. To overcome the problem of internal fragmentation, instead of fixed partition scheme, variable partition scheme is used.

## Variable Partition Scheme

A variable partition scheme is initially memory will be single continuous free block. Whenever the request by the process arrives, accordingly partition will be made in the memory. If the smaller processes keep on coming then the larger partitions will be made into smaller partitions.

- In variable partition schema initially, the memory will be full contiguous free block
- Memory divided into partitions according to the process size where process size will vary.
- One partition is allocated to each active partition.
- External Fragmentation is found in variable partition scheme.

### Advantages of Variable Partition Scheme

- Portion size = process size
- There is no internal fragmentation (which is the drawback of fixed partition schema).
- Degree of multiprogramming varies and is directly proportional to a number of processes.

### Disadvantage Variable Partition Scheme

- Free memory becomes scattered as processes are loaded and removed.
- To remove fragmentation, the OS must shift processes, which is time-consuming and slows the system.
- Keeping track of variable-sized partitions requires more bookkeeping.
- Deciding where to place processes of different sizes increases overhead.

![2](Daily/computer-science/operating-systems/images/2.webp)

### Solution of External Fragmentation

To overcome the problem of external fragmentation, following techniques are used :

1. Compaction

Moving all the processes toward the top or towards the bottom to make free available memory in a single continuous place is called compaction. Compaction is undesirable to implement because it interrupts all the running processes in the memory. It also consumes CPU time (overhead).

2. Non-contiguous memory allocation

1. Physical address space: Main memory (physical memory) is divided into blocks of the same size called frames. Frame size is fixed by the hardware (MMU) and is equal to page size
2. Logical Address space: Logical memory is divided into blocks of the same size called process pages. page size is defined by hardware system and these pages are stored in the main memory during the process in non-contiguous frames.