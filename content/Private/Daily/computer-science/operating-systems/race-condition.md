---
title: "Race condition"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Race condition
A race condition occurs when two or more processes or threads access and modify the same data at the same time, and the final result depends on the order in which they run. Without proper coordination, this can lead to incorrect or unpredictable results. For example, if two people update the same bank account simultaneously without checking each other’s changes, the final balance may be wrong.

### Key Concepts

- Shared Resource: A variable, file, memory location, or device accessed by multiple processes.
- Concurrency: Multiple processes or threads executing simultaneously or overlapping in execution.
- Non-Atomic Operations: Operations that can be interrupted, such as read-modify-write, which can cause inconsistent states when multiple processes access the same data concurrently.

### Causes of Race Conditions

- Simultaneous Access: when two or more processes try to read or write the same shared resource at the same time.
- Non-Atomic Updates: Operations like increment or decrement are not indivisible.
- Lack of Synchronization: No mechanisms like locks, semaphores, or monitors are used to control access.
- Improper Scheduling: OS scheduler interrupts processes at critical moments.

## Example: Two Processes Updating a Shared Variable

Let’s take a shared variable balance = 100 and two processes P1 and P2:

- P1 wants to add 10 to balance.
- P2 wants to subtract 10 from balance.

Scenario without synchronization:

![racecondition](images_racecondition.webp)

Explanation:

- P1 reads balance = 100 and prepares to add 10.
- Before P1 updates the balance with the new value (110), it is interrupted by the process P2.
- P2, unaware of P1’s action (of adding 10), reads the balance as 100 (incorrect) and prepares to subtract 10.
- After subtracting, P2 updates the balance to 90 and then P1 resumes and writes the balance as 110 which is incorrect now.

In many cases, the final balance may incorrectly be 110 or 90, instead of the expected 100. This is a classic race condition.

## Effects of Race Conditions

- Data Corruption: Shared data may become inconsistent.
- Unpredictable Behavior: The output may vary every time the program runs.
- Security Risks: Race conditions can be exploited, e.g., in banking transactions or authentication bypass.
- System Crashes: Critical system data may get corrupted, leading to failures.

## Prevention Techniques

1. Mutex (Mutual Exclusion): Ensure only one process can enter the critical section at a time.
2. Semaphores: Counting or binary semaphores control access to resources.
3. Monitors: High-level synchronization constructs that manage shared resources.
4. Atomic Operations: Use hardware or software-supported atomic instructions.
5. Disable Interrupts (for kernel-level programming): Prevent context switches during critical sections.
6. Proper Scheduling: Ensure the scheduler does not preempt critical section execution.