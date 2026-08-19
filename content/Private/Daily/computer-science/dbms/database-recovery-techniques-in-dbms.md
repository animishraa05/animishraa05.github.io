---
title: "Database Recovery Techniques in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Database Recovery Techniques in DBMS
Database Systems, like any other computer system, are subject to failures. Whether it's a sudden power outage, a software bug, or a hardware crash, a Database Management System (DBMS) needs a way to get back up and running without losing data or leaving it in a corrupted state. This process of restoring the database to a correct and consistent state is called recovery.

## Types of Recovery Techniques

The main aim of recovery is to maintain "atomicity" and "durability", which are two important parts of the ACID properties:

- Atomicity: A transaction should either complete fully or not at all.
- Durability: Once a transaction is committed, its changes must stay in the database even if a failure occurs afterward.

Some of the main database recovery techniques are:

### 1. Log-Based Recovery

One of the most common recovery methods in modern databases. The keeps a log file (or journal) on stable storage that records every change—insert, update, or delete—before it is applied to the database.

If a failure occurs, the DBMS reads the log to decide what to do:

- Undo: Reverse changes from transactions that didn’t finish (ensuring atomicity).
- Redo: Reapply changes from committed transactions (ensuring durability).

Log-based recovery is mainly implemented in one of the following two ways:

1. Immediate Update (Undo/Redo): The database may be updated before a transaction commits. On failure, the system undoes uncommitted changes and redoes committed ones.
2. Deferred Update (No-Undo/Redo): Updates are applied only after commit. On failure, nothing needs to be undone; only redo is performed for committed transactions.

### 2. Shadow Paging

Shadow [[wiki/io/paging|Paging]] is an alternative recovery technique that avoids the need for a log. It works by keeping two versions of the database pages during a transaction: a current page table and a shadow page table

- The shadow page table points to the original, unmodified database pages from before the transaction began. It's a "shadow" of the consistent database state.
- When a transaction starts modifying data, new copies of the modified pages are created. The current page table is updated to point to these new pages while the shadow page table remains unchanged.

If the transaction commits, the current page table becomes the new shadow. If it fails, the system discards the modified pages and reverts to the shadow- no undo/redo needed.

> Note: While simple in concept, shadow [[wiki/io/paging]] can lead to storage fragmentation and be harder to manage.

Note: While simple in concept, shadow [[wiki/io/paging]] can lead to storage fragmentation and be harder to manage.

### 3. Checkpointing: Making Recovery Faster

Checkpointing is not a standalone recovery technique but a crucial optimization that works with Log-Based Recovery. Without it, recovering from a crash would require the DBMS to process the entire log file, which could take a very long time. A checkpoint is like a bookmark in the log.

Periodically, the system performs a checkpoint operation, which does the following:

1. Forces all log records from memory to stable storage.
2. Forces all modified database pages from memory to stable storage.
3. Writes a special checkpoint record into the log file.

When recovery is needed, the DBMS finds the last checkpoint. It knows that any transaction that committed before the checkpoint is already permanently saved. Therefore, it only needs to scan the log from the checkpoint onward to figure out which transactions to undo or redo, drastically speeding up the recovery time.

### 4. Backup and Restore

This serves as the last safeguard against severe failures, such as a complete disk crash, by keeping backup copies of the database files.

- Full Backup: A complete copy of the entire database.
- Differential Backup: A copy of only the data that has changed since the last full backup.
- Transaction Log Backup: A copy of the transaction log. This is crucial because it allows the database to be restored to a specific point in time. For example, you could restore a full backup from Sunday night and then apply the transaction logs to recover the database right up to the moment before it failed on Tuesday morning.