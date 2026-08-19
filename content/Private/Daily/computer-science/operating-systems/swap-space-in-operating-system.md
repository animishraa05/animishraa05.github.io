---
title: "Swap Space in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Swap Space in Operating System
Modern operating systems use both physical memory (RAM) and virtual memory to manage processes efficiently. Swap space (also called [[Private/Daily/computer-science/operating-systems/paging]] space or swap file) plays a key role in this memory management strategy. It is a dedicated area on the hard disk used by the operating system as an extension of physical RAM

![lazy-swapping](images_lazy-swapping.jpg)

> Note: Swap space enables the OS to handle memory more flexibly, supporting the illusion of a larger memory than physically available, thus improving multitasking and stability of the system.

Note: Swap space enables the OS to handle memory more flexibly, supporting the illusion of a larger memory than physically available, thus improving multitasking and stability of the system.

## Working of Swap Space

1. When physical memory (RAM) is full, the OS selects some memory pages that are inactive or least recently used (using algorithms like LRU – Least Recently Used).
2. These pages are written from RAM to the swap space on the disk.
3. When those pages are needed again, they are read back from the swap space into RAM.
4. This process of moving pages between RAM and disk is called swapping or [[Private/Daily/computer-science/operating-systems/paging]].

> Note: Despite its usefulness, accessing swap space is much slower than RAM due to disk I/O delays.

Note: Despite its usefulness, accessing swap space is much slower than RAM due to disk I/O delays.

## Optimal Swap Space Size

A general rule of thumb recommends swap space size to be about 1.5 times the size of physical RAM. However, the exact swap size depends on the system's use case:

- Systems with high RAM and low memory usage may need less swap.
- Memory-intensive applications or environments with many background processes may require more swap.

> Note: Modern systems with large amounts of RAM often use much smaller swap sizes, just to handle exceptional cases.

Note: Modern systems with large amounts of RAM often use much smaller swap sizes, just to handle exceptional cases.

## Swap Space vs Virtual Memory

| Feature | Swap Space | Virtual Memory |
| --- | --- | --- |
| Definition | Physical disk space used for swapping memory pages | Abstract combination of physical RAM and swap space |
| Role | Storage area for inactive pages | Provides an abstraction of larger memory to applications |
| Performance | Slow access (due to disk I/O) | Appears seamless to applications |
| Implementation | Typically a swap partition or swap file | Managed by OS using page tables |

## Configuring Swap Space

Linux:

- Default swap is set during OS installation.
- Can be adjusted using tools like mkswap, swapon and swapoff.

Example commands:

> sudo mkswap /swapfilesudo swapon /swapfile

sudo mkswap /swapfilesudo swapon /swapfile

Windows: Page file settings can be managed through System Properties -> Advanced System Settings -> Performance Settings -> Virtual Memory.

## When Should Swap Space Be Disabled?

- High-performance systems with very large RAM (e.g., 128 GB+) and no memory-intensive applications may disable swap space.
- However, disabling swap increases the risk of running out of memory, which can result in the kernel killing processes arbitrarily.

> Note: In general-purpose systems, swap space should be present for safety.

Note: In general-purpose systems, swap space should be present for safety.

## Advantages :

- Virtual Memory Extension: Allows processes to operate as if there is more memory available than the system physically has.
- Increased System Stability: Prevents system crashes when RAM is exhausted by providing additional space.
- Efficient Multitasking: Frees up physical memory for more active processes and critical operations.
- Supports Memory-Intensive Applications: Enables running large applications that require more memory than physically available.

## Disdvantages :

- Performance Degradation: Reading from and writing to swap space is orders of magnitude slower than accessing RAM.
- Disk Space Consumption: Swap space occupies significant hard disk space, which may reduce space available for files and applications.
- [[Private/Daily/computer-science/operating-systems/thrashing|Thrashing]]: Excessive swapping (when the system spends most of its time swapping pages rather than executing useful tasks) severely hampers performance.
- Data Loss Risk: If a power failure occurs while a page is in swap space and not yet committed back to disk, data may be lost.