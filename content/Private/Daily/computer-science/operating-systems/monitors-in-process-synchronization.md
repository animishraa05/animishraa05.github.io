---
title: "Monitors in Process Synchronization"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Monitors in Process Synchronization
Monitors are a high-level synchronization mechanism that simplify process and thread synchronization. They are built on top of locks and are mostly used in multithreading systems like Java.

Unlike semaphores, where the programmer must explicitly call wait() and signal(), monitors combine shared data and the operations on that data inside a single structure, making synchronization safer and easier to manage.

Key Points:

- A monitor is similar to a class/module that groups shared variables and the functions that operate on them.
- Only one thread can execute inside a monitor at a time, ensuring automatic mutual exclusion.
- In Java, monitors are implemented using classes and synchronized methods.
- There is no monitor keyword in Java – the functionality is achieved through synchronized.

## How to Implement Monitors

- Monitors are implemented at the programming language level, not directly by the operating system.
- In Java, monitor-like behavior is achieved using the synchronized keyword ensures that only one thread can execute inside the monitor at a time.
- A monitor encapsulates both shared data (critical resource) and the operations that access or modify it.
- Mutual exclusion is enforced automatically, unlike semaphores where programmers must explicitly call wait() and signal().
- Synchronization can be applied through synchronized methods or synchronized blocks.
- Condition variables are used to control thread waiting and signaling.
- The methods wait(), notify(), and notifyAll() provide process coordination.

![class](images_class.webp)

## Condition Variables in Monitors

A condition variable allows threads to wait until a certain condition becomes true. They are always used inside a monitor. There are three main condition variables:

- wait(): temporarily releases the monitor lock and puts the thread to sleep until it is signaled.
- signal(): wakes up one waiting thread (if any).
- broadcast() (in some languages): wakes up all waiting threads.

Pseudocode for monitors:

> class AccountUpdate { private int bal; condition sufficientFunds; // condition variable void synchronized deposit(int n) { // increase balance // signal waiting threads that funds are available } void synchronized withdraw(int n) { // if (bal < n) -> wait on sufficientFunds // else -> perform withdrawal (bal = bal - n) }}

class AccountUpdate {

private int bal; condition sufficientFunds; // condition variable

void synchronized deposit(int n) {

// increase balance // signal waiting threads that funds are available }

void synchronized withdraw(int n) { // if (bal < n) -> wait on sufficientFunds // else -> perform withdrawal (bal = bal - n) }

### Example: Monitor Implementation in Java

Here is a simple example of a Bank Account Monitor which will have two features (deposit and withdraw) using Java:

`class AccountUpdate {
    private int bal;

    void synchronized deposit(int n) {
        bal = bal + n;
    }

    void synchronized withdraw(int n) {
        bal = bal - n;
    }
}
`

```
class AccountUpdate {
    private int bal;

    void synchronized deposit(int n) {
        bal = bal + n;
    }

    void synchronized withdraw(int n) {
        bal = bal - n;
    }
}

```

Code Explanation

- class AccountUpdate: Defines the monitor as a class.
- private int bal; Shared resource (balance) which should be accessed by only one thread at a time.
- synchronized deposit(int n): Ensures that only one thread can deposit at a time, preventing race conditions.
- bal = bal + n; Updates the balance by adding the deposited amount.
- synchronized withdraw(int n): Ensures withdrawal operation is also mutually exclusive.
- bal = bal - n; Updates the balance by deducting the withdrawn amount.
- Use of synchronized – Makes the methods act like monitor procedures, guaranteeing mutual exclusion.

### Limitations of Monitors

- Language Dependency: Monitors must be built into the programming language itself; they cannot be added externally like libraries.
- Compiler Burden: The compiler has to generate extra code to manage monitor functionality.
- OS Dependency: The compiler also needs awareness of operating system facilities that handle critical section access.
- Limited Language Support: Only some languages support monitors directly, such as Java, C#, Visual Basic, Ada, and Concurrent Euclid.
- Reduced Flexibility: Since monitors are tightly coupled with language and compiler design, portability across different environments is limited.