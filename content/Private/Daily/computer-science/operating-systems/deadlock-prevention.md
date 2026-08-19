---
title: "Deadlock Prevention"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Deadlock Prevention
Deadlock prevention is a strategy used in computer systems to ensure that different processes can run smoothly without getting stuck waiting for each other forever. Think of it like a traffic system where cars (processes) must move through intersections (resources) without getting into a gridlock.

As we have already discussed that deadlock can only happen if all four of the following conditions are met simultaneously:

- Mutual Exclusion
- Hold and Wait
- No Preemption
- Circular Wait

So we can prevent a Deadlock by eliminating any of the above four conditions. Let's look at how:

### 1. Eliminate Mutual Exclusion

- Some resources, like a printer, are inherently non-sharable, so this condition is difficult to break.
- However, sharable resources like read-only files can be accessed by multiple processes at the same time.
- For non-sharable resources, prevention through this method is not possible.

### 2. Eliminate Hold and Wait

Hold and wait is a condition in which a process holds one resource while simultaneously waiting for another resource that is being held by a different process. The process cannot continue until it gets all the required resources.

![HoldWait](images_holdwait.webp)

There are two ways to eliminate hold and wait:

- By eliminating wait: The process specifies the resources it requires in advance so that it does not have to wait for allocation after execution starts. For Example, Process1 declares in advance that it requires both Resource1 and Resource2.
- By eliminating hold: The process has to release all resources it is currently holding before making a new request. For Example: Process1 must release Resource2 and Resource3 before requesting Resource1.

### 3. Eliminate No Preemption

No preemption means resources can’t be taken away once allocated. To prevent this:

- Processes must release resources voluntarily: A process gives up resources once it finishes using them.
- Avoid partial allocation: If a process requests resources that are unavailable, it must release all currently held resources and wait until all required resources are free.

### 4. Eliminate Circular Wait

Circular wait happens when processes form a cycle, each waiting for a resource held by the next. To prevent this:

- Impose a strict ordering on resources.
- Assign each resource a unique number.
- Processes can only request resources in increasing order of their numbers.
- This prevents cycles, as no process can go backwards in numbering.