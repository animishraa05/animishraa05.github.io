---
title: "Timestamp based Concurrency Control"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Timestamp based Concurrency Control
Timestamp-based concurrency control is a technique used in database management systems (DBMS) to ensure serializability of transactions without using locks. It uses timestamps to determine the order of transaction execution and ensures that conflicting operations follow a consistent order.

Each transaction T is assigned a unique timestamp TS(T) when it enters the system. This timestamp determines the transaction’s place in the execution order.

## Timestamp Ordering Protocol

The Timestamp Ordering Protocol enforces that older transactions (with smaller timestamps) are given higher priority. This prevents conflicts and ensures the execution is serializable and deadlock-free.

For example:

- If Transaction T1 enters the system first, it gets a timestamp TS(T1) = 007 (assumption).
- If Transaction T2 enters after T1, it gets a timestamp TS(T2) = 009 (assumption).

This means T1 is "older" than T2 and T1 should execute before T2 to maintain consistency.

## Features of Timestamp Ordering Protocol:

### 1. Transaction Priority:

- Older transactions (those with smaller timestamps) are given higher priority.
- For example, if transaction T1 has a timestamp of 007 times and transaction T2 has a timestamp of 009 times, T1 will execute first as it entered the system earlier.

### 2. Early Conflict Management:

Unlike lock-based protocols, which manage conflicts during execution, timestamp-based protocols start managing conflicts as soon as a transaction is created.

### 3. Ensuring Serializability:

The protocol ensures that the schedule of transactions is serializable. This means the transactions can be executed in an order that is logically equivalent to their timestamp order.

## How Timestamp Ordering Works

Each data item X in the database keeps two timestamps:

- W_TS(X): Timestamp of the last transaction that wrote to X
- R_TS(X): Timestamp of the last transaction that read from X

## Basic Timestamp Ordering

The Basic TO Protocol works by comparing the timestamp of the current transaction with the timestamps on the data items it wants to read/write:

![Timestamp based Protocol](images/timestamp-based-protocol.png)

Precedence Graph for TS ordering

- Suppose, if an old transaction Ti has timestamp TS(Ti), a new transaction Tj is assigned timestamp TS(Tj) such that TS(Ti) < TS(Tj).
- The protocol manages concurrent execution such that the timestamps determine the serializability order.
- The timestamp ordering protocol ensures that any conflicting read and write operations are executed in timestamp order.
- Whenever some Transaction T tries to issue a R_item(X) or a W_item(X), the Basic TO algorithm compares the timestamp of T with R_TS(X) & W_TS(X) to ensure that the Timestamp order is not violated.

Two Basic TO protocols are discussed below:

1. Whenever a Transaction T issues a R_item(X) operation, check the following conditions:

- If W_TS(X) > TS(T) → Abort T (conflict: a newer write already occurred)
- Else → Allow read and set R_TS(X) = max(R_TS(X), TS(T))

2. Whenever a Transaction T issues a W_item(X) operation, check the following conditions:

- If R_TS(X) > TS(T) or W_TS(X) > TS(T) → Abort T (conflict: older transaction overwriting newer read/write)
- Else → Allow write and set W_TS(X) = TS(T)

When conflicts are detected, the younger transaction is aborted and rolled back.

## Strict Timestamp Ordering Protocol

The Strict Timestamp Ordering Protocol is an enhanced version that avoids cascading rollbacks by delaying operations until it's safe to execute them.

### Key Features

- Strict Execution Order: Transactions must execute in the exact order of their timestamps. Operations are delayed if executing them would violate the timestamp order, ensuring a strict schedule.
- No Cascading Rollbacks: To avoid cascading aborts, a transaction must delay its operations until all conflicting operations of older transactions are either committed or aborted.
- Consistency and Serializability: The protocol ensures conflict-serializable schedules by following strict ordering rules based on transaction timestamps.

### Rules for Read Operation R_item(X):

T can read X only if:

- W_TS(X) ≤ TS(T) and
- The transaction that last wrote X has committed

### Rules for Write Operation W_item(X):

T can write X only if:

- R_TS(X) ≤ TS(T) and W_TS(X) ≤ TS(T) and
- All previous readers/writers of X have committed

If these conditions aren't met, the operation is delayed (not aborted immediately).

| Advantages | Disadvantages |
| --- | --- |
| Conflict-Serializable: Maintains a correct execution order | Cascading Rollbacks (in Basic TO protocol) |
| Deadlock-Free: No locks, so no circular waits | Starvation: Newer transactions may be delayed |
| Simple Conflict Resolution: Uses timestamps only | High Overhead: Constantly updating R_TS/W_TS |
| No Locking Needed: Avoids lock management complexity | Lower Throughput under high concurrency |
| Predictable Execution: Operations follow a known order | Delayed Execution in Strict TO for consistency |

### Related PYQs

> GATE | GATE CS 2010 | Question 20GATE | GATE-CS-2017 (Set 1) | Question 46GATE | GATE-IT-2004 | Question 21

1. GATE | GATE CS 2010 | Question 20
2. GATE | GATE-CS-2017 (Set 1) | Question 46
3. GATE | GATE-IT-2004 | Question 21