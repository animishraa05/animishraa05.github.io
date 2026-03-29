---
title: "Thread in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Thread in Operating System
A thread is a single sequence stream within a process and is called a lightweight process because it is smaller and faster. It allows multiple tasks to run simultaneously, improving program efficiency.

- In single-core systems, it creates an illusion of parallelism; in multi-core systems, threads can execute truly in parallel across different cores.
- Each thread has its own program counter, register set, and stack space.
- Threads share code, data, and operating system resources within the same process.

![multithreading-in-os](images/multithreading-in-os.png)

## Why Do We Need Threads

Threads are needed in modern operating systems and applications because they:

- Improve Performance: Threads allow multiple tasks to run at the same time (parallel or interleaved), making programs execute faster.
- Increase Responsiveness: If one thread is busy, another can handle user actions, keeping the application responsive.
- Enable Concurrency: Multiple operations like saving files, processing data, and handling user input can happen simultaneously.
- Better CPU Utilization: On multi-core systems, threads can run on different cores, improving overall system performance.
- Efficient Resource Sharing: Threads share the same memory and resources within a process, making communication faster and reducing overhead.

## Components of Threads

These are the basic components of the Operating System.

- Stack Space: Stores local variables, function calls, and return addresses specific to the thread.
- Register Set: Hold temporary data and intermediate results for the thread's execution.
- Program Counter: Tracks the current instruction being executed by the thread.

## Types of Threads

Threads are mainly classified based on how they are managed and scheduled in an operating system. There are two primary types of threads.

- User Level Thread
- Kernel Level Thread


## User-Level Threads (ULTs)

- Managed entirely in user space using a thread library; the kernel is unaware of them.
- Switching between ULTs is fast since only program counter, registers, and stack need to be saved/restored.
- Do not require system calls for creation or management, making them lightweight.
- If one thread makes a blocking [[system-call|system call]], the entire process (all threads) is blocked.
- Scheduling is done by the application itself, which may not be as efficient as kernel-level scheduling.
- Cannot fully utilize multiprocessor systems because the kernel schedules processes, not individual user-level threads.

## Kernel-Level Threads (KLTs)

- Managed directly by the operating system kernel; each thread has an entry in the kernel’s thread table.
- The kernel schedules each thread independently, allowing true parallel execution on multiple CPUs/cores.
- Handles blocking system calls efficiently; if one thread blocks, the kernel can run another thread from the same process.
- Provides better load balancing across processors since the kernel controls all threads.
- Context switching is slower compared to ULTs because it requires switching between user mode and kernel mode.
- Implementation is more complex and requires frequent interaction with the kernel.
- Large numbers of threads may add extra load on the kernel scheduler, potentially affecting performance.

## Threading Issues

- fork() and exec(): In multithreaded programs, fork() may duplicate all threads or just the calling thread, depending on the system. exec() replaces the entire process including all threads with the new program.
- Signal Handling: Signals notify a process of events. They can be synchronous or asynchronous and are handled by either the default kernel handler or a user-defined handler.
- Thread Cancellation: Threads can be terminated before completion. Cancellation can be asynchronous (immediate) or deferred (thread checks periodically). Example: stopping all threads loading a webpage.
- Thread-Local Storage (TLS): Threads share process data, but sometimes need private copies, such as unique identifiers for transactions.
- Scheduler Activations: The kernel provides virtual processors, allowing a user-thread library to schedule threads efficiently.

`fork()`

`exec()`

## Process vs Thread

The primary difference is that threads within the same process run in a shared memory space, while processes run in separate memory spaces. Threads are not independent of one another like processes are, and as a result, threads share with other threads their code section, data section, and OS resources (like open files and signals). But, like a process, a thread has its own program counter (PC), register set, and stack space.

> For more, refer to Process vs Thread.

For more, refer to Process vs Thread.