---
title: "Memory Interleaving"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Memory Interleaving
Memory Interleaving is a technique used to increase the speed of memory access by splitting memory into multiple modules (banks) and accessing them in parallel.

- Instead of storing the entire block of data in a single module, memory addresses are distributed across multiple modules in a round-robin fashion.
- This allows the CPU to fetch the next instruction/data while the previous one is still being accessed, improving throughput.

### Need for Memory Interleaving

- CPU executes instructions much faster than memory can supply data (memory bottleneck problem).
- Without interleaving, CPU must wait for each memory access to complete.
- Interleaving ensures that while one module is busy, the CPU can access another, reducing wait time.

### Consecutive Word in a Module:

![](images/raw-1.png)

Explanation:

- Let us assume 16 Data's to be Transferred to the Four Module. Where Module 00 be Module 1, Module 01 be Module 2, Module 10 be Module 3 & Module 11 be Module 4. Also, 10, 20, 30....130 are the data to be transferred.
- From the figure above in Module 1, 10 [Data] is transferred then 20, 30 & finally, 40 which are the Data. That means the data are added consecutively in the Module till its max capacity.
- Most significant bit (MSB) provides the Address of the Module & the least significant bit (LSB) provides the address of the data in the module.
- For Example, to get 90 (Data) 1000 will be provided by the processor. This 10 will indicate that the data is in module 10 (module 3) & 00 is the address of 90 in Module 10 (module 3). So,

> Module 1 Contains Data : 10, 20, 30, 40Module 2 Contains Data : 50, 60, 70, 80Module 3 Contains Data : 90, 100, 110, 120Module 4 Contains Data : 130, 140, 150, 160

Module 1 Contains Data : 10, 20, 30, 40Module 2 Contains Data : 50, 60, 70, 80Module 3 Contains Data : 90, 100, 110, 120Module 4 Contains Data : 130, 140, 150, 160

### Consecutive Word in Consecutive Module:

![](images/raw-2.png)

Explanation:

- Now again we assume 16 Data's to be transferred to the Four Module. But Now the consecutive Data are added in Consecutive Module. That is, 10 [Data] is added in Module 1, 20 [Data] in Module 2 and So on.
- Least Significant Bit (LSB) provides the Address of the Module & Most significant bit (MSB) provides the address of the data in the module.
- For Example, to get 90 (Data) 1000 will be provided by the processor. This 00 will indicate that the data is in module 00 (module 1) & 10 is the address of 90 in Module 00 (module 1). That is,

> Module 1 Contains Data : 10, 50, 90, 130Module 2 Contains Data : 20, 60, 100, 140Module 3 Contains Data : 30, 70, 110, 150Module 4 Contains Data : 40, 80, 120, 160

Module 1 Contains Data : 10, 50, 90, 130Module 2 Contains Data : 20, 60, 100, 140Module 3 Contains Data : 30, 70, 110, 150Module 4 Contains Data : 40, 80, 120, 160

### Benefits of Memory Interleaving

- Higher Bandwidth: Multiple memory banks work in parallel, so more data can be transferred at once.y.
- Lower Latency: While one bank is busy, others get ready, reducing wait time.
- Better Performance: Together, higher bandwidth and lower latency make the system faster and more efficient, especially for heavy tasks and multitasking.