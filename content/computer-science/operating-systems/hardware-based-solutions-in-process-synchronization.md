---
title: "Hardware Based Solutions in Process Synchronization"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Hardware Based Solutions in Process Synchronization
Hardware-based solutions to the critical section problem use special instructions like [[test|Test]]-and-Set and Swap. These instructions help manage access to shared resources by allowing only one process to enter the critical section at a time. They are fast and efficient, making them ideal for systems with advanced hardware support.

Various hardware solutions to the Critical Section Problem are:

- [[test|Test]] and Set
- Swap

## 1. Test and Set

TAS is an atomic instruction that reads a variable’s old value and sets it to true in a single indivisible step.

> boolean lock = false; // Shared lock variableboolean TestAndSet(boolean &target) { boolean rv = target; // Step 1: Read old value target = true; // Step 2: Set lock (mark busy) return rv; // Step 3: Return old value}while (1) { while (TestAndSet(lock)); // Entry Section → Busy wait until lock is free // ---- Critical Section ---- lock = false; // Exit Section → Release lock // ---- Remainder Section ----}

boolean lock = false; // Shared lock variable

boolean TestAndSet(boolean &target) { boolean rv = target; // Step 1: Read old value target = true; // Step 2: Set lock (mark busy) return rv; // Step 3: Return old value}while (1) {

while (TestAndSet(lock)); // Entry Section → Busy wait until lock is free // ---- Critical Section ---- lock = false; // Exit Section → Release lock // ---- Remainder Section ----}

### Explanation of Pseudocode:

Mutual Exclusion

- Only one process can enter the critical section at a time because TestAndSet is atomic.
- If one process sets lock = true, all others will keep spinning in the inner while.

Critical Section Protection

- A process enters only if TestAndSet(lock) returns false (lock was free).
- If it returns true, the process keeps waiting.

Exit Section

After finishing, the process releases the lock by setting lock = false.

## 2. Swap (and CAS Enhancement)

The Swap instruction is a hardware-based synchronization mechanism similar to [[test|Test]]-and-Set. Instead of directly setting the lock, it swaps the values of a shared lock variable and a local key variable. This ensures mutual exclusion because only one process can set its key to false and enter the critical section, while others keep spinning.

> boolean lock = false; // Shared variableboolean key; // Local per-process variablevoid swap(boolean &a, boolean &b) { boolean temp = a; a = b b = temp;}while (1) { key = true; // Process wants to enter while (key) // Entry Section swap(lock, key); // Keep swapping until lock becomes true & key false // ---- Critical Section ---- lock = false; // Exit Section → Release lock}

boolean lock = false; // Shared variable

boolean key; // Local per-process variable

void swap(boolean &a, boolean &b) { boolean temp = a; a = b b = temp;}

while (1) { key = true; // Process wants to enter while (key) // Entry Section swap(lock, key); // Keep swapping until lock becomes true & key false // ---- Critical Section ---- lock = false; // Exit Section → Release lock}

### Explanation of Pseudocode

1. Initialization

- lock = false means no process is inside the critical section.
- Each process has a local key variable (initially false).

2. Entry Section

A process sets key = true (wants to enter).It then calls swap(lock, key):

`key = true`

`swap(lock, key)`

- If lock was false, swap makes key = false and lock = true, so the process enters.
- If lock was already true, key remains true, and the process spins in the loop.

3. Critical Section: Only the process that successfully swapped and got key = false enters.4. Exit Section: When the process leaves, it sets lock = false, allowing other waiting processes to try again.5. Remainder Section: The process executes other code before attempting entry again.

The Swap instruction ensures mutual exclusion and progress, but like [[test|Test]]-and-Set, it suffers from busy waiting and no bounded waiting guarantee.

### Compare-and-Swap (CAS) Enhancement

Modern CPUs often use CAS (Compare-and-Swap), which improves efficiency compared to Swap. CAS atomically compares a variable to an expected value and updates it only if they match.

> int lock = 0; // 0 = free, 1 = busyboolean CompareAndSwap(int &target, int expected, int new_val) { int old = target; if (target == expected) target = new_val; return old == expected; // true if swap succeeded}while (1) { while (!CompareAndSwap(lock, 0, 1)); // Try to acquire lock // ---- Critical Section ---- lock = 0; // Exit Section → Release lock}

int lock = 0; // 0 = free, 1 = busyboolean CompareAndSwap(int &target, int expected, int new_val) { int old = target; if (target == expected) target = new_val; return old == expected; // true if swap succeeded}while (1) { while (!CompareAndSwap(lock, 0, 1)); // Try to acquire lock // ---- Critical Section ---- lock = 0; // Exit Section → Release lock}

### Key Points

- Mutual Exclusion: Only one process at a time can succeed in swapping values.
- Progress: If the lock is free, a process will eventually enter.
- Drawbacks:Both Swap and CAS suffer from busy waiting.No bounded waiting guarantee → some processes may starve.

- Both Swap and CAS suffer from busy waiting.
- No bounded waiting guarantee → some processes may starve.

## 3. Spinlock

A Spinlock is a higher-level abstraction built using [[test|Test]]-and-Set or CAS.

- A process repeatedly checks if the lock is free (spins) instead of sleeping.
- Useful when waiting times are short (e.g., in kernel or multiprocessor systems).

### Example with Test-and-Set:

> int lock = 0; // 0 = free, 1 = busyvoid acquire() { while (TestAndSet(lock)); // Busy wait}void release() { lock = 0;}while (1) { acquire(); // ---- Critical Section ---- release(); // ---- Remainder Section ----}

int lock = 0; // 0 = free, 1 = busyvoid acquire() { while (TestAndSet(lock)); // Busy wait}void release() { lock = 0;}while (1) { acquire(); // ---- Critical Section ---- release(); // ---- Remainder Section ----}

Pros:

- Very fast on multiprocessor systems (no context switching overhead).
- Simple to implement with atomic instructions.

Cons:

- Causes busy waiting → wastes CPU cycles.
- Not suitable for long critical sections.

## Comparison of Hardware-Based Solutions

| Method | Mechanism | Pros | Cons |
| --- | --- | --- | --- |
| [[test|Test]]-and-Set | Atomically sets lock variable | Simple, widely supported | Busy waiting, starvation possible |
| Swap | Swap shared & local variables | Ensures mutual exclusion | Busy waiting, less efficient than CAS |
| CAS (enhanced) | Compare-and-swap atomic update | Efficient, lock-free possible | Still spins under contention |
| Spinlock | Lock abstraction (built on TAS/CAS) | Very fast for short waits | CPU wasting, not fair |