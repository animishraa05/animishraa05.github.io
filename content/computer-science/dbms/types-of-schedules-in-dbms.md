---
title: "Types of Schedules in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Types of Schedules in DBMS
Scheduling is the process of determining the order in which transactions are executed. When multiple transactions run concurrently, scheduling ensures that operations are executed in a way that prevents conflicts or overlaps between them.

![Types-of-Schedules](images/types-of-schedules.webp)

## 1. Serial Schedule

Schedules in which transactions execute one after another without interleaving., i.e., no transaction starts until a running transaction has ended are called serial schedules.

- Only one transaction runs at a time.
- No concurrency issues.
- Simple and always consistent.

Example: Consider the following schedule involving two transactions T1 and T2 .

![serial-schedule-examlpe](images/serial-schedule-examlpe.webp)

In the above table R(A) and W(A) denotes that a read and write operation is performed on some data item 'A' respectively, denoting a serial schedule since the transactions perform serially in the order T1 —> T2 .

## 2. Non-Serial Schedule

Transactions execute in an interleaved manner in Non-Serial Schedule.

- Allows concurrency.
- Must be checked for correctness.
- May or may not be serializable.

Non-serial schedules are of two types:

### Serializable Scheduling (Concurrency Control)

A non-serial schedule that behaves like a serial schedule.

### Why Serializable Schedules?

- Maintain consistency.
- Avoid anomalies.
- Improve performance by allowing concurrency.

There are two types of serializable schedules:

i. Conflict Serializable: A schedule is conflict serializable if it can be converted into a serial schedule by swapping non-conflicting operations.

Two operations conflict when:

- They belong to different transactions.
- They operate on the same data item.
- At least one operation is a write.

ii. View Serializable: A Schedule is called view serializable if:

- Transactions read the same initial values.
- Transactions read values written by the same transactions.
- The final write is by the same transaction as the serial schedule.

> Note: Conflict-serializable schedules are a subset of view-serializable schedules. (Conflict-serializable ⊂ View-serializable.)

Note: Conflict-serializable schedules are a subset of view-serializable schedules. (Conflict-serializable ⊂ View-serializable.)

### Non-Serializable Scheduling

Schedules that do not preserve serial equivalence and may lead to inconsistencies if not handled carefully.

They are classified into the following types:

i. Recoverable Schedule: Recoverable schedules are those in which a transaction commits only after all transactions whose values it has read have also committed.

- Key Point: If T2 reads a value written by T1, then T2 must commit after T1.

Example: Consider the following schedule involving two transactions T1 and T2 .

![Non-Serializable-Scheduling](images/non-serializable-scheduling.webp)

This is a recoverable schedule since T1 commits before T2 , that makes the value read by T2 correct. There can be three types of recoverable schedule:

ii. Cascading Schedule: A schedule where:

- Failure of one transaction forces all dependent transactions to abort.
- Happens when transactions read uncommitted data.

![Cascade-abort](images/cascade-abort.webp)

iii. Cascadeless Schedule: A schedule where:

- A transaction only reads committed data.
- Prevents cascading aborts.
- Key Point: T2 can read the value written by T1 only after T1 commits.

Example: Consider the following schedule involving two transactions T1 and T2 .

![Cascadeless-Schedule](images/cascadeless-schedule.webp)

This schedule is cascadeless. Since the updated value of A is read by T2 only after the updating transaction i.e. T1 commits.

Example: Consider the following schedule involving two transactions T1 and T2 .

![Cascadeless-Schedule-2-](images/cascadeless-schedule-2.webp)

It is a recoverable schedule but it does not avoid cascading aborts. It can be seen that if T1 aborts, T2 will have to be aborted too in order to maintain the correctness of the schedule as T2 has already read the uncommitted value written by T1 .

iv. Strict Schedule: It's a stronger form of cascadeless schedule that follows the following rules:

- A transaction cannot read or write a data item written by another transaction until that transaction commits or aborts.
- Prevents dirty reads and dirty writes.

Example: Consider the following schedule involving two transactions T1 and T2 .

![Strict-Schedule](images/strict-schedule.webp)

This is a strict schedule since T2 reads and writes A which is written by T1 only after the commit of T1 .

v. Non-Recoverable Schedule: A schedule where:

- A transaction commits after reading uncommitted data from another transaction.
- If the writer transaction later aborts, the schedule becomes invalid.
- Key Point: These schedules must be avoided since they lead to inconsistencies.

Example: Consider the following schedule involving two transactions T1 and T2.

![Non-Recoverable-Schedule](images/non-recoverable-schedule.webp)

T2 read the value of A written by T1, and committed. T1 later aborted, therefore the value read by T2 is wrong, but since T2 committed, this schedule is non-recoverable.

Summary of Relationships

- Cascadeless schedules are stricter than recoverable schedules or are a subset of recoverable schedules.
- Strict schedules are stricter than cascadeless schedules or are a subset of cascadeless schedules.
- Serial schedules satisfy constraints of all recoverable, cascadeless and strict schedules and hence is a subset of strict schedules.

The following Venn diagram shows the hierarchical relationship among the different types of schedules:

![Serializability-venn-diagram](images/serializability-venn-diagram.webp)

Question: Consider the following schedule:

> S:R1(A), W2(A), Commit2, W1(A), W3(A), Commit3, Commit1

S:R1(A), W2(A), Commit2, W1(A), W3(A), Commit3, Commit1

Which of the following is true?

(A) The schedule is view serializable schedule and strict recoverable schedule(B) The schedule is non-serializable schedule and strict recoverable schedule(C) The schedule is non-serializable schedule and is not strict recoverable schedule. (D) The Schedule is serializable schedule and is not strict recoverable schedule

Solution: The schedule can be depicted as:

![example-problem](images/example-problem.webp)

The schedule is view-serializable because it matches the serial order T1 → T2 → T3 (initial read, intermediate writes, and final write all match this order).

- The schedule is not strict because T1 writes A, and T3 writes A before T1 commits, which violates the rule that a transaction must wait for the previous writer to commit.
- The schedule is recoverable, but not strict recoverable (Correct option is D).