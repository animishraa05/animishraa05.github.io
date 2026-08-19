---
title: "Non-Contiguous Allocation in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Non-Contiguous Allocation in Operating System
Non-contiguous allocation, also known as dynamic or linked allocation, is a technique used in operating systems to allocate memory to processes that do not require a contiguous block of memory. Here a process is divided into parts and stored in different free blocks of main memory, not necessarily consecutive:

- Process is split into smaller units (pages/segments).
- These parts are placed in available free blocks (frames) of memory.
- OS maintains mapping through page tables or segment tables

> Note: These non-contiguous blocks of memory can be located anywhere in the physical memory.

Note: These non-contiguous blocks of memory can be located anywhere in the physical memory.

## Fundamental Approaches of Implementing Non-Contiguous Memory Allocation

Non-contiguous allocation involves the use of pointers to link the non-contiguous memory blocks allocated to a process. These pointers are used to keep track of the memory blocks allocated to the process and to locate them during the execution of the process.

There are two fundamental approaches to implement non-contiguous memory allocation:

![Non-Contiguous-Allocation](images_non-contiguous-allocation.webp)

- [[Private/Daily/computer-science/operating-systems/paging|Paging]]: It breaks processes into equal-sized pages and maps them to memory frames, mainly to eliminate external fragmentation.
- Segmentation: It divides processes into variable-sized logical segments (like code, data, stack), supporting protection, sharing, and logical organization.
- Segmented [[Private/Daily/computer-science/operating-systems/paging|Paging]]: A hybrid technique that first divides processes into logical segments and then splits each segment into fixed-size pages, combining the benefits of segmentation and [[Private/Daily/computer-science/operating-systems/paging]].

It has the advantage of reducing memory wastage but it increases the overheads due to address translation, which results in slow execution.

> Note: [[Private/Daily/computer-science/operating-systems/paging|Paging]] avoids external fragmentation but may suffer from internal fragmentation.

Note: [[Private/Daily/computer-science/operating-systems/paging|Paging]] avoids external fragmentation but may suffer from internal fragmentation.

## How Does Non-Contiguous Memory Allocation Work?

A process is divided into parts that can be stored in different free spaces of main memory (not necessarily consecutive).

Example: If a process P = 4KB and memory has two free slots of 2KB each, contiguous allocation fails (no spanning allowed). In non-contiguous allocation, P is split into two 2KB parts, each fitting into the free slots. In contiguous allocation:

- Space in memory should be allocated to the whole process.
- If not, then that space remains unallocated.

In Non-Contiguous allocation:

- The process can be divided into different parts hence filling the space in the main memory.
- In this example, process P can be divided into two parts of equal size -> 2KB.
- Hence one part of process P can be allocated to the first 2KB space of main memory and the other part of the process can be allocated to the second 2KB space of main memory.

The below diagram will explain in a better way:

![paging2](images_paging2.webp)

In what manner we divide a process to allocate them into main memory? The process is divided after analyzing the number of empty spaces and their size in the main memory. But, it has some challenge:

> Dividing processes dynamically based on changing free space is time-consuming as their sizes changing every time due to execution of already present processes in main memory.

Dividing processes dynamically based on changing free space is time-consuming as their sizes changing every time due to execution of already present processes in main memory.

In order to avoid this time-consuming process, we divide our process in [[secondary-memory|secondary memory]] in advance before reaching the main memory for its execution. Every process is divided into various parts of equal size called Pages. We also divide our main memory into different parts of equal size called Frames. It is important to understand that:

Rule: pageSize = frameSize.

Example with [[Private/Daily/computer-science/operating-systems/paging|Paging]]: If frame size = 2KB, processes P1 and P2 (2 pages each) can be stored alternately across free frames in memory.

![Non_contiguous_allocation_3](images_non_contiguous_allocation_3.webp)

Resolvent main memory, In main memory the sequence of storage of pages are: First page of P1 -> First page of P2 -> Second page of P1 -> Second page of P2

![os_3](images_os_3.webp)

> Note: Non-contiguous allocation (via [[Private/Daily/computer-science/operating-systems/paging]]) divides processes into pages and memory into frames, ensuring flexible and efficient use of memory without requiring consecutive space.

Note: Non-contiguous allocation (via [[Private/Daily/computer-science/operating-systems/paging]]) divides processes into pages and memory into frames, ensuring flexible and efficient use of memory without requiring consecutive space.

## Pros of Non-Contiguous Allocation

- Reduced Internal Fragmentation : Memory blocks are allocated as per process needs; unused space inside blocks is minimized.
- Flexible Allocation : Processes can be loaded wherever free memory is available, without requiring a large continuous block.
- Better Memory Utilization : Small gaps in memory can be efficiently used to fit parts of different processes.
- Supports Dynamic Loading & Growth : Processes that expand (like stack/heap) can take memory from scattered free blocks.
- Multiprogramming Support : More processes can reside in memory simultaneously, as allocation is more flexible.
- Enables Virtual Memory : Forms the basis of schemes like [[Private/Daily/computer-science/operating-systems/paging]] and segmentation, allowing processes to use more memory than physically available.

## Cons of Non-Contiguous Allocation

- External Fragmentation : Free memory may be broken into many small scattered blocks, making it hard to allocate large memory requests.
- Overhead of Address Mapping : Requires complex data structures (page tables, segment tables or linked lists) to keep track of allocated blocks.
- Slower Access : Address translation and pointer chasing increase access time compared to contiguous allocation.
- Memory Management Overhead : Additional hardware (MMU : Memory Management Unit) and OS routines are needed for mapping logical to physical addresses.
- Complex Deallocation : Releasing and merging free memory blocks is more complicated, increasing OS overhead.
- Possibility of Page Faults (in [[Private/Daily/computer-science/operating-systems/paging|Paging]]-based systems) : Since data is scattered, a needed page may not be in memory, causing delays.