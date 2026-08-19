---
title: "Preemptive and Non-Preemptive Scheduling"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Preemptive and Non-Preemptive Scheduling
[[cpu-scheduling-in-operating-systems|CPU scheduling in operating systems]] is the method of selecting which process in the ready queue will execute on the CPU next. It aims to utilise the processor efficiently while minimising waiting and response times. By determining an optimal execution order, CPU scheduling enhances overall system performance, supports smooth multitasking, and improves the user experience.

Scheduling can be broadly classified into two types: Preemptive and Non-Preemptive.

![preemptive_scheduling_vs_non_preemptive_scheduling](images_preemptive_scheduling_vs_non_preemptive_scheduling.webp)

> Preemptive Scheduling: After P1 goes for I/O, P2 comes into the CPU and utilizes it.Non-Preemptive Scheduling: After P1 goes for I/O, the CPU remains idle until P1 finishes I/O and comes back.

- Preemptive Scheduling: After P1 goes for I/O, P2 comes into the CPU and utilizes it.
- Non-Preemptive Scheduling: After P1 goes for I/O, the CPU remains idle until P1 finishes I/O and comes back.

## Preemptive Scheduling

In preemptive scheduling, the operating system can interrupt a running process to allocate the CPU to another process usually due to priority rules or time-sharing policies. A process may be moved from Running → Ready state before it finishes.

> In the following example P2 is preempted at time 1 due to arrival of a higher priority process.

In the following example P2 is preempted at time 1 due to arrival of a higher priority process.

![Preemptive Scheduling](images_preemptive-scheduling.png)

Examples:

> Round RobinShortest Remaining Time First (SRTF)Priority Scheduling (preemptive version)

- Round Robin
- Shortest Remaining Time First (SRTF)
- Priority Scheduling (preemptive version)

### Advantages

- Prevents one process from monopolizing CPU
- Better average response time in multi-user systems
- Widely used in modern OS (Windows, Linux, macOS)

### Disadvantages

- More complex to implement
- Higher overhead from context switching
- Can cause starvation of low-priority processes
- Risk of concurrency issues if preempted during shared resource access

## Non-Preemptive Scheduling

In non-preemptive scheduling, once a process starts using the CPU, it runs until it finishes or moves to a waiting state. The OS cannot forcibly take away the CPU.

> Below is the table and Gantt Chart according to the First Come First Serve (FCFS) Algorithm: We can notice that every process finishes execution once it gets CPU.

Below is the table and Gantt Chart according to the First Come First Serve (FCFS) Algorithm: We can notice that every process finishes execution once it gets CPU.

![Non Preemptive Scheduling](images_non-preemptive-scheduling.png)

Examples:

> First Come First Serve (FCFS)Shortest Job First (SJF)Priority Scheduling (non-preemptive version)

- First Come First Serve (FCFS)
- Shortest Job First (SJF)
- Priority Scheduling (non-preemptive version)

### Advantages

- It is easy to implement in an operating system. It was used in Windows 3.11 and early macOS.
- It has a minimal scheduling burden.
- Less computational resources are used.

### Disadvantages

- It is open to denial of service attack. A malicious process can take CPU forever.
- Since we cannot implement round robin, the average response time becomes less.

## Preemptive vs. Non-Preemptive Scheduling

| Preemptive Scheduling | Non-Preemptive Scheduling |
| --- | --- |
| In this resources(CPU Cycle) are allocated to a process for a limited time. | Once resources(CPU Cycle) are allocated to a process, the process holds it till it completes its burst time or switches to waiting state |
| Process can be interrupted in between. | Process can not be interrupted until it terminates itself or its time is up |
| If a process having high priority frequently arrives in the ready queue, a low priority process may starve | If a process with a long burst time is running CPU, then later coming process with less CPU burst time may starve |
| It has overheads of scheduling the processes | It does not have overheads |
| Average process response time is less | Average process response time is high |
| Decisions are made by the scheduler and are based on priority and time slice allocation | Decisions are made by the process itself and the OS just follows the process's instructions |
| More as a process might be preempted when it was accessing a shared resource. | Less as a process is never preempted. |
| Examples of preemptive scheduling are Round Robin and Shortest Remaining Time First | Examples of non-preemptive scheduling are First Come First Serve and Shortest Job First |

More as a process might be preempted when it was accessing a shared resource.

Less as a process is never preempted.