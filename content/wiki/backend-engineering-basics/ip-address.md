---
concept: IP Address
aliases: [IP, internet protocol address, IPv4, IPv6]
tags: [networking, addressing]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How do we uniquely identify a machine on a network? Without IP addresses, computers cannot send data to specific destinations—they wouldn't know where to deliver packets.

## Core Idea

An IP address is a numerical identifier assigned to each device connected to a computer network. It serves as both identification (which machine) and location (how to reach it). Humans use domain names; machines use IP addresses.

## How It Works

1. **Allocation**: Every device on a network gets a unique IP address—either dynamically assigned (DHCP) or statically configured
2. **Format**: IPv4 uses 32-bit addresses (e.g., 142.250.183.46), while IPv6 uses 128-bit addresses for larger networks
3. **Routing**: Network routers use IP addresses to forward packets toward their destination
4. **Translation**: DNS converts human-readable domain names (google.com) to IP addresses

When you type "google.com", DNS resolves it to an IP like 142.250.183.46. Your computer then sends packets to that address.

## Key Properties

- Unique identifier for each device on a network
- Used for routing packets to the correct destination
- Can be public (internet-accessible) or private (internal network only)
- Two versions: IPv4 (32-bit, ~4 billion addresses) and IPv6 (128-bit, vast address space)
- Can be static (fixed) or dynamic (changes)

## Connections

- **Built from:** [[packet-switching|Packet Switching]] — IP addresses are used to route packets
- **Builds into:** [[socket|Socket]] — a socket combines IP + port to identify a specific program
- **Related:** [[dns|DNS]] — translates domain names to IP addresses
- **Related:** [[ports|Port]] — works with IP to identify specific programs on a machine
- **Contrasts with:** MAC Address — layer 2 address, unique to network interface hardware

## Edge Cases & Gotchas

- A single machine can have multiple IP addresses (multiple network interfaces)
- Private IP addresses cannot be accessed directly from the internet ( NAT required)
- IP addresses can change (dynamic allocation)—that's why we use domain names
- IPv4 address exhaustion led to IPv6 adoption