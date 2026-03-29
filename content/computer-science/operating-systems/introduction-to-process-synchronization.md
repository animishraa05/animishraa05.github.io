---
title: "Introduction to Process Synchronization"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Introduction to Process Synchronization
Process Synchronization is a mechanism in operating systems used to manage the execution of multiple processes that access shared resources. Its main purpose is to ensure data consistency, prevent race conditions and avoid deadlocks in a multi-process environment.

On the basis of synchronization, processes are categorized as one of the following two types:

- Independent Process: The execution of one process does not affect the execution of other processes.
- Cooperative Process: A process that can affect or be affected by other processes executing in the system.

Process Synchronization is the coordination of multiple cooperating processes in a system to ensure controlled access to shared resources, thereby preventing race conditions and other synchronization problems.

![imgk](images/imgk.png)

Improper Synchronization in Inter Process Communication Environment leads to following problems:

1. Inconsistency: When two or more processes access shared data at the same time without proper synchronization. This can lead to conflicting changes, where one process’s update is overwritten by another, causing the data to become unreliable and incorrect.
2. Loss of Data: Loss of data occurs when multiple processes try to write or modify the same shared resource without coordination. If one process overwrites the data before another process finishes, important information can be lost, leading to incomplete or corrupted data.
3. Deadlock: Lack of proper Synchronization leads to Deadlock which means that two or more processes get stuck, each waiting for the other to release a resource. Because none of the processes can continue, the system becomes unresponsive and none of the processes can complete their tasks.

## Role of Synchronization in IPC

1. Preventing Race Conditions: Ensures processes don’t access shared data at the same time, avoiding inconsistent results.
2. Mutual Exclusion: Allows only one process in the critical section at a time.
3. Process Coordination: Lets processes wait for specific conditions (e.g., producer-consumer).
4. [[deadlock-prevention|Deadlock Prevention]]: Avoids circular waits and indefinite blocking by using proper resource handling.
5. Safe Communication: Ensures data/messages between processes are sent, received and processed in order.
6. Fairness: Prevents starvation by giving all processes fair access to resources.

## Types of Process Synchronization

The two primary type of process Synchronization in an Operating System are:

- Competitive: Two or more processes are said to be in Competitive Synchronization if and only if they compete for the accessibility of a shared resource.Lack of Proper Synchronization among Competing process may lead to either Inconsistency or Data loss.
- Cooperative: Two or more processes are said to be in Cooperative Synchronization if and only if they get affected by each other i.e. execution of one process affects the other process.Lack of Proper Synchronization among Cooperating process may lead to Deadlock.

Example: Let consider a Linux code:

> >>ps/grep "chrome"/wc

>>ps/grep "chrome"/wc

- ps command produces list of processes running in linux.
- grep command find/count the lines form the output of the ps command.
- wc command counts how many words are in the output.

Therefore, three processes are created which are ps, grep and wc. grep takes input from ps and wc takes input from grep.

From this example, we can understand the concept of cooperative processes, where some processes produce and others consume and thus work together. This type of problem must be handled by the operating system, as it is the manager.

## Conditions That Require Process Synchronization

1. Critical Section: A critical section is a code segment that can be accessed by only one process at a time. The critical section contains shared variables that need to be synchronized to maintain the consistency of data variables. So the critical section problem means designing a way for cooperative processes to access shared resources without creating data inconsistencies.

2. [[race-condition|Race Condition]]: A [[race-condition|race condition]] is a situation that may occur inside a critical section. This happens when the result of multiple process/thread execution in the critical section differs according to the order in which the threads execute.

3. Pre-emption: Preemption is when the operating system stops a running process to give the CPU to another process. This allows the system to make sure that important tasks get enough CPU time. This is important as mainly issues arise when a process has not finished its job on shared resource and got preempted. The other process might end up reading an inconsistent value if process synchronization is not done.