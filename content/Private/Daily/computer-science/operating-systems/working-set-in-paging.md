---
title: "Working Set in Paging"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Working Set in Paging
The working set model is a memory management technique used to prevent [[Private/Daily/computer-science/operating-systems/thrashing]]. It's based on the locality model of execution, which observes that a process tends to repeatedly use a small subset of its pages over a short period. This subset of pages is called the working set.

## Working Set Model

The working set model aims to keep a process's working set entirely in main memory. It does this by:

1. Defining the Working Set: The model uses a working set window (Δ), which is a time-based parameter (e.g., the last 1000 memory accesses). The working set for a process is the set of all unique pages referenced within this window. The size of this set is called the working set size (WSS).
2. Dynamic Frame Allocation: The operating system allocates a number of frames to a process equal to its working set size. This ensures that all the pages a process is actively using are in main memory, minimizing page faults and preventing [[Private/Daily/computer-science/operating-systems/thrashing]].
3. Adapting to Change: As a process's locality of reference changes over time, its working set size also changes. The operating system dynamically adjusts the number of frames allocated to the process, giving more frames when its working set grows and reclaiming frames when it shrinks.
4. Handling Memory Shortage: If the total frames required by all active processes (the sum of all their working set sizes) exceed the total available frames in main memory, the operating system may suspend one or more processes to free up frames for others, thus preventing the entire system from [[Private/Daily/computer-science/operating-systems/thrashing]].

Example:

![Example of a working set model sampling at 3 time instances with delta = 7](images_example-of-a-working-set-model-sampling-at-3-time-.png)

Window Size (Δ = 7): At each point in time, the working set is calculated from the last 7 page references.

1. At t₀:

- Recent references: 4,7,3,7,4,7,7
- Unique pages = {3,4,7}, WSS = 3
- Frames allocated = 3

2. At t₁:

- Recent references: 1,3,2,4,5,3,2
- Unique pages = {1,2,3,4,5}, WSS = 5
- Frames allocated = 5

3. At t₂:

- Recent references: 8,9,8,8,9,9,9
- Unique pages = {8,9}, WSS = 2
- Frames allocated = 2