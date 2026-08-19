---
title: "CPU Scheduling in Operating Systems"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# CPU Scheduling in Operating Systems
CPU scheduling is a process used by the operating system to decide which task or process gets to use the CPU at a particular time. This is important because a CPU can only handle one task at a time, but there are usually many tasks that need to be processed. The following are different purposes of a CPU scheduling time.

- Maximize the CPU utilization
- Minimize the response and waiting time of the process.

### What is the Need for a CPU Scheduling Algorithm?

CPU scheduling is the process of deciding which process will own the CPU to use while another process is suspended. The main function of CPU scheduling is to ensure that whenever the CPU remains idle, the OS has at least selected one of the processes available in the ready-to-use line.

### Terminologies Used in CPU Scheduling

- Arrival Time: The time at which the process arrives in the ready queue.
- Completion Time: The time at which the process completes its execution.
- Burst Time: Time required by a process for CPU execution.
- Turn Around Time: Time Difference between completion time and arrival time.

> Turn Around Time = Completion Time – Arrival Time

Turn Around Time = Completion Time – Arrival Time

- Waiting Time(W.T): Time Difference between turn around time and burst time.

> Waiting Time = Turn Around Time – Burst Time

Waiting Time = Turn Around Time – Burst Time

### Things to Take Care While Designing a CPU Scheduling Algorithm

Different CPU Scheduling algorithms have different structures and the choice of a particular algorithm depends on a variety of factors.

- CPU Utilization: The main purpose of any CPU algorithm is to keep the CPU as busy as possible. Theoretically, CPU usage can range from 0 to 100 but in a real-time system, it varies from 40 to 90 percent depending on the system load.
- Throughput: The average CPU performance is the number of processes performed and completed during each unit. This is called throughput. The output may vary depending on the length or duration of the processes.
- Turn Round Time: For a particular process, the important conditions are how long it takes to perform that process. The time elapsed from the time of process delivery to the time of completion is known as the conversion time. Conversion time is the amount of time spent waiting for memory access, waiting in line, using CPU and waiting for I/O.
- Waiting Time: The Scheduling algorithm does not affect the time required to complete the process once it has started performing. It only affects the waiting time of the process i.e. the time spent in the waiting process in the ready queue.
- Response Time: In a collaborative system, turn around time is not the best option. The process may produce something early and continue to computing the new results while the previous results are released to the user. Therefore another method is the time taken in the submission of the application process until the first response is issued. This measure is called response time.

### Different Types of CPU Scheduling Algorithms

There are mainly two types of scheduling methods:

- Preemptive Scheduling: Preemptive scheduling is used when a process switches from running state to ready state or from the waiting state to the ready state.
- Non-Preemptive Scheduling: Non-Preemptive scheduling is used when a process terminates , or when a process switches from running state to waiting state.

![CPU-Scheduling](images_cpu-scheduling.png)

Please refer Preemptive vs Non-Preemptive Scheduling for details.

### CPU Scheduling Algorithms

Let us now learn about these CPU scheduling algorithms in operating systems one by one:

- FCFS - First Come, First Serve
- SJF - Shortest Job First
- SRTF - Shortest Remaining Time First
- Round Robin
- Priority Scheduling
- HRRN - Highest Response Ratio Next
- Multiple Queue Scheduling
- Multilevel Feedback Queue Scheduling

### Comparison of CPU Scheduling Algorithms

Here is a brief comparison between different CPU scheduling algorithms:

| Algorithm | Allocation | Complexity | Average waiting time (AWT) | Preemption | Starvation | Performance |
| --- | --- | --- | --- | --- | --- | --- |
| FCFS | According to the arrival time of the processes, the CPU is allocated. | Simple and easy to implement | Large. | No | No | Slow performance |
| SJF | Based on the lowest CPU burst time (BT). | More complex than FCFS | Smaller than FCFS | No | Yes | Minimum Average Waiting Time |
| SRTF | Same as SJF the allocation of the CPU is based on the lowest CPU burst time (BT). But it is preemptive. | More complex than FCFS | Depending on some measures e.g., arrival time, process size, etc | Yes | Yes | The preference is given to the short jobs |
| RR | According to the order of the process arrives with fixed time quantum (TQ) | The complexity depends on Time Quantum size | Large as compared to SJF and Priority scheduling. | Yes | No | Each process has given a fairly fixed time |
| Priority Pre-emptive | According to the priority. The bigger priority task executes first | This type is less complex | Smaller than FCFS | Yes | Yes | Well performance but contain a starvation problem |
| Priority non-preemptive | According to the priority with monitoring the new incoming higher priority jobs | This type is less complex than Priority preemptive | Preemptive Smaller than FCFS | No | Yes | Most beneficial with batch systems |
| MLQ | According to the process that resides in the bigger queue priority | More complex than the priority scheduling algorithms | Smaller than FCFS | No | Yes | Good performance but contain a starvation problem |
| MFLQ | According to the process of a bigger priority queue. | It is the most Complex but its complexity rate depends on the TQ size | Smaller than all scheduling types in many cases | No | No | Good performance |

