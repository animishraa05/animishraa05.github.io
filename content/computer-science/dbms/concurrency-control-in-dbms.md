---
title: "Concurrency Control in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Concurrency Control in DBMS
In a Database Management System (DBMS), Concurrency control is a mechanism in DBMS that allows simultaneous execution of transactions while maintaining ACID properties - Atomicity, Consistency, Isolation and Durability. It maintains the integrity, accuracy and reliability of data when multiple users or processes perform read/write operations concurrently. It helps manage issues like:

- Conflicting operations on shared data
- Inconsistent database states
- Lost or incorrect updates

> Note: By implementing concurrency control techniques such as locking or timestamp ordering, DBMS ensures that transactions are executed safely and independently, even when they overlap in time.

Note: By implementing concurrency control techniques such as locking or timestamp ordering, DBMS ensures that transactions are executed safely and independently, even when they overlap in time.

## Need of Concurrency Control

Concurrency control is essential to:

![concurrency](images/concurrency.webp)

- Prevent conflicts between simultaneous transactions.
- Maintain data consistency and accuracy in multi-user environments.
- Avoid problems such as dirty reads, lost updates and inconsistent reads.

### Example:

- Without concurrency control: Two users update the same record simultaneously and one update overwrites the other.
- With concurrency control: The DBMS uses locks or timestamps to ensure updates occur sequentially and data remains correct.

## Concurrency Problems in DBMS

When multiple transactions execute concurrently, several problems may occur:

- Dirty Read: A transaction reads uncommitted data from another transaction that may later roll back.
- Lost Update: Two transactions update the same data and one update overwrites the other.
- Inconsistent Read: A transaction reads the same data multiple times and the data changes in between reads.

## Concurrency Control Protocols

Concurrency control protocols define rules to ensure correct and consistent execution of transactions. The main protocols are:

![concurrency_2](images/concurrency_2.webp)

### 1. Lock-Based Concurrency Control:

- Uses locks to restrict access to data items during a transaction. Common types include shared locks (read) and exclusive locks (write).
- Ensures serializability and prevents conflicts.
- Example: Two-Phase Locking (2PL) guarantees that once a transaction releases a lock, it cannot obtain any new locks.

### 2. Timestamp-Based Concurrency Control:

- Each transaction is assigned a timestamp.
- The DBMS uses these timestamps to order transactions and prevent conflicts based on their start time.

> Read more about Locked based concurrency control protocol & [[timestamp-based-concurrency-control|Timestamp based concurrency control]] protocol

Read more about Locked based concurrency control protocol & [[timestamp-based-concurrency-control|Timestamp based concurrency control]] protocol

## Recoverable and Cascadeless Schedules

Concurrency control also ensures proper scheduling of transactions:

### Recoverable Schedules:

- A transaction commits only if all transactions it depends on have committed.
- Prevents inconsistencies caused by dependent transactions.
- Example: Strict 2PL ensures recoverability by delaying commits until all dependent transactions commit.

### Cascadeless Schedules:

- Avoids cascading rollbacks, where one failed transaction causes others to fail.
- Achieved by allowing transactions to read data only after the previous transaction commits.

## Advantages of Concurrency Control

1. Reduced Waiting Time: Multiple transactions can proceed simultaneously, reducing idle time.
2. Improved Response Time: Faster access and interaction with the database.
3. Better Resource Utilization: Hardware and database resources are efficiently shared.
4. Increased System Efficiency: Higher throughput and better overall performance.

## Disadvantages of Concurrency Control

1. Overhead: Managing locks and timestamps adds system overhead.
2. Deadlocks: Circular waits between transactions can halt progress.
3. Reduced Concurrency: Locking can limit the number of simultaneous transactions.
4. Complexity: Implementation in distributed or large systems can be difficult.
5. Inconsistencies: Rollbacks or long waits may cause temporary data inaccuracy or staleness.