---
title: "Solutions to Process Synchronization Problems"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Solutions to Process Synchronization Problems
In a multiprogramming environment, multiple processes often compete for shared resources like memory, CPU, or files. If not managed properly, this leads to race conditions where the final output depends on the order of execution. To avoid such issues, process synchronization techniques are used.

Over the years, different solutions have been proposed, each improving upon the shortcomings of the previous one. The three major approaches are:

1. Interrupt Disable
2. Lock (Software-based & Hardware-based)
3. Operating System (OS)-based Solutions

![types_of_solutions_to_critical_section_problem](images/types_of_solutions_to_critical_section_problem.webp)

## 1. Interrupt Disable

- This method allows a process to disable all hardware interrupts before entering its critical section.
- Since no interrupts can occur, the running process cannot be preempted. It executes its critical section without interference.

Problems:

- Works only in uniprocessor systems. In multiprocessor systems, disabling interrupts on one CPU does not stop others.
- It is dangerous: if a process forgets to enable interrupts again, the system may hang.
- It gives too much power to user processes, which can misuse it.

Because of these limitations, interrupt disabling is rarely used in practice. This led to lock-based approaches.

## 2. Lock

Locks ensure that only one process at a time can enter the critical section. A process must “acquire” the lock before entering, and “release” it after exiting. If another process tries to enter while the lock is held, it must wait.

Locks can be implemented in two ways:

### (a) Software-Based Locks

Software-based locks are implemented using algorithms that rely on shared variables (like flags, turn variables, or ticket numbers) to coordinate access to the critical section. These solutions try to ensure mutual exclusion without depending on hardware instructions.

Some well-known algorithms are:

- Peterson’s Algorithm: works well for exactly two processes.
- Dekker’s Algorithm: One of the earliest algorithms for mutual exclusion. Works for exactly two processes using flags and a turn variable.
- Bakery Algorithm: works for multiple processes, inspired by “take-a-number” systems in shops.

Problems of Software Locks:

- Require busy waiting: the CPU wastes cycles looping while checking conditions.
- Peterson’s Algorithm is elegant, but only practical for two processes. Extending it to many processes (like Bakery Algorithm) makes the code complex.
- Not suitable for modern multiprocessor systems, where hardware-level atomicity is required.

Because of these inefficiencies, hardware support for locks was introduced.

### (b) Hardware-Based Locks

Modern CPUs provide special atomic instructions that make lock implementation easier and faster. These are much simpler than software algorithms like Peterson’s or Bakery. It works in multiprocessor systems, because the atomic instruction is enforced by the CPU’s memory system.

What does "atomic" mean here?

- Atomic means indivisible operation.
- Once an atomic instruction starts, it finishes completely before anything else (like another process or interrupt) can occur.
- This ensures that no two processes can modify the same lock at the same time.

Why is this important?

Without atomic operations, two processes could:

- Check the lock at the same time,
- Both see it as “free”,
- Both enter the critical section leading to a [[race-condition|race condition]].

How CPUs solve this:

CPUs include hardware-level instructions such as:

- [[test|Test]]-and-Set (TSL): Tests the lock’s old value and sets it to “locked” in one unbreakable step.
- Compare-and-Swap (CAS): Compares a memory value with an expected value and, if equal, swaps it with a new value atomically.
- Spinlocks: Built using TSL or CAS; processes “spin” (busy wait) until the lock becomes free. Very fast for short waits but wastes CPU cycles for long waits.

Limitations (why OS-based solutions are still needed):

- Processes may still use busy waiting, which wastes CPU cycles.
- No fairness guarantee one process might keep winning while others starve.
- Only solves basic mutual exclusion, not higher-level needs like sleeping, waking, or scheduling.

### 2.1 Mutex (Mutual Exclusion Lock)

A mutex is a higher-level lock abstraction often built on top of hardware primitives like spinlocks. Unlike raw locks, a mutex doesn’t always require busy waiting:

- If the mutex is unavailable, the process is blocked and put to sleep until the lock is released.
- This avoids wasting CPU cycles compared to spinlocks.
- Mutexes also provide fair scheduling and are widely used in thread libraries (e.g., Pthreads) and operating systems.

## 3. Semaphores and Monitors

Locks (software or hardware) solve the basic problem of mutual exclusion, but they still have limitations:

- They rely on busy waiting, wasting CPU cycles.
- They don’t provide higher-level management like blocking, waking up, or handling multiple conditions.

To address this, Operating Systems introduced more powerful synchronization tools: Semaphores and Monitors. These are built on top of lock-based mechanisms but provide extra control, safety and ease of use.

### (a) Semaphores

- A semaphore is an integer variable accessed with two atomic operations: wait() (decrement, block if < 0), signal() (increment, wake one waiting process)
- Removes busy waiting by blocking processes when resources are unavailable.

### (b) Monitors

- A monitor is a higher-level construct that combines mutual exclusion and condition variables.
- Only one process can execute in a monitor at a time, ensuring safety automatically.
- Condition variables (wait, signal) simplify coordination between processes.

### Related Posts:

> Software-based solutionsHardware-based solutionsOS-Based solutions

- Software-based solutions
- Hardware-based solutions
- OS-Based solutions