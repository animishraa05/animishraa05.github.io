---
title: "Belady's Anomaly in Page Replacement Algorithms"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Belady's Anomaly in Page Replacement Algorithms
Belady's Anomaly is a phenomenon in operating systems where increasing the number of page frames in memory leads to an increase in the number of page faults for certain page replacement algorithms. Normally, as more page frames are available, the operating system has more flexibility to keep the necessary pages in memory, which should reduce the number of page fault.

This phenomenon is commonly experienced in the following page replacement algorithms:

- First in first out (FIFO)
- Second chance algorithm
- Random page replacement algorithm

Generally, on increasing the number of frames to a process' virtual memory, its execution becomes faster as fewer page faults occur. Sometimes the reverse happens, i.e. more page faults occur when more frames are allocated to a process. This most unexpected result is termed Belady's Anomaly.

### Why Some Algorithms Avoid It

Certain algorithms like Optimal and LRU never suffer from Belady’s Anomaly because they are stack-based algorithms.

- Stack Property: Pages in memory with N frames will always be a subset of those with N+1 frames.
- Optimal Algorithm: Replaces the page not needed for the longest time in the future.
- LRU (Least Recently Used): Keeps the most recently used pages; if frames increase, these pages still remain in memory.
- Difference from FIFO: FIFO may evict a useful page simply because it was loaded earlier, while stack-based algorithms maintain consistency.

Example: Consider the following diagram to understand the behavior of a stack-based page replacement algorithm

![](images_stackbased.png)

The diagram illustrates that given the set of pages i.e. {0, 1, 2} in 3 frames of memory is not a subset of the pages in memory - {0, 1, 4, 5} with 4 frames and it is a violation in the property of stack-based algorithms. This situation can be frequently seen in FIFO algorithm.

## Belady's Anomaly in FIFO

In FIFO page replacement it is supposed that the number of page faults should be less when we increase the number of frames. But sometimes, when the number of page faults increases even after increasing the number of frames, "Belady's Anomaly" occurs.

Let us understand this condition using a graph:

![1graph](images_1graph.webp)

Let us understand Belady's Anomaly in FIFO using an example:

Assuming a system that has no pages loaded in the memory and uses the FIFO Page replacement algorithm. Consider the following reference string:

> 1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5

1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5

Case 1: If the system has 3 frames, the given reference string the using FIFO page replacement algorithm yields a total of 9 page faults. The diagram below illustrates the pattern of the page faults occurring in the example.

![Belady Anomaly - FIFO](images_belady-anomaly-fifo.png)

Case 2: If the system has 4 frames, the given reference string using the FIFO page replacement algorithm yields a total of 10 page faults. The diagram below illustrates the pattern of the page faults occurring in the example.

![Belady Anomaly - FIFO](images_belady-anomaly-fifo.png)

It can be seen from the above example that on increasing the number of frames while using the FIFO page replacement algorithm, the number of page faults increased from 9 to 10.

> Note - It is not necessary that every string reference pattern cause Belady anomaly in FIFO but there is certain kind of string references that worsen the FIFO performance on increasing the number of frames.

Note - It is not necessary that every string reference pattern cause Belady anomaly in FIFO but there is certain kind of string references that worsen the FIFO performance on increasing the number of frames.

## Why Stack Based Algorithms do not Suffer Anomaly?

- Independent of Frames: Stack-based algorithms assign replacement priority that doesn’t depend on the number of frames.
- Examples: Optimal, LRU, LFU: these always avoid Belady’s Anomaly.
- Simulation Benefit: The hit/miss ratio can be calculated for any number of frames in a single pass through the reference string.
- LRU Example: Each time a page is used, it moves to the top of the stack. The top n entries are the most recently used pages. If frames increase to n+1, the new set still includes the previous n pages, so no anomaly occurs.

> 1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5

1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5

Case 1: If the system has 3 frames, the given reference string using the LRU page replacement algorithm yields a total of 10 page faults. The diagram below illustrates the pattern of the page faults occurring in the example.

![Belady Anomaly - Case 1](images_belady-anomaly-case-1.png)

Case 2: If the system has 4 frames, the given reference string on using LRU page replacement algorithm, then total 8 page faults occur. The diagram shows the pattern of the page faults in the example.

![Belady Anomaly - Case 2](images_belady-anomaly-case-2.png)

> Program to show Belady’s Anomaly

Program to show Belady’s Anomaly