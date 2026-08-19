---
title: "Demand Paging in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Demand Paging in Operating System
Demand [[Private/Daily/computer-science/operating-systems/paging]] is a technique used in virtual memory systems where pages enter main memory only when requested or needed by the CPU. OS loads only the necessary pages of a program into memory at runtime, instead of loading the entire program into memory at the start. Here,

- A page fault occurred when the program needed to access a page that is not currently in memory.
- The operating system then loads the required pages from the disk into memory and updates the page tables accordingly.
- This process is transparent to the running program and it continues to run as if the page had always been in memory.

## Pure Demand Paging

Pure demand [[Private/Daily/computer-science/operating-systems/paging]] is a specific implementation of demand [[Private/Daily/computer-science/operating-systems/paging]]. In on-demand [[Private/Daily/computer-science/operating-systems/paging]] only, no pages are initially loaded into memory when the program starts and all pages are initially marked as being on disk.

- Operating systems that use pure demand [[Private/Daily/computer-science/operating-systems/paging]] as a memory management strategy do so without preloading any pages into physical memory prior to the commencement of a task.
- Demand [[Private/Daily/computer-science/operating-systems/paging]] loads a process's whole address space into memory one step at a time, bringing just the parts of the process that are actively being used into memory from disc as needed.
- It is useful for executing huge programs that might not fit totally in memory or for computers with limited physical memory.
- If the program accesses a lot of pages that are not in memory right now, it could also result in a rise in page faults and possible performance overhead.
- Operating systems frequently use caching techniques and improve page replacement algorithms to lessen the negative effects of page faults on system performance as a whole.

## Working Process of Demand Paging

Let us understand this with the help of an example. Suppose we want to run a process P which have four pages P0, P1, P2 and P3. Currently, in the page table, we have pages P1 and P3.

![Demand Paging](images_demand-paging.webp)

The operating system's demand [[Private/Daily/computer-science/operating-systems/paging]] mechanism follows a few steps in its operation:

- Program Execution: Upon launching a program, the operating system allocates a certain amount of memory to the program and establishes a process for it.
- Creating Page Tables: To keep track of which program pages are currently in memory and which are on disk, the operating system makes page tables for each process.
- Handling Page Fault: When a program tries to access a page that isn't in memory at the moment, a page fault happens. In order to determine whether the necessary page is on disk, the operating system pauses the application and consults the page tables.
- Page Fetch: The operating system loads the necessary page into memory by retrieving it from the disk if it is there.
- The page's new location in memory is then reflected in the page table.
- Resuming The Program: The operating system picks up where it left off when the necessary pages are loaded into memory.
- Page Replacement: If there is not enough free memory to hold all the pages a program needs, the operating system may need to replace one or more pages currently in memory with pages currently in memory. on the disk. The page replacement algorithm used by the operating system determines which pages are selected for replacement.
- Page Cleanup: When a process terminates, the operating system frees the memory allocated to the process and cleans up the corresponding entries in the page tables.

## How Demand Paging in OS Affects System Performance?

Demand [[Private/Daily/computer-science/operating-systems/paging]] can improve system performance by reducing the memory needed for programs and allowing multiple programs to run simultaneously.

- If not implemented properly, it can cause performance issues.
- When a program needs a part that isn’t in the main memory, the operating system must fetch it from the hard disk, which takes time and pauses the program.
- This can cause delays and if the system runs out of memory, it will need to frequently swap pages in and out, increasing delays and reducing performance.

## Common Algorithms Used for Demand Paging

If a program needs a page that isn’t currently in memory, the system fetches it from the hard disk. Several algorithms manage this process:

- FIFO (First-In-First-Out): Replaces the oldest page in memory with a new one. It’s simple but can cause issues if pages are frequently swapped in and out, leading to [[Private/Daily/computer-science/operating-systems/thrashing]].
- LRU (Least Recently Used): Replaces the page that hasn’t been used for the longest time. It reduces [[Private/Daily/computer-science/operating-systems/thrashing]] more effectively than FIFO but is more complex to implement.
- LFU (Least Frequently Used): Replaces the page used the least number of times. It helps reduce [[Private/Daily/computer-science/operating-systems/thrashing]] but requires extra tracking of how often each page is used.
- MRU (Most Recently Used): Replaces the page that was most recently used. It’s simpler than LRU but not as effective in reducing [[Private/Daily/computer-science/operating-systems/thrashing]].
- Random: Randomly selects a page to replace. It’s easy to implement but unpredictable in performance.

## Demand Paging in OS vs Pre-Paging

### Demand paging

- It loads pages from disk into main memory only when they are needed by a program.
- This approach saves memory space by keeping only the required pages in memory, reducing memory allocation costs and improving memory use.
- However, the initial access time for pages not in memory can delay program execution.

### Pre-paging

- It loads multiple pages into main memory before they are needed by a program.
- It assumes that if one page is needed, nearby pages will also be needed soon.
- Pre-[[Private/Daily/computer-science/operating-systems/paging]] can speed up program execution by reducing delays caused by demand [[Private/Daily/computer-science/operating-systems/paging]] but can lead to unnecessary memory allocation and waste.