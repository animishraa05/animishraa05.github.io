---
title: "External Fragmentation in OS"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# External Fragmentation in OS
External fragmentation is a problem in memory management where free memory is divided into small, non-contiguous blocks. Even though there may be enough total free memory to run a new program, the memory is scattered in tiny pieces, so it's impossible to find a single, large block for the program to use. This leads to wasted memory and poor system performance.

## Why Does It Happen?

External fragmentation is caused by the dynamic allocation and deallocation of processes. Imagine memory as a long parking lot.

1. A few cars (processes) park in different spots.
2. Then, some of these cars leave, creating empty spaces (free memory).
3. These empty spaces are of different sizes and are scattered throughout the lot.
4. If a new, large truck (a new process) arrives, it can't find a single, continuous space big enough to park, even though the total empty space in the lot is more than enough.

This is exactly how external fragmentation works. The "holes" in the memory are too small and separated to be useful for larger processes.

![419337643](images/419337643.webp)

## How to Avoid External Fragmentation?

To avoid external fragmentation in an operating system:

- [[paging|Paging]]/Segmentation: [[paging|Paging]] allocates memory in fixed-size pages, avoiding external fragmentation. Segmentation uses variable-sized blocks but may still leave some gaps.
- Compaction: Rearranges processes in memory to merge free spaces into larger contiguous blocks.
- Best-Fit Allocation: Assigns the smallest available block that fits a process, reducing wasted space (though not eliminating fragmentation completely).

## Illustrative Example of External Fragmentation

Lets consider a memory space having 4 processes, each of them requires different amount of memory to execute, as shown in Figure 1.

![Figure 1](images/figure-1.png)

Now suppose Process 1 and Process 3 have been completed, so now there are free places available, as shown in Figure 2.

![Figure 2](images/figure-2.png)

Now, if we want to run another process (Process 5) requiring memory 50 KB, we will not be able to do it, although there is enough memory to run Process 5 as the memory is not contiguous, as shown in Figure 3.

![Figure 3](images/figure-3.png)

That's how external fragmentation occurs.

## Causes of External Fragmentation

The primary causes of external fragmentation include:

- Variable Process Sizes: Different processes need different amounts of memory, leaving uneven gaps when loaded/unloaded.
- Allocation & Deallocation: When processes finish, freed blocks may not be adjacent, creating scattered holes.
- Non-Uniform Release: Memory released at irregular points leads to gaps of unpredictable sizes.
- Allocation Strategies: Best-fit and worst-fit may worsen fragmentation by leaving behind many small unusable holes.
- Fixed Partitioning: Fixed-sized partitions cause mismatches between process size and partition size, leading to internal and external fragmentation.
- High Process Turnover: Frequent loading and removal of processes leaves memory fragmented over time.

## Solution of External Fragmentation

Below mentioned are the solutions of External Fragmentation that are mentioned below.

### 1. Memory Compaction

Memory compaction includes rearranging the items in memory to unite free memory hinders and make bigger contiguous memory regions. This is the closely guarded secret:

- Process Relocation: Moves processes closer together to eliminate or reduce gaps, creating larger contiguous free memory blocks.
- Benefits: Directly reduces external fragmentation, increasing the chance of allocating memory without gaps.
- Challenges: Can be resource-intensive, may disrupt running processes, and frequent compaction can impact system performance.

### 2. Paging

[[paging|Paging]] is a memory management technique that divides physical memory into fixed-size blocks called pages. It helps overcome external fragmentation and simplifies memory allocation.

- Page Size: Memory is divided into equal-sized pages, preventing small unusable gaps.
- Virtual Memory: Allows processes to use non-contiguous physical memory while seeing it as a single contiguous space.
- Page Table: The OS maintains a page table that maps virtual addresses to physical addresses.
- Page Replacement: When memory is full, pages can be swapped between main memory and disk to free space.

## Advantages of External Fragmentation

- Flexibility: Variable-sized allocation lets processes request memory as needed, not limited to fixed blocks.
- Efficient Utilization: Small gaps may appear, but overall memory use can still be better than fixed-sized allocation.
- Simplicity: Strategies like first-fit or best-fit are easy and fast to implement, reducing overhead.
- Dynamic Growth: Supports applications that expand memory usage over time by allocating differently sized blocks.

## Disadvantages of External Fragmentation

- Memory Consumption: Small, unusable intervals of memory accumulate, making it difficult to allocate large chunks of memory even if there is sufficient free space
- Reduced Performance: Over time, fragmentation can slow down memory allocation processes, as the system must search for enough free space.
- Need for Constant Wear: To prevent cracking, the system control may need to rotate (compress) repeatedly, which can take time to wear down
- Limits Program Growth : As memory fragmentation occurs, it can prevent the memory usage of programs from expanding, causing inefficiency or corruption