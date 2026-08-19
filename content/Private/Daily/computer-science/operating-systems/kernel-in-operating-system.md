---
title: "Kernel in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Kernel in Operating System
A kernel is the core part of an operating system. It acts as a bridge between software applications and the hardware of a computer.

- The kernel manages system resources, such as the CPU, memory and devices, ensuring everything works together smoothly and efficiently.
- It handles tasks like running programs, accessing files and connecting to devices like printers and keyboards.
- An Operating System includes the kernel as its core, but also provides a user interface, file system management, network services and various utility applications that allow users to interact with the system

![kernel](images_kernel.webp)

- Facilitates communication between hardware and user applications.
- Ensures efficient and secure multitasking.
- Manages system stability and prevents unauthorized resource access.

## Types of Kernel

The following are different types of kernels.

- Monolithic kernel: all OS services run in kernel space → fast, but less fault-isolation. Examples are Unix, Linux, Open VMS, XTS-400 etc.
- Microkernel: minimal kernel functionality; most services moved to user space → better reliability, but more overhead. Examples are Minix 3 and Mach (true microkernel versions like Mach 3.0),
- Hybrid kernel: mixes monolithic + microkernel ideas; some services in kernel for speed, others isolated for safety. Examples are Windows NT family (Windows 2000, XP, Vista, 7, 8, 10 etc.), macOS / XNU, ReactOS and Haiku OS
- Nanokernel: extremely minimal kernel, providing only basic hardware abstraction; everything else outside. Examples are Nemesis and MIT Exokernel projects like XOK, Aegis
- Exokernel: separates protection vs. management; gives apps direct control over hardware abstractions so apps decide what abstractions to build.

## Functions of Kernel

The kernel is responsible for various critical functions that ensure the smooth operation of the computer system. These functions include:

![Function-Of-Kernel](images_function-of-kernel.webp)

1. Process Management : Scheduling and execution of processes.
2. Memory Management : Allocation and deallocation of memory space, managing virtual memory, handling memory protection and sharing.
3. Device Management : Managing input/output devices, providing a unified interface for hardware devices and handling device driver communication.
4. File System Management : Managing file operations and providing a file system interface to applications.
5. Resource Management : Managing system resources (CPU time, disk space, network bandwidth). Mainly allocating and deallocating resources as needed.
6. Security and Access Control : Enforcing access control policies like user permissions and authentication.
7. Inter-Process Communication : Facilitating communication between processes by providing mechanisms like message passing and shared memory.

## Working of Kernel

- The kernel is the first part of the OS loaded into memory during boot, and it stays resident while the system is running.
- It operates in a privileged mode (kernel mode), separate from user mode for applications; user apps can’t directly access hardware or critical resources.
- Applications make requests to the kernel via system calls (or software interrupts). The kernel handles these by switching from user mode to kernel mode.
- Kernel executes the requested operation (e.g. file I/O, process creation, memory allocation).
- On completion, kernel returns result (or error) to user space.
- Kernel does context switching as needed (scheduler picks next process/thread) to allow multitasking.