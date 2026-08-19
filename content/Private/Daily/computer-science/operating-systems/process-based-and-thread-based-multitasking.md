---
title: "Process-Based and Thread-Based Multitasking"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Process-Based and Thread-Based Multitasking
Multitasking is the ability of an operating system to run multiple tasks at the same time. It creates the illusion of simultaneous execution by quickly switching between tasks. This process is known as context switching, where the CPU allocates small time slots to each task. This ensures all tasks get a turn, preventing one from slowing down the entire system and allowing the user to run multiple applications smoothly.

## How Multitasking Works

Multitasking is achieved through:

- Time Slicing: Dividing CPU time among tasks in small slices.
- Context Switching: Saving the state of one task and restoring another’s state to resume execution seamlessly.
- Resource Management: Efficient allocation of memory, I/O devices, and CPU cycles across multiple tasks.

![multitasking](images_multitasking.webp)

## Types of Multitasking

Multitasking can be classified into two types based on the execution unit:

1. Process-based Multitasking
2. Thread-based Multitasking

Now lets discuss these two in brief:

## Process Based Multitasking

In process-based multitasking, two or more independent processes run concurrently. Each process is self-contained with:

- Its own memory space (address space)
- Its own code, data, and system resources
- Its own Process Control Block (PCB)

![process_based_multitasking](images_process_based_multitasking.webp)

### Key Features

- Isolation: Each process runs independently, preventing interference.
- Heavyweight: Requires more overhead due to separate memory allocation.
- Slower Communication: Inter-Process Communication (IPC) mechanisms (pipes, message queues, shared memory) add complexity.
- Better Security: Faults in one process do not affect others, ensuring stability.

### Benefits

- Strong fault isolation: one crashed process does not affect others.
- High robustness: ideal for untrusted or independent applications.

### Limitations

- Memory overhead due to separate address spaces.
- Higher context switching cost than threads.
- Complex IPC, which increases communication overhead.

Example: Running a music player while using a web browser. Both are separate processes with independent memory and resources.

## Thread Based Multitasking(Multithreading)

In thread-based multitasking, multiple threads run within a single process. Threads share:

- The same address space, code, and data
- But each has its own stack and execution context

![fig_thread_based_multitasking](images_fig_thread_based_multitasking.webp)

### Key Features

- Lightweight: Faster to create and manage compared to processes.
- Shared Memory: Enables direct communication between threads.
- Efficient Synchronization: Achieved using primitives like locks, semaphores, and condition variables.
- Scalable: Threads can exploit multiple CPU cores for parallelism.

### Benefits

- Lower overhead in terms of memory and context switching.
- Fast communication between threads through shared memory.
- Improved responsiveness within applications.

### Limitations

- Lack of isolation: A faulty thread may crash the entire process.
- Synchronization issues: Requires careful handling to avoid race conditions and deadlocks.
- Complex debugging: Concurrency issues make testing and debugging harder.

### Example

- In a web browser, one thread handles navigation while another downloads files.
- In MS Word, one thread processes text input while another performs spell-check.