Slow performance

Yes

Minimum Average Waiting Time

Yes

Yes

The preference is given to the short jobs

Yes

Each process has given a fairly fixed time

Yes

Yes

Well performance but contain a starvation problem

Yes

Most beneficial with batch systems

Yes

Good performance but contain a starvation problem

Good performance

> Read Related Article - Starvation and Aging

Read Related Article - Starvation and Aging

## Questions for Practice

### Question: Which of the following is false about SJF?

S1: It causes minimum average waiting time

S2: It can cause starvation

(A) Only S1

(B) Only S2

(C) Both S1 and S2

(D) Neither S1 nor S2

Answer: (D) S1 is true SJF will always give minimum average waiting time. S2 is true SJF can cause starvation.

### Question: Consider the following table of arrival time and burst time for three processes P0, P1 and P2.

| Process | Arrival time | Burst Time |
| --- | --- | --- |
| P0 | 0 ms | 9 ms |
| P1 | 1 ms | 4 ms |
| P2 | 2 ms | 9 ms |

The pre-emptive shortest job first scheduling algorithm is used. Scheduling is carried out only at arrival or completion of processes. What is the average waiting time for the three processes?

(A) 5.0 ms

(B) 4.33 ms

(C) 6.33

(D) 7.33

Solution: (A)

Process P0 is allocated processor at 0 ms as there is no other process in the ready queue. P0 is preempted after 1 ms as P1 arrives at 1 ms and burst time for P1 is less than remaining time of P0. P1 runs for 4ms. P2 arrived at 2 ms but P1 continued as burst time of P2 is longer than P1. After P1 completes, P0 is scheduled again as the remaining time for P0 is less than the burst time of P2. P0 waits for 4 ms, P1 waits for 0 ms and P2 waits for 11 ms. So average waiting time is (0+4+11)/3 = 5.

### Question: Consider the following set of processes, with the arrival times and the CPU-burst times given in milliseconds.

| Process | Arrival time | Burst Time |
| --- | --- | --- |
| P1 | 0 ms | 5 ms |
| P2 | 1 ms | 3 ms |
| P3 | 2 ms | 3 ms |
| P4 | 4 ms | 1 ms |

What is the average turnaround time for these processes with the preemptive Shortest Remaining Processing Time First algorithm ?

(A) 5.50

(B) 5.75

(C) 6.00

(D) 6.25

Answer: (A)

Solution: The following is Gantt Chart of execution

| P1 | P2 | P4 | P3 | P1 |
| --- | --- | --- | --- | --- |
| 1 | 4 | 5 | 8 | 12 |

Turn Around Time = Completion Time – Arrival Time Avg Turn Around Time = (12 + 3 + 6+ 1)/4 = 5.50

### Question: An operating system uses the Shortest Remaining Time First (SRTF) process scheduling algorithm. Consider the arrival times and execution times for the following processes:

| Process | Burst Time | Arrival Time |
| --- | --- | --- |
| P1 | 20 ms | 0 ms |
| P2 | 25 ms | 15 ms |
| P3 | 10 ms | 30 ms |
| P4 | 15 ms | 45 ms |

### What is the total waiting time for process P2?

(A) 5

(B) 15

(C) 40

(D) 55

Answer (B)

Solution: At time 0, P1 is the only process, P1 runs for 15 time units. At time 15, P2 arrives, but P1 has the shortest remaining time. So P1 continues for 5 more time units. At time 20, P2 is the only process. So it runs for 10 time units At time 30, P3 is the shortest remaining time process. So it runs for 10 time units At time 40, P2 runs as it is the only process. P2 runs for 5 time units. At time 45, P3 arrives, but P2 has the shortest remaining time. So P2 continues for 10 more time units. P2 completes its execution at time 55.

Total waiting time for P2 = Completion time - (Arrival time + Execution time)= 55 - (15 + 25)= 15