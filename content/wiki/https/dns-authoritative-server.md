---
concept: DNS Authoritative Server
aliases: [authoritative nameserver, authoritative DNS, master DNS]
tags: [networking, dns]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

After navigating root and TLD servers, you still don't have the IP address. Someone needs to hold the actual DNS records (A, AAAA, CNAME, etc.) for each domain—that's the authoritative server.

## Core Idea

The authoritative server is the final authority for a domain—it holds the actual DNS records (A, AAAA, MX, etc.) and returns the real IP address. This is the server operated by the domain owner or their DNS provider.

## How It Works

1. **Query from Resolver**: "What is the IP for google.com?"
2. **Lookup**: Authoritative server checks its zone file
3. **Response**: Returns the A record (IPv4) or AAAA record (IPv6)
   - Example: "google.com = 142.250.183.46"
4. **Done**: Resolver caches and returns IP to client

The domain owner configures records on their authoritative server (or via DNS provider like Cloudflare, AWS Route53).

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Resolver [label="Recursive Resolver"];
    Auth [label="Authoritative Server\n(google.com)"];
    Records [label="Zone File\nA: 142.250.183.46\nAAAA: 2404:6800:4007:80e::200e"];
    
    Resolver -> Auth [label="IP for google.com?"];
    Auth -> Records [label="lookup"];
    Records -> Auth [label="found"];
    Auth -> Resolver [label="142.250.183.46"];
}
```

## Key Properties

- Holds actual DNS records (A, AAAA, CNAME, MX, TXT, etc.)
- Domain owners configure records via their DNS provider
- Responds authoritatively—no further lookup needed
- Can be primary (master) or secondary (slave) for redundancy

## Connections

- **Built from:** [[dns-tld-server|DNS TLD Server]] — TLD points to authoritative server
- **Builds into:** [[dns-lookup|DNS Lookup]] — authoritative gives the final answer
- **Related:** [[dns-records|DNS Records]] — authoritative servers store these
- **Related:** [[dns-zone|DNS Zone]] — the configuration file holding records

## Edge Cases & Gotchas

- Misconfigured records cause site outages
- TTL affects how long resolvers cache the answer
- Secondary servers sync from primary (zone transfer)
- Anycast used by large providers for global coverage