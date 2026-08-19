*various phases through which the execution of process happens throughout its life.*

Major states are
- new - a state when newly created . start point where the process is not in RAM, PID is created, memory is allocated.
- running- here the scheduler selects processes to run. A process in which the instruction get executed by CPU. here context switching happens as there are multiple programs wanting to execute. **from here processes can either go in terminated state or blocked state**.
- Ready - in the state where it is waiting for execution by CPU and loaded in the memory. the processes are here in the READY QUEUE.
- blocked(waiting) - where process is waiting for an event or IO operation to complete. here the processes which are IO bound come.
- terminated- process completing their cycles.
- swapout
### Process control block
*A data structure maintained by operating system to store all the information related to process 

# First Understand the Problem

Suppose your computer is running:

- Chrome
- VS Code
- Spotify
- Terminal

Question:

How does OS remember:

> Which process was running?

> Which process should run next?

> Where did a process stop?

> How much memory does each process have?

Imagine CPU says:

> “I paused Chrome. But now I forgot where Chrome stopped.”

Disaster.

Chrome would restart from beginning every time.

So OS needs a way to remember:

> Everything about every running process.

This memory record is called:

> **PCB (Process Control Block)***


# Where is PCB Stored?

PCB is stored in:

> **Kernel Space (Main Memory/RAM)**

Why?

Because OS frequently needs it for:

- scheduling
- process switching
- memory management

It must be quickly accessible.

---

# When is PCB Created?

Very important question.

PCB gets created:

> **When process enters New State**

Meaning:

When process is created,

OS automatically creates PCB.

And when process terminates:

> PCB gets deleted.

---

# What Information Does PCB Contain?

This is the most important part.

You must understand each field deeply.

---

# 1. Process ID (PID)

## Official Meaning

A unique number assigned to each process.

Example:

```
Chrome → PID 2051VS Code → PID 3010Spotify → PID 4102
```

Why needed?

Because OS must identify processes uniquely.

Like:

> Roll number in college.

---

# 2. Process State

Stores:

Current state of process.

Example:

```
ReadyRunningWaitingTerminated
```

Why needed?

OS must know:

> Which process currently doing what.

Example:

If process is:

```
WAITING
```

Scheduler will not give CPU.

---

# 3. Program Counter (PC)

Very important field.

Stores:

> Address of next instruction to execute.

Question:

Why needed?

Suppose Chrome paused.

When resumed:

OS must know:

> “Execution kaha se continue karna hai?”

Example:

```
1. a = 5;2. b = 10;3. c = a+b;
```

Suppose paused after line 2.

Program Counter remembers:

```
Next = line 3
```

Otherwise process restarts.

---

# 4. CPU Registers

Stores temporary execution data.

Remember:

Registers are:

> Fast memory inside CPU.

During process switching:

OS saves register values into PCB.

Why?

Because process may resume later.

Without saving:

Calculations lost.

---

# 5. CPU Scheduling Information

Contains:

- priority
- queue info
- scheduling parameters

Example:

```
Priority = High
```

Scheduler uses this.

To decide:

> Who gets CPU first?

---

# 6. Memory Management Information

Stores:

- memory location
- base address
- limit registers
- page table

Meaning:

OS remembers:

> Process memory kaha hai?

Without this:

Memory chaos.

---

# 7. I/O Status Information

Stores:

- open files
- devices being used
- I/O requests

Example:

Chrome downloading file.

PCB records:

```
Disk access active
```

---

# 8. Accounting Information

Stores:

- CPU usage
- execution time
- limits

Used for:

Performance tracking.

Billing in servers/cloud.

---

# Structure of PCB

Important diagram for exams.

```
--------------------------------| Process ID (PID)             |--------------------------------| Process State                |--------------------------------| Program Counter              |--------------------------------| CPU Registers                |--------------------------------| Scheduling Information       |--------------------------------| Memory Information           |--------------------------------| I/O Status Information       |--------------------------------| Accounting Information       |--------------------------------
```

Understand the logic.

PCB contains:

> Everything OS needs to manage process.