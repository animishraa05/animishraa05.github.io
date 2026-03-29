---
title: "Process in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Process in Operating System
A process is a program in execution. When we write source code in C or C++ and compile it, the compiler generates an executable binary file. This executable file is called a program. When the program is loaded into memory and executed, it becomes a process

- A process is an 'active' entity instead of a program, which is considered a 'passive' entity.
- A single program can create many processes when run multiple times; for example, when we open a .exe or binary file multiple times, multiple instances begin (multiple processes are created). .

## How Does a Process Look Like in Memory?

A process in memory is divided into several distinct sections, each serving a different purpose. Here's how a process typically looks in memory.

![Process_look](images/process_look.png)

- Text Section: A text or code segment contains executable instructions. It is typically a read only section
- Stack: The stack contains temporary data, such as function parameters, returns addresses, and local variables.
- Data Section: Contains the global variable.
- Heap Section: Dynamically memory allocated to process during its run time.

## Attributes of a Process

A process has several important attributes that help the operating system manage and control it. These attributes are stored in a structure called the Process Control Block (PCB) (sometimes called a task control block). The PCB keeps all the key information about the process, including:

1. Process ID (PID): A unique number assigned to each process so the operating system can identify it.
2. Process State: This shows the current status of the process, like whether it is running, waiting, or ready to execute.
3. Priority and other CPU Scheduling Information: Data that helps the operating system decide which process should run next, like priority levels and pointers to scheduling queues.
4. I/O Information: Information about input/output devices the process is using.
5. File Descriptors: Information about open files and network connections.
6. Accounting Information: Tracks how long the process has run, the amount of CPU time used, and other resource usage data.
7. Memory Management Information: Details about the memory space allocated to the process, including where it is loaded in memory and the structure of its memory layout (stack, heap, etc.).

These attributes in the PCB help the operating system control, schedule, and manage each process effectively.

### Next Read:

- States of Process
- Process Control Block
- Process Table
- CPU Scheduling Criteria
- Process Schedulers in OS