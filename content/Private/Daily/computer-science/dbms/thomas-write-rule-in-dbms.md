---
title: "Thomas Write Rule in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Thomas Write Rule in DBMS
The Thomas Write Rule (TWR) is an extension of the Basic Timestamp Ordering (TO) Protocol used for concurrency control in Database Management Systems (DBMS).

- Developed by: R. H. Thomas (1979)
- Type: Timestamp-based concurrency control
- Goal: Reduce unnecessary rollbacks while maintaining view serializability

> Note: It allows higher concurrency by ignoring obsolete writes instead of aborting transactions, as long as doing so doesn’t affect the final database state.

Note: It allows higher concurrency by ignoring obsolete writes instead of aborting transactions, as long as doing so doesn’t affect the final database state.

## Basic Idea

In the Basic Timestamp Ordering (TO) protocol, if a transaction tries to write an outdated value, it is aborted. However, in the Thomas Write Rule, instead of aborting, the outdated write is ignored, allowing the transaction to continue.

> Note: This helps avoid unnecessary aborts and increases system throughput.

Note: This helps avoid unnecessary aborts and increases system throughput.

### Notations:

| Symbol | Meaning |
| --- | --- |
| TS(T) | Timestamp of transaction T |
| R_TS(X) | Timestamp of the last read on data item X |
| W_TS(X) | Timestamp of the last write on data item X |

## Write Operation Conditions in TWR

### 1. Abort the Transaction:

- If R_TS(X) > TS(T)
- A newer transaction has already read X, so writing now would violate serializability.
- Action: Abort and rollback T.

### 2. Ignore Outdated Writes (Allow Execution Without Writing):

- If W_TS(X) > TS(T)
- A newer write has already updated X. Writing now is obsolete.
- Action: Ignore the write; continue the transaction.

### 3. Execute Write Operation (Normal Execution):

- If neither condition above is true
- Action: Execute W_item(X) and update W_TS(X) = TS(T)

## Example - Ignoring an Outdated Write

The main improvement in Thomas Write Rule is that it ignores obsolete (outdated) writes instead of rejecting transactions. This happens when a newer transaction has already updated a value, making the older transaction's write operation unnecessary. Let's consider two transactions:

- TS(T1) = 30, TS(T2) = 20
- T1 arrives after T2

### Schedule Execution:

| Step | Operation | Description |
| --- | --- | --- |
| 1 | T2: W2(X) | T2 writes X (sets W_TS(X) = TS(T2)) |
| 2 | T1: W1(X) | T1 tries to write X (TS(T1) > W_TS(X)) |
| 3 | T1's write is ignored | Since T2 has already written X, T1’s write is obsolete and ignored instead of rollback |

- In Basic Timestamp Ordering, T1 would abort because its write is considered outdated.
- In Thomas Write Rule, outdated writes are ignored instead of rollback, allowing T1 to continue execution.

Consider the partial schedule given below - Obsolete Writes are hence ignored in this rule which is in accordance with the 2nd protocol.

![Example of Outdated Write](images_example-of-outdated-write.webp)

> Note: It seems to be more logical as users skip an unnecessary procedure of restarting the entire transaction. This protocol is just a modification to the Basic TO protocol.

Note: It seems to be more logical as users skip an unnecessary procedure of restarting the entire transaction. This protocol is just a modification to the Basic TO protocol.

## Example - View-Serializable but Not Conflict-Serializable

| T1 | T2 |
| --- | --- |
| R(A) |  |
| W(A) |  |
| Commit |  |
|  | W(A) |
|  | Commit |

- TWR allows such schedules because it ignores outdated writes.
- The schedule is view-serializable but not conflict-serializable.
- Hence, Thomas Write Rule guarantees view serializability, not conflict serializability.

## Comparison between Basic TO and Thomas Write Rule

| Aspect | Basic Timestamp Ordering (TO) | Thomas Write Rule (TWR) |
| --- | --- | --- |
| Basis | Strict timestamp checking for reads/writes | Modified TO that ignores outdated writes |
| Outdated Writes | Transaction aborted | Write ignored |
| Type of Serializability | Conflict serializable | View serializable (not always conflict serializable) |
| Concurrency Level | Low (more rollbacks) | Higher (fewer rollbacks) |
| System Throughput | Low | High |