---
title: "Semaphores in Process Synchronization"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Semaphores in Process Synchronization
A semaphore is a synchronization tool used in operating systems to manage access to shared resources in a multi-process or multi-threaded environment. It is an integer variable that controls process execution using atomic operations like wait() and signal(). Semaphores help prevent race conditions and ensure proper coordination between processes.

- Controls entry into the critical section.
- Maintains a counter representing available resources.
- Ensures mutual exclusion among processes.
- Can block and wake up processes during execution.
- Widely used in concurrent programming.


## How Semaphores Work

A semaphore in OS uses two primary atomic operations:

### 1. wait(S)

![1](Daily/computer-science/operating-systems/images/1.webp)

- Decrements the semaphore value.
- If the value is less than 0, the process waits until the resource is available.
- Used to acquire a resource.

### 2. signal(S)

![373547701](images_373547701.webp)

- Increments the semaphore value.
- If there are waiting processes, one is awakened.
- Used to release a resource.

Example: Let’s consider two processes P1 and P2 sharing a semaphore S, initialized to 1:

- State 1: Both processes are in their non-critical sections, and S = 1.
- State 2: P1 enters the critical section. It performs wait(S), so S = 0. P2 continues in the non-critical section.
- State 3: If P2 now wants to enter, it cannot proceed since S = 0. It must wait until S > 0.
- State 4: When P1 finishes, it performs signal(S), making S = 1. Now P2 can enter its critical section and again sets S = 0.

This mechanism guarantees mutual exclusion, ensuring that only one process can access the shared resource at a time, see the image below for reference:

![Semaphores](images_semaphores.webp)

## Features of Semaphores

- Mutual Exclusion: Semaphore ensures that only one process accesses a shared resource at a time.
- Process Synchronization: Semaphore coordinates the execution order of multiple processes.
- Resource Management: Limits access to a finite set of resources, like printers, devices, etc.
- Reader-Writer Problem: Allows multiple readers but restricts the writers until no reader is present.
- Avoiding Deadlocks: Prevents deadlocks by controlling the order of allocation of resources.

## Types of Semaphores

Semaphores are mainly of two Types:

### 1. Counting Semaphore

A counting semaphore can have values ranging from 0 to any positive integer. It is used when multiple instances of a resource are available and need to be managed.

- Value ranges from 0 to n.
- Manages multiple resource instances.
- Controls access to limited resources.
- Example: Managing access to 5 printers or 3 database connections.

### 2. Binary Semaphore

A binary semaphore has only two possible values: 0 and 1. It is mainly used for mutual exclusion, ensuring that only one process enters the critical section at a time.

- Value is either 0 or 1.
- Used for mutual exclusion.
- Similar to a mutex lock.
- Managing access to a single critical section

## Limitations of Semaphores

- Priority Inversion: A low-priority process holding a semaphore can block a high-priority one.
- Deadlock: Processes may wait on each other’s semaphores in a cycle, causing indefinite blocking.
- Complex to Manage: The OS must carefully track wait and signal calls; misuse can cause errors.
- Busy Waiting: In basic implementations, processes may keep checking the semaphore value, wasting CPU time.