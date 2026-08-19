---
title: "Handling Deadlocks"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Handling Deadlocks
Deadlock handling methods are strategies used in operating systems to ensure processes do not remain permanently blocked, maintaining smooth execution and system reliability.

## Methods of Handling Deadlocks

There are four approaches to dealing with deadlocks.

![methods_of_handling_deadlocks](images_methods_of_handling_deadlocks.webp)

Lets discuss them in short:

### 1. Deadlock Prevention

[[deadlock-prevention|Deadlock Prevention]] is a method of handling deadlocks where the operating system ensures that at least one of the necessary conditions for deadlock (mutual exclusion, hold and wait, no preemption, circular wait) never occurs. By breaking these conditions in advance, the system prevents deadlock from happening.

> Read more about [[deadlock-prevention|Deadlock Prevention]]

Read more about [[deadlock-prevention|Deadlock Prevention]]

### 2. Deadlock Avoidance

Deadlock Avoidance is a method where the operating system makes decisions dynamically to ensure the system never enters an unsafe state, thereby avoiding the possibility of deadlock. This is usually done using algorithms like the Banker’s Algorithm.

Deadlock avoidance mainly relies on algorithms that check resource allocation before making decisions. The two common types are:

1. Banker’s Algorithm: Used when multiple instances of resources exist. It simulates allocation and ensures that the system remains in a safe state before granting resources.
2. Resource Allocation Graph (RAG) Algorithm: Used when each resource has only one instance. It checks for cycles in the graph to avoid unsafe states.

> Read more about [[bankers-algorithm|Banker's Algorithm]] & Resource Allocation Graph

Read more about [[bankers-algorithm|Banker's Algorithm]] & Resource Allocation Graph

### 3. Deadlock Detection & Recovery

Deadlock Detection: Deadlock detection periodically checks for circular waits and resolves deadlocks by aborting and restarting processes, releasing their resources. It allows unrestricted resource access and immediate request fulfillment, enabling online handling. The main drawback is potential loss due to preemption.

Deadlock Recovery is the process of handling a deadlock after it has occurred. It involves:

1. Process Termination: Aborting one or more deadlocked processes to break the cycle.
2. Resource Preemption: Temporarily taking resources from some processes and reallocating them to others.

> Read more about [[deadlock-detection-and-recovery|Deadlock Detection and Recovery]]

Read more about [[deadlock-detection-and-recovery|Deadlock Detection and Recovery]]

### 4. Deadlock Ignorance

In the Deadlock ignorance method the OS acts like the deadlock never occurs and completely ignores it even if the deadlock occurs. This method only applies if the deadlock occurs very rarely. The algorithm is very simple. It says, " if the deadlock occurs, simply reboot the system and act like the deadlock never occurred." That's why the algorithm is called the Ostrich Algorithm.

> Read more about Deadlock Ignorance

Read more about Deadlock Ignorance