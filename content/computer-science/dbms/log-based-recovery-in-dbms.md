---
title: "Log based Recovery in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Log based Recovery in DBMS
Log-based recovery in DBMS ensures data can be maintained or restored in the event of a system failure. The DBMS records every transaction on stable storage, allowing for easy data recovery when a failure occurs. For each operation performed on the database, a log file is created. Transactions are logged and verified before being applied to the database, ensuring data integrity.

![log](images/log.webp)

## Log in DBMS

A log is a sequence of records that document the operations performed during database transactions. Logs are stored in a log file for each transaction, providing a mechanism to recover data in the event of a failure. For every operation executed on the database, a corresponding log record is created. It is critical to store these logs before the actual transaction operations are applied to the database, ensuring data integrity and consistency during recovery processes.

For example, consider a transaction to modify a student's city. This transaction generates the following logs:

1. Start Log: When the transaction begins, a log is created to indicate the start of the transaction.

- Format:<Tn, Start>
- Here, Tn represents the transaction identifier.
- Example: <T1, Start> indicates that Transaction 1 has started.

2. Operation Log: When the city is updated, a log is recorded to capture the old and new values of the operation.

- Format:<Tn, Attribute, Old_Value, New_Value>
- Example: <T1, City, 'Gorakhpur', 'Noida'> shows that in Transaction 1, the value of the City attribute has changed from 'Gorakhpur' to 'Noida'.

3. Commit Log: Once the transaction is successfully completed, a final log is created to indicate that the transaction has been completed and the changes are now permanent.

- Format:<Tn, Commit>
- Example: <T1, Commit> signifies that Transaction 1 has been successfully completed.

These logs play a crucial role in ensuring that the database can recover to a consistent state after a system crash. If a failure occurs, the DBMS can use these logs to either roll back incomplete transactions or redo committed transactions to maintain data consistency.

## Key Operations in Log-Based Recovery

### Undo Operation

The undo operation reverses the changes made by an uncommitted transaction. Even though the transaction did not commit, its dirty pages may have already been written to disk from the buffer. Undo restores the old values using the log to remove these partial changes.

Example of Undo: Consider a transaction T1 that updates a bank account balance but fails before committing:

Initial State: Account balance = 500.

Transaction T1:

- Update balance to 600.
- Log entry: <T1, Balance, 500, 600>

> <T1, Balance, 500, 600>

<T1, Balance, 500, 600>

Failure: T1 fails before committing.

Undo Process:

- Use the old value from the log to revert the change.
- Set balance back to 500.
- Final log entry after undo: <T1, Abort>

> <T1, Abort>

<T1, Abort>

### Redo Operation

The redo operation re-applies the changes of a committed transaction. Although the transaction has committed, its updated pages may not have been flushed to disk before the crash. Redo ensures that committed changes are safely applied to the database.

Example of Redo: Consider a transaction T2 that updates an account balance but the database crashes before changes are permanently reflected:

Initial State: Account balance = 300.

Transaction T2:

- Update balance to 400.
- Log entries: <T2, Start><T2, Balance, 300, 400><T2, Commit>

> <T2, Start><T2, Balance, 300, 400><T2, Commit>

<T2, Start><T2, Balance, 300, 400><T2, Commit>

Crash: Changes are not reflected in the database.

Redo Process:

- Use the new value from the log to reapply the committed change.
- Set balance to 400.

### Undo-Redo Example:

Assume two transactions:

- T1: Failed transaction (requires undo).
- T2: Committed transaction (requires redo).

#### Log File:

> <T1, Start><T1, Balance, 500, 600><T2, Start><T2, Balance, 300, 400><T2, Commit><T1, Abort>

<T1, Start><T1, Balance, 500, 600><T2, Start><T2, Balance, 300, 400><T2, Commit><T1, Abort>

Identify Committed and Uncommitted Transactions:

- T1: Not committed → Undo.
- T2: Committed → Redo.

Undo T1: Revert balance from 600 to 500.Redo T2: Reapply balance change from 300 to 400.

| Operation | Trigger | Action |
| --- | --- | --- |
| Undo | For uncommitted/failed transactions | Revert changes using the old values in the log. |
| Redo | For committed transactions | Reapply changes using the new values in the log. |

These operations ensure data consistency and integrity in the event of system failures.

## Approaches to Modify the Database

In database systems, changes to the database can be made using two main methods: Immediate Modification and Deferred Modification.

### 1. Immediate Modification

In the Immediate Modification method, the database is updated as soon as a change is made during a transaction, even before the transaction is committed. Logs are written before making any changes to ensure recovery is possible in case of a system failure.

![Transaction-Log-with-Immediate-Modification](images/transaction-log-with-immediate-modification.webp)

Transaction T0:

- Start: Transaction T0 begins, and the log records <T_0 start>.
- Change to A: A is updated from 500 to 450. The change is logged as <T_0, A, 500, 450>, and A's new value is reflected in memory.
- Change to B: B is updated from 300 to 350. The change is logged as <T_0, B, 300, 350>, and B's new value is reflected in memory.
- Commit: After both changes are completed, T0 is committed. The log records <T_0 commit>, and the new values of A and B are permanently written to storage.

Transaction T1:

- Start: Transaction T1 begins, and the log records <T_1 start>.
- Change to C: C is updated from 200 to 180. The change is logged as <T_1, C, 200, 180>, and C's new value is reflected in memory.
- Commit: After the change, T1 is committed. The log records <T_1 commit>, and the new value of C is permanently written to storage.

