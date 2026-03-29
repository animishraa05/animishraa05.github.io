---
title: "Introduction of Deadlock in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Introduction of Deadlock in Operating System
Deadlock is a state in an operating system where two or more processes are stuck forever because each is waiting for a resource held by another. It happens only when four conditions exist: mutual exclusion, hold and wait, no preemption, and circular wait. For example, P1 holds R1 and needs R2, while P2 holds R2 and needs R1, so both wait forever. Deadlock can be handled using prevention, avoidance (Banker’s algorithm), or detection and recovery.

### How Does Deadlock Occur in OS?

A process in an operating system typically uses resources in the following sequence:

- Request a resource
- Use the resource
- Release the resource

Deadlock arises when processes hold some resources while waiting for others.

Example:

- Process P1 holds Resource R1 and requests R2.
- Process P2 holds Resource R2 and requests R1. Neither process can proceed causing a deadlock.

![d](images/d.webp)

### Examples of Deadlock

There are several examples of deadlock. Some of them are mentioned below.

1. The system has 2 tape drives. P0 and P1 each hold one tape drive and each needs another one.

2. Semaphores A and B, initialized to 1, P0, and P1 are in deadlock as follows:

- P0 executes wait(A) and preempts.
- P1 executes wait(B).
- Now P0 and P1 enter in deadlock.

| P0 Action | P1 Action |
| --- | --- |
| wait(A) | wait(B) |
| wait(B) | wait(A) |

3. Assume the space is available for allocation of 200K bytes, and the following sequence of events occurs.

| P0 | P1 |
| --- | --- |
| Request 80KB; | Request 70KB; |
| Request 60KB; | Request 80KB; |

Request 80KB;

Request 70KB;

Request 60KB;

Request 80KB;

Deadlock occurs if both processes progress to their second request.

## Necessary Conditions for Deadlock in OS

Deadlock can arise if the following four conditions hold simultaneously (Necessary Conditions)

1. Mutual Exclusion: Only one process can use a resource at any given time i.e. the resources are non-sharable.
2. Hold and Wait: A process is holding at least one resource at a time and is waiting to acquire other resources held by some other process.
3. No Preemption: A resource cannot be taken from a process unless the process releases the resource.
4. Circular Wait: set of processes are waiting for each other in a circular fashion. For example, imagine four processes P1, P2, P3, and P4 and four resources R1, R2, R3, and R4.The above image demonstrates a circular wait deadlock, here's how:

![Circular wait example](images/circular-wait-example.png)

- P1 is holding R1 and waiting for R2 (which is held by P2).
- P2 is holding R2 and waiting for R3 (which is held by P3).
- P3 is holding R3 and waiting for R4 (which is held by P4).
- P4 is holding R4 and waiting for R1 (which is held by P1).