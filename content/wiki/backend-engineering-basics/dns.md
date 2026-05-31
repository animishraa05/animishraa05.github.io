---
concept: DNS
aliases: [Domain Name System, domain resolution, DNS lookup]
tags: [networking, dns]
sources_count: 2
last_source: https.md
created: 2026-04-12
updated: 2026-04-30
---

# DNS (Domain Name System)

## The Problem

Humans can't remember IP addresses (142.250.183.46), but computers need them. Without DNS, we'd have to memorize strings of numbers for every website—a completely unusable internet.

## Core Idea

DNS is the phonebook of the internet. It translates human-readable domain names (google.com) into machine-readable IP addresses. When you type a URL, DNS servers look up the corresponding IP and direct your request there.

## How It Works

1. **Query**: Your browser asks a DNS resolver: "What's the IP for google.com?"
2. **Resolution**: The resolver checks its cache; if not found, it queries root servers, then TLD servers (.com), then authoritative nameservers
3. **Response**: The resolver returns the IP address (e.g., 142.250.183.46)
4. **Connection**: Your browser now connects to that IP address

This happens in milliseconds. DNS uses caching heavily—once resolved, subsequent requests don't need to go through the full lookup.

## Key Properties

- Hierarchical distributed database
- Caches results to speed up repeated lookups
- Multiple record types: A (IPv4), AAAA (IPv6), CNAME (alias), MX (mail), TXT
- Operates on UDP port 53 (typically)
- Anycast allows multiple servers to serve the same domain from different locations

## Connections
- **Built from:** [[ip-address|IP Address]] — DNS resolves to IP addresses
- **Builds into:** [[http|HTTP]] — HTTP requests need an IP, which DNS provides
- **Builds into:** [[dns-lookup|DNS Lookup]] — DNS lookup is the full resolution process
- **Related:** [[ports|Port]] — IP + port identifies the final destination
- **Related:** [[dns-cache|DNS Cache]] — caching speeds up DNS resolution
- **Related:** [[recursive-dns|Recursive DNS]] — does the heavy lifting for clients
- **Contrasts with:** [[circuit-switching|Circuit Switching]] — DNS is packet-based, not circuit-based

## Edge Cases & Gotchas

- DNS poisoning/caching attacks can redirect users to malicious sites
- DNS can be slow for first-time lookups—that's why browsers cache aggressively
- Changing DNS records can take time to propagate (TTL)
- Some networks block certain DNS queries

## Sources

- [[backend-engineering-basics-summary|Backend Engineering Basics]]