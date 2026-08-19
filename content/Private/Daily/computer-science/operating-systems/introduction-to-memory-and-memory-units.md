---
title: "Introduction to memory and memory units"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Introduction to memory and memory units
Memory is an essential component of a computer system, responsible for storing data and instructions needed for processing. It enables the CPU to execute programs efficiently and ensures smooth system operation.

- Memory Cell: Smallest unit storing 1 bit of data with a unique address.
- Word & Byte: A word is a group of bits; 1 byte = 8 bits.
- Capacity: Total number of bits a memory can hold.

![memory](Daily/computer-science/operating-systems/images/memory.webp)

## Classification of Memory

Memory is classified into primary and secondary types based on speed, accessibility, and volatility.

- Primary Memory: Directly accessible by the CPU; fast but limited in capacity.
- [[secondary-memory|Secondary Memory]]: Used for long-term storage; slower but larger in capacity.

![types_of_computer_memory_](images_types_of_computer_memory_.webp)

## RAM (Random Access Memory)

RAM is the computer’s main memory used for temporary storage of active programs and data. Data is lost when power is off. It provides fast CPU access, improving multitasking and performance.

![RAM](images_ram.webp)

### Types of RAM

- SRAM (Static RAM): Fast, used in cache, retains data while powered.
- DRAM (Dynamic RAM): Slower, needs periodic refresh; main memory. Includes SDRAM and DDR series.

```
Read more about this topic: Random Access Memory (RAM)
```

## ROM (Read-Only Memory)

ROM is non-volatile memory that stores essential instructions permanently. It holds system firmware and boot instructions.

![ROMFind-It](images_romfind-it.webp)

### Types of ROM

Following are types of ROM:

- MROM: Pre-programmed at manufacture
- PROM: User-programmable once
- EPROM: UV-erasable
- EEPROM: Electrically erasable
- Flash Memory: Fast, used in SSDs and USB drives

```
Read more about this topic: Read Only Memory (ROM)
```

## Secondary Memory

[[secondary-memory|Secondary memory]] provides long-term data storage and is not directly accessed by the CPU.

- Examples: HDD, SSD, optical discs (CD/DVD/Blu-ray), USB drives, flash cards, magnetic tapes, cloud storage.
- Characteristics: Non-volatile, slower, high capacity, used for storing operating systems, software, and user files.

```
Read more about this topic: Secondary Memory
```

## Differences Among RAM, ROM, and Secondary Memory

Following table shows major difference among three memory types:

| RAM | ROM | [[secondary-memory|Secondary Memory]] |
| --- | --- | --- |
| Volatile | Non-volatile | Non-volatile |
| Temporary workspace | Permanent instructions | Long-term storage |
| Fast | Moderate | Slow |
| Read/Write | Mostly Read-only | Read/Write |
| DRAM, SRAM | PROM, EPROM, EEPROM | HDD, SSD, USB |

## Conversions of Units

The following table shows the standard conversions between different units of digital memory:

| Name | Equal To |
| --- | --- |
| Bit | 1 Bit |
| Nibble | 4 Bits |
| Byte | 8 Bits |
| Kilobyte | 1024 Bytes |
| Megabyte | 1024 Kilobytes |
| Gigabyte | 1024 Megabytes |
| Terabyte | 1024 Gigabytes |
| Petabyte | 1024 Terabytes |
| Exabyte | 1024 Petabytes |
| Zettabyte | 1024 Exabytes |
| Yottabyte | 1024 Zettabytes |