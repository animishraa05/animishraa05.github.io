---
title: "Operating system based Virtualization"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Operating system based Virtualization
Operating System-based Virtualization is also known as Containerization. It allows multiple isolated user-space instances called containers to run on a single operating system (OS) kernel.

![1](images/1.webp)

> Note: Unlike traditional virtualization, where each VM requires its own OS, OS-based virtualization allows the sharing of the same OS while providing separate environments for running applications.

Note: Unlike traditional virtualization, where each VM requires its own OS, OS-based virtualization allows the sharing of the same OS while providing separate environments for running applications.

## Traditional Virtualization Architecture (Using VMs)

- Each Virtual Machine (VM) operates as an isolated environment, having its own OS.
- This results in higher resource consumption (CPU, memory, storage).
- The Virtual Machine Management layer is responsible for:

![Components-of-Virtualization-Architecture-(1)](images/components-of-virtualization-architecture-1.webp)

> Managing and overseeing virtual machines, Proper resource allocation (CPU, memory, storage) & Maintaining isolation between VMs.

Managing and overseeing virtual machines, Proper resource allocation (CPU, memory, storage) & Maintaining isolation between VMs.

- The Host Operating System (OS) runs above the physical hardware and provides the environment for the hypervisor.
- The Hypervisor: Manages VMs & Allocates resources from the physical hardware to the VMs.
- The Hardware (Virtualization Host) is the physical machine that provides necessary CPU, memory, storage and I/O to run the hypervisor and VMs.
- Multiple VMs run simultaneously on the same physical hardware.

## How OS-Based Virtualization Works

OS-Based Virtualization works as follows:

- The host OS kernel is shared among all containers, unlike full virtualization (e.g., VMs) where each VM has its own kernel.
- The kernel enforces isolation between containers using namespaces (for process, network, filesystem isolation) and cgroups (control groups) for resource allocation (CPU, memory, disk I/O, network).
- cgroups limit and prioritize resource usage (CPU, memory, disk, network) per container.
- The kernel ensures that a container cannot exceed its allocated resources (unless explicitly allowed).
- Namespaces prevent processes in one container from seeing or interfering with processes in another.
- Programs inside a container cannot access resources outside unless explicitly granted (e.g., mounted volumes, network ports).
- The overhead comes from kernel-level isolation mechanisms (namespaces, cgroups), but it’s minimal compared to full virtualization.

## Operating System Based Services

Some major operating system based services are mentioned below:

- Backup and Recovery: Host operating systems can be utilized to back up and restore virtual machines. Backup software tools can be used to ensure data safety and system recovery.
- Security Management: Host operating systems help manage the security of virtual machines. This includes configuring [[18_Firewalls|firewalls]], installing antivirus software and applying other essential security settings.
- [[integration|Integration]] with Directory Services: Host operating systems can be integrated with directory services like Active Directory, enabling centralized management of users and groups.

## Operating System Based Operations

Various major operations of Operating System Based Virtualization are described below:

1. Hardware capabilities can be employed such as the network connection and CPU.
2. Connected peripherals with which Host OS can interact such as a webcam, printer, keyboard or scanners.
3. Host OS can be used to read or write data in files, folders and network shares.

## Features of OS- Based Virtualization

- Resource isolation: Operating system based virtualization provides a high level of resource isolation which allows each container to have its own set of resources, including CPU, memory and I/O bandwidth.
- Lightweight: Containers are lighter compared to traditional virtual machines as they share the same host operating system. This results in faster startup and lower resource usage.
- Portability: Containers are highly portable. They can be easily moved from one environment to another without the need to modify the underlying application.
- Scalability: Containers can be easily scaled up or down based on the application requirements. This makes it easier for applications to be highly responsive to changes in demand.
- Security: Containers provide a high level of security by isolating the containerized application from the host operating system and other containers running on the same system.
- Reduced Overhead: Containers incur less overhead than traditional virtual machines as they do not need to emulate a full hardware environment.
- Easy Management: Containers are easy to manage as they can be started, stopped and monitored using simple commands.

## Pros of OS-Based Virtualization

- Resource Efficiency: Operating system based virtualization allows for greater resource efficiency as containers do not need to emulate a complete hardware environment, which reduces resource overhead.
- High Scalability: Containers can be quickly and easily scaled up or down depending on the demand, which makes it easy to respond to changes in the workload.
- Easy Management: Containers are easy to manage as they can be managed through simple commands, which makes it easy to deploy and maintain large numbers of containers.
- Reduced Costs: Operating system based virtualization can significantly reduce costs, as it requires fewer resources and infrastructure than traditional virtual machines.
- Faster Deployment: Containers can be deployed quickly, reducing the time required to launch new applications or update existing ones.
- Portability: Containers are highly portable, making it easy to move them from one environment to another without requiring changes to the underlying application.

## Cons of OS-Based Virtualization

- Security: Operating system based virtualization may pose security risks as containers share the same host operating system, which means that a security breach in one container could potentially affect all other containers running on the same system.
- Limited Isolation: Containers may not provide complete isolation between applications, which can lead to performance degradation or resource contention.
- Complexity: Operating system based virtualization can be complex to set up and manage, requiring specialized skills and knowledge.
- Dependency Issues: Containers may have dependency issues with other containers or the host operating system, which can lead to compatibility issues and hinder deployment.
- Limited Hardware Access: Containers may have limited access to hardware resources which can limit their ability to perform certain tasks or applications that require direct hardware access.

> Read related articles - Types of Server Virtualization and Hardware based Virtualization.

Read related articles - Types of Server Virtualization and Hardware based Virtualization.