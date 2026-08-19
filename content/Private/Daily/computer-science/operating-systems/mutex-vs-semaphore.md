---
title: "Mutex vs Semaphore"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Mutex vs Semaphore
Mutex and Semaphores are kernel resources that provide synchronization services (also known as synchronization primitives). Synchronization is required when multiple processes are executing concurrently, to avoid conflicts between processes using shared resources.

## Mutex

A mutex is different from a binary semaphore, which provides a locking mechanism. It stands for Mutual Exclusion Object. Mutex is mainly used to provide mutual exclusion to a specific portion of the code so that the process can execute and work with a particular section of the code at a particular time.

![Mutex](images_mutex.png)

- A mutex enforces strict ownership. Only the thread that locks the mutex can unlock it.
- It is specifically used for locking a resource to ensure that only one thread accesses it at a time.
- Due to this strict ownership, a mutex is not only typically used for signaling between threads, but it is used for mutual exclusion also to ensuring that a resource is accessed by only one thread at a time.
- Mutex uses a priority inheritance mechanism to avoid priority inversion issues.

> Note: The priority inheritance mechanism keeps higher-priority processes in the blocked state for the minimum possible time. However, this cannot avoid the priority inversion problem, but it can reduce its effect up to an extent.

Note: The priority inheritance mechanism keeps higher-priority processes in the blocked state for the minimum possible time. However, this cannot avoid the priority inversion problem, but it can reduce its effect up to an extent.

### Using Mutex

The producer-consumer problem: Consider the standard producer-consumer problem. Assume, we have a buffer of 4096-byte length. A producer thread collects the data and writes it to the buffer. A consumer thread processes the collected data from the buffer. The objective is, that both the threads should not run at the same time.

> Solution: A mutex provides mutual exclusion, either producer or consumer can have the key (mutex) and proceed with their work. As long as the buffer is filled by the producer, the consumer needs to wait and vice versa. At any point in time, only one thread can work with the entire buffer. The concept can be generalized using semaphore.

Solution: A mutex provides mutual exclusion, either producer or consumer can have the key (mutex) and proceed with their work. As long as the buffer is filled by the producer, the consumer needs to wait and vice versa. At any point in time, only one thread can work with the entire buffer. The concept can be generalized using semaphore.

### Advantages of Mutex

- No [[race-condition|race condition]] arises, as only one process is in the critical section at a time.
- Data remains consistent and it helps in maintaining integrity.
- It is a simple locking mechanism that into a critical section and is released while leaving the critical section.

### Disadvantages of Mutex

- If a thread holding the mutex is preempted or goes to sleep inside the critical section, other threads are blocked, which can lead to priority inversion or starvation.
- Mutexes involve context switching and kernel overhead, which makes them slower than spinlocks for very short critical sections.
- Incorrect usage (such as forgetting to unlock) can cause deadlock.

## Semaphore

A semaphore is a non-negative integer variable that is shared between various threads. Semaphore works upon signaling mechanism, in this a thread can be signaled by another thread.

![Semaphore](images_semaphore.png)

- It provides a less restrictive control mechanism. Any thread can invoke signal() (also known as release() or up()) and any other thread can invoke wait() (also known as acquire() or down()).
- There is no strict ownership in semaphores, meaning the thread that signals doesn't necessarily have to be the same one that waited.

`signal()`

> Note: Semaphores are often used for coordinating signaling between threads. Semaphore uses two atomic operations for process synchronization: Wait (P) & Signal (V).

Note: Semaphores are often used for coordinating signaling between threads. Semaphore uses two atomic operations for process synchronization: Wait (P) & Signal (V).

### Using Semaphore

The producer-consumer problem: Consider the standard producer-consumer problem. Assume, we have a buffer of 4096-byte length. A producer thread collects the data and writes it to the buffer. A consumer thread processes the collected data from the buffer. The objective is, both the threads should not run at the same time.

> Solution: A semaphore is a generalized mutex. instead a single buffer, we can split the 4 KB buffer into four 1 KB buffers (identical resources). A semaphore can be associated with these four buffers. The consumer and producer can work on different buffers at the same time.

Solution: A semaphore is a generalized mutex. instead a single buffer, we can split the 4 KB buffer into four 1 KB buffers (identical resources). A semaphore can be associated with these four buffers. The consumer and producer can work on different buffers at the same time.

### Advantages of Semaphore

- Multiple threads can access the critical section at the same time.
- Semaphores are machine-independent.
- Only one process will access the critical section at a time, however, multiple threads are allowed.
- Semaphores are machine-independent, so they should be run over microkernel.
- Flexible resource management.

### Disadvantages of Semaphore

- It has priority inversion.
- Semaphore operations (Wait, Signal) must be implemented in the correct manner to avoid deadlock.
- It leads to a loss of modularity, so semaphores can't be used for large-scale systems.
- Semaphore is prone to programming error and this can lead to deadlock or violation of mutual exclusion property.
- Operating System has to track all the calls to wait and signal operations.

## Difference Between Mutex and Semaphore

| Mutex | Semaphore |
| --- | --- |
| A mutex is an object. | A semaphore is an integer. |
| Mutex works upon the locking mechanism. | Semaphore uses signaling mechanism. |
| Operations on mutex: Lock & Unlock | Operation on semaphore: Wait & Signal |
| Mutex does not have any subtypes. | Semaphore is of two types: Counting Semaphore & Binary Semaphore |
| A mutex can only be modified by the process that is requesting or releasing a resource. | Semaphore work with two atomic operations (Wait, signal) which can modify it. |
| If the mutex is locked then the process needs to wait in the process queue and mutex can only be accessed once the lock is released. | If the process needs a resource and no resource is free. So, the process needs to perform a wait operation until the semaphore value is greater than zero. |

Operations on mutex: Lock & Unlock

Operation on semaphore: Wait & Signal

Semaphore is of two types: Counting Semaphore & Binary Semaphore

## Misconception of Mutex and Semaphore

There is an ambiguity between binary semaphore and mutex. We might have come across that a mutex is a binary semaphore. But it is not! The purposes of mutex and semaphore are different. Maybe, due to similarity in their implementation of a mutex would be referred to as a binary semaphore.

- A mutex is a locking mechanism used to synchronize access to a resource.
- Only one task (can be a thread or process based on OS abstraction) can acquire the mutex.
- It means there is ownership associated with a mutex and only the owner can release the lock (mutex).

While, a semaphore is a signaling mechanism used to control access to shared resources in an operating system. For example, imagine you are downloading a large file on your computer (Task A) while simultaneously trying to print a document (Task B). When the print job is initiated, it triggers a semaphore that checks if the download is complete.

- If the download is still in progress, the semaphore prevents the print task from proceeding, effectively saying, "Wait until the download finishes."
- Once the download completes, the semaphore signals that Task B can start printing.
- This ensures that both tasks do not interfere with each other and helps manage system resources efficiently, allowing tasks to run smoothly without conflict.