---
title: "Internal Fragmentation in OS"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Internal Fragmentation in OS
Internal Fragmentation is the wastage of memory that occurs when fixed-sized memory blocks are allocated to processes, but the process does not use the entire allocated block. The unused portion inside the allocated block remains idle, resulting in poor memory utilization.

![Internal Fragmentation](images_internal-fragmentation.jpg)

## How Internal Fragmentation is Caused?

- Fixed Block Allocation: When processes request memory, they are often assigned blocks larger than required. The unused space within the block is wasted.
- Uniform Block Sizes: If all processes get the same memory size, smaller processes leave large unused portions.
- Management Overheads: Some systems reserve extra memory for bookkeeping, which also adds to internal fragmentation.

Example:

Let's assume that the system that is being used assigns the memory in blocks of sizes being multiples of 4(like 12, 24, 32,..). In this system when a process P1 requests an amount of memory that is not a multiple of 4, it is assigned a memory block of value of the nearest higher multiple.

![frame_3092](images_frame_3092.webp)

- A process requests 29 KB.
- It will be assigned 32 KB (nearest multiple of 4).
- The extra 3 KB remains unused.

This 3 KB loss is internal fragmentation.

## Effect of Internal Fragmentation

Due to Internal Fragmentation various types of effects occurs:

- Inefficient Memory Utilization: Wasted space reduces overall usable memory.
- Performance Degradation: More I/O operations due to scattered partially filled blocks.
- Virtual Memory Issues: Partially filled pages can increase page faults.

## Why Internal Fragmentation is Allowed?

As Internal Fragmentation is nothing but a problem there isn't any significant advantage that it provides to the system. But there are a couple of things that favor causing it, which are:

- As the allocation always occurs in a fixed size only the allocation becomes fast and simple.
- When the overhead calculation for the system is done it outputs to be pretty predictable which in return gives a predictable performance. The overhead calculation is accurate as the overhead caused by the Internal Fragmentation is already well known.

## Ways to Avoid Internal Fragmentation

There are several ways to avoid Internal fragmentation. Some of them are mentioned below.

- Variable-Sized Blocks: Create memory blocks of different sizes and allocate the best-fit block for each process, reducing unused space.
- Dynamic Memory Allocation: Assign only the exact memory required by a process, so little to no memory is wasted.