---
title: "Introduction to TimeStamp and Deadlock Prevention Schemes in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Introduction to TimeStamp and Deadlock Prevention Schemes in DBMS
In a Database Management System (DBMS), deadlocks occur when two or more transactions wait indefinitely for each other to release resources. This halts the system’s progress and affects database consistency. To handle this, various [[deadlock-prevention|deadlock prevention]] techniques are used in concurrency control

One effective approach to prevent deadlocks is Timestamp-Based [[deadlock-prevention|Deadlock Prevention]], which assigns timestamps to transactions and uses them to determine execution priority and order.

## Timestamp

A timestamp (TS) is a unique identifier assigned to each transaction by the DBMS when it begins. It defines the age of a transaction - older transactions have smaller timestamps and newer transactions have larger timestamps.

### Ways to Generate Timestamps:

1. Using a Counter: A simple counter value is incremented for each new transaction (TS = TS + 1).
2. Using System Clock: The timestamp is assigned based on the current system time (date and time).

> Note: Timestamps help ensure that transactions are executed in an order that maintains serializability, meaning the result is the same as if transactions had been executed one after another.

Note: Timestamps help ensure that transactions are executed in an order that maintains serializability, meaning the result is the same as if transactions had been executed one after another.

## Working of Timestamp-Based Scheduling

When a transaction requests access to a data item, the DBMS compares the timestamp of the requesting transaction with the timestamp of the last transaction that accessed that data item.

- If the requesting transaction is older, it is generally allowed to proceed.
- If it is younger (has a larger timestamp), it may be rolled back to prevent conflicts or potential deadlocks.

> Note: This ensures that transactions execute in a serializable and consistent order.

Note: This ensures that transactions execute in a serializable and consistent order.

## Timestamp-Based Deadlock Prevention

The Timestamp Ordering (TO) Protocol is a concurrency control technique that inherently prevents deadlocks because transactions are ordered by their timestamps and cannot wait indefinitely. Two major timestamp-based [[deadlock-prevention|deadlock prevention]] schemes are:

![Deadlock-Prevention-Schemes-based-on-Timestamp_](images/deadlock-prevention-schemes-based-on-timestamp_.webp)

### 1. Wait-Die Scheme

In this scheme:

- Older transactions are allowed to wait for younger ones.
- Younger transactions are aborted and restarted if they request a resource held by an older one.

> Rule: If TS(Ti) < TS(Tj) -> Ti is older than Tj -> Ti waits for Tj. Else (Ti is younger) -> Ti is aborted and restarted later with the same timestamp.

Rule: If TS(Ti) < TS(Tj) -> Ti is older than Tj -> Ti waits for Tj. Else (Ti is younger) -> Ti is aborted and restarted later with the same timestamp.

![Deadlock-Prevention-Schemes-based-on-Timestamp-2](images/deadlock-prevention-schemes-based-on-timestamp-2.webp)

Example:

| Transaction | Action |
| --- | --- |
| T1 (TS=10) | Requests item held by T2 (TS=20) |
| T1 is older | -> Allowed to wait |
| T2 (TS=20) | Requests item held by T1 (TS=10) |
| T2 is younger | -> Aborted and restarted |

> Result: Deadlocks are avoided because transactions wait in one direction (older -> younger), ensuring no cycles.

Result: Deadlocks are avoided because transactions wait in one direction (older -> younger), ensuring no cycles.

### 2. Wound-Wait Scheme

This is the opposite of the Wait-Die scheme.

- Older transactions preempt (wound) younger ones.
- Younger transactions are allowed to wait for older ones.

> Rule: If TS(Ti) < TS(Tj) -> Ti is older than Tj -> Abort Tj (Ti wounds Tj) and restart it later with the same timestamp. Else (Ti is younger) -> Ti waits.

Rule: If TS(Ti) < TS(Tj) -> Ti is older than Tj -> Abort Tj (Ti wounds Tj) and restart it later with the same timestamp. Else (Ti is younger) -> Ti waits.

![Deadlock-Prevention-Schemes-based-on-Timestamp-3](images/deadlock-prevention-schemes-based-on-timestamp-3.webp)

#### Example:

| Transaction | Action |
| --- | --- |
| T1 (TS=10) | Requests item held by T2 (TS=20) |
| T1 is older | -> T2 is aborted (wounded) |
| T2 (TS=20) | Requests item held by T1 (TS=10) |
| T2 is younger | -> Allowed to wait |

> Result: Older transactions never wait, reducing delays and ensuring deadlock-free operation.

Result: Older transactions never wait, reducing delays and ensuring deadlock-free operation.

## Wait-Die vs Wound-Wait

| Feature | Wait-Die | Wound-Wait |
| --- | --- | --- |
| Who waits? | Older waits for younger | Younger waits for older |
| Who gets aborted? | Younger transaction | Younger transaction |
| Aggressiveness | Less aggressive | More aggressive |
| Type of aborts | Fewer restarts (older waits) | More restarts (older wounds younger) |
| Starvation | Possible (older keeps waiting) | Less likely (older never waits) |

> Key Idea: Both schemes ensure that only younger transactions are aborted, breaking potential cycles and preventing deadlocks.

Key Idea: Both schemes ensure that only younger transactions are aborted, breaking potential cycles and preventing deadlocks.

## Deadlock Prevention Without Timestamps

### 1. No-Wait Algorithm

- If a transaction cannot get a required lock, it is immediately aborted and restarted later.
- There is no waiting, so deadlocks cannot occur.

> Drawback: Too many restarts -> increases overhead and reduces system performance.

Drawback: Too many restarts -> increases overhead and reduces system performance.

### 2. Cautious Waiting

When a transaction Ti requests a data item X held by Tj:

- If Tj is not waiting for any other item -> Ti can wait.
- If Tj is already waiting -> Ti is aborted to prevent a potential cycle.

> Advantage: Reduces unnecessary aborts compared to No-Wait. Still guarantees a deadlock-free system.

Advantage: Reduces unnecessary aborts compared to No-Wait. Still guarantees a deadlock-free system.

## Deadlock Detection Using Wait-for Graph

If the system does not prevent deadlocks in advance, it can detect them using a Wait-for Graph (WFG). Concept:

- Nodes: Transactions
- Edges (Ti -> Tj): Ti is waiting for a resource held by Tj

If the graph contains a cycle, it indicates a deadlock. The DBMS can then break the cycle by aborting one of the transactions involved.

> Example: T1 -> T2 -> T3 -> T1 -> Deadlock detected.

Example: T1 -> T2 -> T3 -> T1 -> Deadlock detected.

## Starvation in Databases

Starvation occurs when a transaction waits indefinitely because the system keeps prioritizing other transactions. This often happens in systems with frequent aborts or restarts, such as those using [[deadlock-prevention|deadlock prevention]] algorithms.

### Solution to Starvation

The most common method to prevent starvation is First-Come, First-Serve (FCFS) scheduling:

- Transactions are served in the order of their arrival.
- Ensures fairness - no transaction waits forever.

> Read more about Starvation in DBMS

Read more about Starvation in DBMS

## Role of the Concurrency Control Manager

The Concurrency Control Manager is responsible for:

- Scheduling transactions in a fair manner.
- Avoiding both deadlocks and starvation.
- Ensuring serializability, isolation and system consistency.

Note: It uses techniques like - Timestamps, Lock management, Wait-for Graphs, FCFS queueing to manage concurrent transaction execution effectively.

> Try this question: GATE | GATE-CS-2017 (Set 1) | Question 46

Try this question: GATE | GATE-CS-2017 (Set 1) | Question 46