`<T_1 start>`

`<T_1, C, 200, 180>`

`<T_1 commit>`

### Key Characteristics of Immediate Modification:

- Changes Are Applied Immediately: Updates to the database are made as soon as a transaction executes an operation, even before the transaction commits.

- Requires Undo and Redo for Recovery: Uncommitted changes are reverted using undo, while committed changes are reapplied using redo during recovery.

- Logs Are Written First: All changes are logged before being applied to ensure recoverability and consistency in case of failure.

### 2. Deferred Modification

In the Deferred Modification method, changes to the database are not applied immediately. Instead, they are logged and stored temporarily. The database is only updated after the transaction is fully committed. This method ensures that no partial changes are made to the database, reducing the risk of inconsistency.

![Transaction-Log-with-Deferred-Modification](images/transaction-log-with-deferred-modification.webp)

Transaction T0:

- Start: Transaction T0T_0T0 begins, and the log records <T_0 start>.
- Change to A: A is intended to be updated from 1000 to 950.The log entry <T_0, A, 1000, 950> is recorded, but the change is not applied to the database yet. The value of A in the database remains 1000.
- Change to B: B is intended to be updated from 2000 to 2050. The log entry <T_0, B, 2000, 2050> is recorded, but the change is not applied to the database yet. The value of B in the database remains 2000.
- Commit: When T0 commits, the changes to A and B are applied to the database: A=950 B=2050

`<T_0 start>`

`<T_0, A, 1000, 950>`

`<T_0, B, 2000, 2050>`

Transaction T1:

- Start: Transaction T1 begins, and the log records <T_1 start>.
- Change to C: C is intended to be updated from 700 to 600.The log entry <T_1, C, 700, 600> is recorded, but the change is not applied to the database yet. The value of C in the database remains 700.
- Commit: When T1 commits, the change to C is applied to the database: C=600

`<T_1 start>`

`<T_1, C, 700, 600>`

### Key Characteristics of Deferred Modification:

- Changes Are Logged First: All updates are recorded in the log before any changes are applied to the database.
- Changes Are Applied Only After Commit: No updates are made to the database until the transaction commits. This prevents partial changes in case of a failure.
- Simpler Recovery Process: Since no changes are applied before commit, only redo operations are needed for recovery.

## Recovery using Log records

Log-based recovery is a method used in database systems to restore the database to a consistent state after a crash or failure. The process uses a transaction log, which keeps a record of all operations performed on the database, including updates, inserts, deletes, and transaction states (start, commit, or abort).

### How Log-Based Recovery Works ?

Transaction Log:

- The log stores all changes made by transactions, ensuring recoverability.
- Each transaction's start, changes (with old and new values), and its commit or abort state are recorded.

Recovery Process:

After a system crash, the database uses the log to determine:

- Undo: Transactions that started but didn’t commit (incomplete transactions) are undone to reverse their changes.
- Redo: Transactions that committed before the crash are redone to ensure their changes are applied to the database.

## Recovery Using Checkpoints

Checkpointing is a process used in DBMS to streamline the recovery procedure after a system crash by reducing the amount of log data that needs to be examined. It helps save the current state of the database and active transactions to make recovery faster and more efficient.For example: <checkpoint L> means the database state and the list of active transactions (L) were saved.

`<checkpoint L>`

When a crash occurs, recovery involves the following steps:

1. Find the Most Recent Checkpoint: Scan the log backward to locate the last <checkpoint> record.

`<checkpoint>`

2. Identify Relevant Transactions:

- Continue scanning backward until the <Ti start> record of the oldest active transaction at the time of the checkpoint is found.
- Transactions that started before this can be ignored, as their updates are already saved.

`<Ti start>`

3. Perform Undo Operations: For transactions without a <Ti commit> record, execute undo(Ti) to reverse incomplete changes. (Only needed in the immediate modification approach.)

`<Ti commit>`

4. Perform Redo Operations: For transactions with a <Ti commit> record, execute redo(Ti) to reapply their changes if needed.

`<Ti commit>`

Example: checkpoint occurred during: T67 and T69

Transactions T0 to T66 and T68: Completed before checkpoint → No action neededTransactions T67, T69 to T100: Occurred during/after checkpoint → Need to be checked

- If committed or aborted -> Redo
- If incomplete -> Undo

## Advantages of Log based Recovery

- Durability: In the event of a breakdown, the log file offers a dependable and long-lasting method of recovering data. It guarantees that in the event of a system crash, no committed transaction is lost.
- Faster Recovery: Since log-based recovery recovers databases by replaying committed transactions from the log file, it is typically faster than alternative recovery methods.
- Incremental Backup: Backups can be made in increments using log-based recovery. Just the changes made since the last backup are kept in the log file, rather than creating a complete backup of the database each time.
- Lowers the Risk of Data Corruption: By making sure that all transactions are correctly committed or canceled before they are written to the database , log-based recovery lowers the risk of data corruption.

## Disadvantages of Log based Recovery

- Additional overhead: Maintaining the log file incurs an additional overhead on the database system, which can reduce the performance of the system.
- Complexity: Log-based recovery is a complex process that requires careful management and administration. If not managed properly, it can lead to data inconsistencies or loss.
- Storage space: The log file can consume a significant amount of storage space, especially in a database with a large number of transactions.
- Time-Consuming: The process of replaying the transactions from the log file can be time-consuming, especially if there are a large number of transactions to recover.

### Related article

> Checkpoints in DBMS.

Checkpoints in DBMS.