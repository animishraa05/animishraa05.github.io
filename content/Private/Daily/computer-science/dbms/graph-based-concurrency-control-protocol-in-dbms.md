---
title: "Graph Based Concurrency Control Protocol in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Graph Based Concurrency Control Protocol in DBMS
In a Database Management System (DBMS), multiple transactions often execute concurrently, which can lead to conflicts when they access the same data items. The Graph-Based Concurrency Control Protocol manages these conflicts using a directed graph structure to ensure conflict serializability and consistency.

- Transactions -> Nodes
- Conflicts (dependencies) -> Edges

Before granting a lock, the system checks the graph:

- If adding a new edge creates a cycle, a deadlock is detected.
- To resolve it, one of the transactions is rolled back to break the cycle.

> Note: Thus, the protocol ensures that the serialization graph remains acyclic, maintaining database consistency.

Note: Thus, the protocol ensures that the serialization graph remains acyclic, maintaining database consistency.

## Properties

- Deadlock-Free: Since cycles are not allowed, deadlocks cannot occur.
- No guarantee of recoverability: Transactions can still cause cascading rollbacks.
- More powerful than simple lock-based protocols because it can handle complex dependencies.
- Computationally expensive for large databases due to cycle detection and graph maintenance.

## Partial Ordering Requirement

Before applying the protocol, a partial ordering is defined on the set of data items. Let the set of database items be D = {d₁, d₂, d₃, ..., dₙ}. If dᵢ -> dⱼ, then any transaction accessing both must access dᵢ before dⱼ.

> Note: This ordering forms a Directed Acyclic Graph (DAG) - called the Database Graph.

Note: This ordering forms a Directed Acyclic Graph (DAG) - called the Database Graph.

## Tree Based Protocol

The Tree Protocol is a graph-based concurrency control method that ensures conflict serializability and deadlock freedom. Unlike Two-Phase Locking (2PL), it follows a hierarchical structure for locking data items.

### Rules of Tree Protocol:

1. Only exclusive (X) locks are allowed: No shared (S) locks are used.
2. The first lock can be on any data item: After that, a transaction can lock a data item only if it has locked its parent first.
3. Data items can be unlocked at any time: There is no strict two-phase rule.
4. No relocking: Once a transaction unlocks a data item, it cannot lock it again.

> Note: The Tree Protocol offers a balance between concurrency and [[deadlock-prevention|deadlock prevention]], making it useful in certain database applications.

Note: The Tree Protocol offers a balance between concurrency and [[deadlock-prevention|deadlock prevention]], making it useful in certain database applications.

![222](images_222.png)

Image - Database Graph

Let's look at an example based on the above Database Graph. We have three Transactions in this schedule and this is a skeleton example, i.e, we will only see how Locking and Unlocking work, let's keep this simple and not make this complex by adding operations on data.

| T1 | T2 | T3 |
| --- | --- | --- |
| Lock-X(A) |  |  |
| Lock-X(B) |  |  |
|  | Lock-X(D) |  |
|  | Lock-X(H) |  |
|  | Unlock-X(D) |  |
| Lock-X(E) |  |  |
| Lock-X(D) |  |  |
| Unlock-X(B) |  |  |
| Unlock-X(E) |  |  |
|  |  | Lock-X(B) |
|  |  | Lock-X(E) |
|  | Unlock-X(H) |  |
| Lock-X(B) |  |  |
| Lock-X(G) |  |  |
| Unlock-X(D) |  |  |
|  |  | Unlock-X(E) |
|  |  | Unlock-X(B) |
| Unlock-X(G) |  |  |

- From the above example, first see that the schedule is Conflict Serializable.
- Serializability for Locks can be written as T2 -> T1 -> T3.
- Data items Locked and Unlocked are following the same rule as given above and follow the Database Graph.

## Advantages of Tree Protocol

- Deadlock-free – No cycles form in the lock order, so no rollbacks are needed.
- Increased concurrency – Unlocking can happen earlier than in Two-Phase Locking, reducing wait times.
- Allows different schedules – Some schedules that are not possible under 2PL can be executed under the tree protocol.

## Drawbacks of Tree Protocol

- No guarantee of recoverability – Can lead to cascading rollbacks if not handled properly.
- Extra locks required – Transactions may need to lock unnecessary data items, increasing waiting time and locking overhead.
- Some schedules allowed in 2PL are not possible in Tree Protocol – While it provides flexibility, it also has limitations.