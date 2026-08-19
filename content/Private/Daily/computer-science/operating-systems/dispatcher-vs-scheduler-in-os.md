---
title: "Dispatcher vs Scheduler in OS"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Dispatcher vs Scheduler in OS
Multiple processes in a multitasking operating system, compete for CPU time. To manage this efficiently, the operating system uses two important components: the Scheduler and the Dispatcher.

> Note: Both work together to decide which process will run and how it will be executed by the CPU. Although they are interrelated, they perform distinct functions to ensure optimal CPU utilization and smooth process management.

Note: Both work together to decide which process will run and how it will be executed by the CPU. Although they are interrelated, they perform distinct functions to ensure optimal CPU utilization and smooth process management.

### Dispatcher

Once the Short Term Scheduler selects the next process to execute, the Dispatcher takes over. The Dispatcher is a small, specialized program that gives control of the CPU to the process chosen by the short-term scheduler. It performs the low-level work needed to actually start executing the selected process..

![frame_3189](images_frame_3189.webp)

### Scheduler

There are three main types of schedulers, each performing different tasks in process management:

- Long-Term (Job) Scheduler : Moves processes from [[secondary-memory|secondary memory]] (job pool) to main memory (ready queue).
- Medium-Term Scheduler : Suspends and resumes processes based on system status.
- Short-Term (CPU) Scheduler : Selects one of the ready processes in memory to execute next.

![frame_3190](images_frame_3190.webp)

### Difference Between Scheduler and Dispatcher

| Scheduler | Dispatcher |
| --- | --- |
| Decides which process should be executed next. | Transfers control of CPU to the process selected by the scheduler. |
| To select the process and determine execution order. | To start the execution of the selected process. |
| Long-term, Medium-term and Short-term. | No types; it’s a single module. |
| Works independently. | Dependent on the scheduler’s decision. |
| Uses algorithms like FCFS, SJF, RR, Priority, etc. | No specific algorithm used. |
| Negligible and occurs less frequently. | Time taken is known as Dispatch Latency. |
| Process selection and queue management. | Context switching, mode change and process start. |
| Works with the ready queue and dispatcher. | Works with CPU and the selected process. |
| Takes longer than the dispatcher. | Executes in a very short time. |

> Note: The scheduler is the one that determines what processes are executed and when, while the dispatcher is the one that swaps out those processes into the CPU.

Note: The scheduler is the one that determines what processes are executed and when, while the dispatcher is the one that swaps out those processes into the CPU.