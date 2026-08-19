---
title: "Starvation and Aging in Operating Systems"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Starvation and Aging in Operating Systems
Starvation (or indefinite blocking) occurs in priority scheduling when a low-priority process keeps waiting indefinitely because higher-priority processes continuously get the CPU.

- This problem arises in heavily loaded systems where resources are always occupied by higher-priority tasks, leaving some processes starved.
- To prevent this, operating systems use aging, a technique that gradually increases the priority of waiting processes, ensuring fair execution.

Let's analyze it with an example priority scheduling:

| Process | Burst Time | Priority |
| --- | --- | --- |
| P1 | 4 | 10 |
| P2 | 7 | 1 |
| P3 | 10 | 2 |

Process

Burst Time

Priority

Gantt Chart

| P1 | P3 | P2 |  |
| --- | --- | --- | --- |
| 0 | 4 | 14 | 21 |

As we see in the above example process has higher priority than other processes getting CPU earlier. We can think of a scenario in which only one process has very low priority (for example 127) and we are giving another process with high priority, this can lead to indefinitely waiting for the process for CPU which has priority, which leads to Starvation.

Causes of Starvation

1. Not Fair Scheduling: If there are always higher-priority processes available, then the lower-priority processes may never be allowed to run. Apart from priority, there can be other causes like a scheduling algorithm that randomly picks a process and somehow a victim process is always missed leading to starvation.
2. Limited Resources : Due to limitation of resources one or the other process has to wait.

## Aging - Solution to Starvation

Aging is a scheduling technique used to prevent starvation by gradually increasing the priority of processes waiting too long in the system.

- Ensures fairness, as long-waiting processes eventually get CPU time.
- Often combined with algorithms like priority scheduling or round-robin to balance short-term efficiency with long-term fairness.

For example, if priorities range from 127 (low) to 0 (high), a waiting process can move up one level every 15 minutes, ensuring even the lowest-priority process eventually gets executed.

![Aging](images_aging.jpg)