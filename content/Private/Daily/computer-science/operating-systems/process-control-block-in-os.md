---
title: "Process Control Block in OS"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Process Control Block in OS
A Process Control Block (PCB) is a data structure used by the operating system to keep track of process information and manage execution. It helps the OS monitor and control process execution

- Each process is given a unique Process ID (PID) for identification.
- The PCB stores details such as process state, program counter, stack pointer, open files, and scheduling info.
- During a state transition, the OS updates the PCB with the latest execution data.
- It also includes register values, CPU quantum, and process priority.
- The Process Table is an array of PCBs that maintains information for all active processes.

> The Process Control Block (PCB) is stored as a par of OS so that normal users can't access. This is because it holds important information about the process. Some operating systems place the PCB at the start of the kernel stack for the process, as this is a safe and secure spot.

The Process Control Block (PCB) is stored as a par of OS so that normal users can't access. This is because it holds important information about the process. Some operating systems place the PCB at the start of the kernel stack for the process, as this is a safe and secure spot.

![frame_16](Daily/computer-science/operating-systems/images/frame_16.webp)

### Terminologies used in Process Control Block

- Process state: Stores whether the process is running, waiting, ready, or terminated
- Process number Or PID: Every process is assigned a unique id known as process ID or PID.
- Program counter: Program Counter stores the address of the next instruction that is to be executed for the process.
- Register: Registers in the PCB, it is a data structure. When a processes is running and it's time slice expires, the current value of process specific registers would be stored in the PCB and the process would be swapped out. When the process is scheduled to be run, the register values is read from the PCB and written to the CPU registers. This is the main purpose of the registers in the PCB.
- Memory limits: This field contains the information about memory management system used by the operating system. This may include page tables, segment tables, etc.
- List of Open files: This information includes the list of files opened for a process.

![frame_17](images_frame_17.webp)

### Applications

- Helps the operating system schedule processes and allocate CPU resources efficiently.
- Enables efficient resource utilization and sharing by providing detailed resource-usage information.
- Supports context switching through stored CPU registers and stack pointer information.
- Assists in process synchronization by keeping track of waiting states and required resources.
- Tracks process states and resource usage to determine which process should be executed next.