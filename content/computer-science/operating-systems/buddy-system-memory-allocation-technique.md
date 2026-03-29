---
title: "Buddy System - Memory Allocation Technique"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Buddy System - Memory Allocation Technique
The Buddy Allocation System is a memory management technique that divides a large memory block into smaller power-of-two blocks called buddies.

- If a request comes in, the block is repeatedly split until a suitable size is reached.
- When memory is freed, its buddy is checked — if also free, they merge back to form a larger block.
- This makes memory reuse fast and reduces fragmentation.

## Algorithm of Buddy System

Below are the steps involved in the Buddy System Memory Allocation Technique:

- Divide memory into blocks of size power-of-two (2, 4, 8, 16, 32, 64, …).
- Label each block with its size and ID.
- Initially, all blocks are free and maintained in a tree-like structure.
- On a request, find the smallest block that fits. If too large, split until the required size is reached.
- Allocate one block, keep the other free.
- On deallocation, check if the buddy is free → merge to form a larger block.

### Illustration

Problem: A system with 128 KB memory receives a request of 18 KB.

Solution: Nearest power of 2 ≥ 18 KB = 32 KB.We can see that if we further divide 32 in half it will be 16, which is less than 18 i.e. insufficient to store 18, therefore we can't split the memory further and 32 will become our leaf node.

![](images/capture-34.png)

## Features of Buddy System

- Scalability: Handles large memory efficiently by splitting into smaller blocks and adjusting dynamically.
- Efficient Splitting & Merging: Blocks split into equal buddies when allocated; merged back when both are free.
- Reduced Fragmentation: Merges adjacent free blocks, minimizing wasted gaps.
- Fast Allocation: Quick allocation/deallocation with low overhead.
- Power-of-Two Blocks: Memory divided into 1KB, 2KB, 4KB… simplifies splitting and merging.

### Buddy System Advantages & Drawbacks

Efficient memory use, reduced fragmentation, and fast allocation/deallocation. Drawback: internal fragmentation (allocated block may be larger than needed). Useful for OS, especially in embedded systems with limited memory.

### Example of Buddy System Allocation

Let total memory = 2^U and a request of size S. It will be handled as:

- \text{If } 2^{U-1} < S \leq 2^U \quad \Rightarrow \quad \text{Allocate block of size } 2^U
- Else, recursively divide the block into two equal buddies until the smallest suitable block is found.

The system also keeps a record of all the unallocated blocks and can merge these different-sized blocks to make one big chunk.

> Additional rules:Request Handling: Requests are served first-come, first-served.Splitting Rule: Always allocate the left buddy (lower address) first.Merging Rule: Freed blocks merge with their buddy if possible.

Additional rules:

- Request Handling: Requests are served first-come, first-served.
- Splitting Rule: Always allocate the left buddy (lower address) first.
- Merging Rule: Freed blocks merge with their buddy if possible.

The following figure illustrates the implementation of buddy system, considering a 1024k (1-megabyte) initial block and the process requests as shown at the left of the table.

![buddy_system](images/buddy_system.webp)

Explanation of the Table:

1. Start: One free block of 1024 KB.
2. A = 70 KB: Split → allocate 128 KB block for A.
3. B = 35 KB: Split → allocate 64 KB block for B.
4. C = 80 KB: Split → allocate 128 KB block for C.
5. A ends: Block of 128 KB freed.
6. D = 60 KB: Allocated in a free 64 KB block.
7. B ends: 64 KB freed → can merge with buddy.
8. D ends: Freed → merge with buddy, coalescing larger blocks.
9. C ends: Freed → memory fully restored to 1024 KB.

## Types of Buddy System

The Buddy System is a memory allocation method where blocks are split and merged for efficient use. Different types of Buddy Systems exist to suit specific needs and optimizations in various systems.

- Binary buddy system
- Fibonacci buddy system
- Weighted buddy system
- Tertiary buddy system

### 1. Binary buddy system

- Memory is split into blocks of size power of two.
- On request, the nearest larger block is chosen and split repeatedly into equal halves (buddies) until the required size is reached.
- Freed buddies can merge back to form larger blocks (coalescing).

Example: If total memory = 256KB and request = 25KB nearest power of two is 32KB.

- 256KB split into 128KB + 128KB
- 128KB split into 64KB + 64KB
- 64KB split into 32KB + 32KB
- One 32KB block is allocated (25KB fits inside).

### 2. Fibonacci buddy system

- A variation of the buddy system where memory blocks are divided into sizes based on Fibonacci numbers instead of powers of two.
- Block sizes follow the relation:

> Zi = Z(i-1)+Z(i-2)

Zi = Z(i-1)+Z(i-2)

- Example sequence: 1, 2, 3, 5, 8, 13, 21, 34 …
- On a memory request, the system finds the smallest Fibonacci block that can satisfy it.
- Like binary buddies, free blocks can be merged (coalesced) into larger Fibonacci-sized blocks.

### 3. Weighted Buddy System

In a weighted peer system, each memory block is associated with a weight, which represents its size relative to other blocks. When a memory allocation request occurs, the system searches for the appropriate block considering the size of the requested memory and the weight of the available blocks.

### 4. Tertiary Buddy System

In a traditional buddy system, memory is divided into blocks of fixed size, usually a power of 2, and allocated to these blocks but the tertiary buddy system introduces a third memory structure, which allows flexibility large in memory allocation.

## Advantages

- Efficient use of memory.
- Fast allocation and deallocation.
- Coalescing reduces fragmentation.

## Drawbacks

- Internal fragmentation (block may be bigger than request).
- Limited flexibility due to power-of-two constraint.