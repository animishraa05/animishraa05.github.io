---
title: "Process Schedulers in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Process Schedulers in Operating System
Process scheduling is the activity of the process manager that handles the removal of the running process from the CPU and the selection of another process based on a particular strategy. Throughout its lifetime, a process moves between various scheduling queues, such as the ready queue, waiting queue or devices queue.

- Scheduling is important in operating systems with multiprogramming as multiple processes might be eligible for running at a time.
- One of the key responsibilities of an Operating System (OS) is to decide which programs will execute on the CPU.
- Process Schedulers are fundamental components of operating systems responsible for deciding the order in which processes are executed by the CPU. In simpler terms, they manage how the CPU allocates its time among multiple tasks or processes that are competing for its attention.

![seven_state](images_seven_state.webp)

## Process Schedulers

Process Schedulers are fundamental components of operating systems responsible for deciding the order in which processes are executed by the CPU. In simpler terms, they manage how the CPU allocates its time among multiple tasks or processes that are competing for its attention.

### 1. Long-Term Scheduler (Job Scheduler)

The Long-Term Scheduler is responsible for loading processes from disk into main memory so they can begin execution.

- Transfers processes from the Job Queue to the Ready Queue.
- Controls the degree of Multi-programming — the number of processes present in memory or ready state at any time.
- Carefully selects a balanced mix of I/O-bound and CPU-bound processes to ensure efficient system performance.
- Helps avoid a situation where either the CPU or I/O devices remain idle.
- In many modern time-sharing systems (such as Windows), a long-term scheduler may not exist; new processes are directly admitted to memory for short-term scheduling.
- It is the slowest among all schedulers, as it operates less frequently.

### 2. Short-Term Scheduler (CPU Scheduler)

The Short-Term Scheduler (STS) is responsible for selecting a process from the ready queue and assigning the CPU to it.

- Frequently selects the next process to execute from the ready state.
- Ensures no process suffers from starvation.
- Uses various CPU scheduling algorithms to decide process order.
- Maximizes CPU utilization by keeping the processor as busy as possible.
- Calls the dispatcher, which performs the actual context switch.
- It is the fastest scheduler, since it operates very frequently (often every few milliseconds).

> The dispatcher is responsible for loading the process selected by the Short-term scheduler on the CPU (Ready to Running State). Context switching is done by the dispatcher only. A dispatcher does the following work:

The dispatcher is responsible for loading the process selected by the Short-term scheduler on the CPU (Ready to Running State). Context switching is done by the dispatcher only. A dispatcher does the following work:

- Saving context (process control block) of previously running process if not finished.
- Switching system mode to user mode.
- Jumping to the proper location in the newly loaded program.

> Note: Time taken by dispatcher is called dispatch latency or process context switch time.

Note: Time taken by dispatcher is called dispatch latency or process context switch time.

![scheduling_queues](images_scheduling_queues.webp)

### 2.1 Dispatcher

The Dispatcher is a special program that takes over once the short-term scheduler selects a process. It transfers control of the CPU to the chosen process. The following are functions of it.

- Context Switching: Saves the state of the previously running process and restores the state of the new one.
- Mode Switching: Ensures correct transition into user mode from kernel mode.
- Program Control Transfer: Jumps to the correct starting point in the newly selected program.

Dispatcher Example : Using FCFS scheduling for processes P1 → P2 → P3 → P4:

- Scheduler selects P1 first.
- Dispatcher loads P1 onto the CPU.
- Next the scheduler selects P2, and the dispatcher assigns P2 to the CPU, and so on.

### Note

- The time taken by the dispatcher to perform context switching is called dispatch latency.

![dispatcher](images_dispatcher.webp)

### 3. Medium-Term Scheduler

The Medium-Term Scheduler (MTS) manages swapping, which temporarily moves processes between main memory and disk.

- Swaps processes out of memory when they are waiting (e.g., blocked for I/O) to reduce the degree of multiprogramming.
- Frees memory for other active processes.
- Swaps processes back into memory when they are ready to continue execution, allowing them to resume from where they left off.
- Helps maintain an effective mix of CPU-bound and I/O-bound processes.
- It operates faster than the long-term scheduler but slower than the short-term scheduler.

![mts](images_mts.webp)

## Some Other Schedulers

I/O Schedulers

- Manage order of read/write operations.
- Reduce I/O wait time and improve performance.
- Schedule I/O requests using algorithms like FCFS, RR, SCAN, C-SCAN.

Real-Time Schedulers

- Used in systems where tasks must meet deadlines.
- Ensure timely execution of critical tasks.
- Use algorithms like EDF and RM.

## Comparison Among Scheduler

| Long-Term Scheduler | Short-Term Scheduler | Medium-Term Scheduler |
| --- | --- | --- |
| It is a job scheduler | It is a CPU scheduler | It is a process-swapping scheduler |
| It is the slowest scheduler | It is the fastest scheduler | Its speed lies between long-term and short-term schedulers |
| It controls the degree of multiprogramming | It gives less control over the degree of multiprogramming | It reduces the degree of multiprogramming |
| It is barely present or nonexistent in time-sharing systems | It is essential for time-sharing systems | It is a component of time-sharing systems |
| It selects processes from the job pool and loads them into memory | It selects ready processes for execution by the CPU | It can re-introduce processes into memory and resume execution |

### Related Articles:

> ProcessContext Switching in Operating System

- Process
- Context Switching in Operating System