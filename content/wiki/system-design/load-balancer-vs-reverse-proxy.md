---
title: Load Balancer vs Reverse Proxy — Infrastructure Component Comparison
type: synthesis
tags: [systems, infrastructure]
status: draft
created: 2026-05-15
updated: 2026-05-15
---

## What's Being Compared

Load balancers and reverse proxies are both network intermediaries that sit between clients and servers, but they serve different primary purposes. Load balancers distribute traffic across multiple servers; reverse proxies provide a unified interface to backend services. Understanding when to use which — or both — is essential for system architecture.

## The Core Tension

The fundamental distinction is whether you have multiple servers doing the same thing (load balancer territory) or whether you need to abstract, protect, and augment a backend (reverse proxy territory). In practice, tools like Nginx and HAProxy blur this line by supporting both roles.

## Comparison

| Dimension | [[layer4-load-balancing|Layer 4 Load Balancing]] / [[layer7-load-balancing|Layer 7 Load Balancing]] | [[reverse-proxy-pattern|Reverse Proxy]] |
|-----------|----------------|---------------|
| Primary purpose | Distribute load across multiple servers | Centralize and protect backend services |
| When needed | Multiple servers serving same function | Even a single server benefits |
| Traffic distribution | Yes — random, round-robin, least-loaded | Not primary focus |
| SSL termination | Supported | Supported |
| Caching | Not primary focus | Supported |
| Compression | Not primary focus | Supported |
| Static content serving | No | Yes |
| Single point of failure | Yes — requires multiple LBs | Yes — requires multiple RPs |
| Examples | HAProxy (LB mode), AWS ELB | Nginx, HAProxy (reverse proxy mode) |

## When to Choose Load Balancer

- You have multiple application servers that need traffic distributed among them
- You need health checks to route away from failing servers
- You need session persistence (sticky sessions)
- You need to support horizontal scaling of stateless services

## When to Choose Reverse Proxy

- You have only one application server but want SSL termination, caching, or compression
- You want to hide backend server details from clients
- You need to serve static content directly without hitting the app server
- You want to compress responses before sending to clients

## The Insight

Nginx and HAProxy can act as **both**, and in production they often do. A typical setup: reverse proxy (Nginx) terminates SSL, serves static files, and reverse-proxies API calls to a set of application servers behind a load balancer (HAProxy) that distributes requests. The lines blur because a Layer 7 load balancer IS a reverse proxy by function — it terminates connections, inspects content, and forwards to backends.

## Connections

- [[layer4-load-balancing|Layer 4 Load Balancing]] — transport-level LB compared in this analysis
- [[layer7-load-balancing|Layer 7 Load Balancing]] — application-level LB, often same as reverse proxy
- [[reverse-proxy-pattern|Reverse Proxy]] — the other side of this comparison
- [[horizontal-scaling|Horizontal Scaling]] — LB enables horizontal scaling
- [[dns-system-design|DNS in System Design]] — DNS can direct traffic to load balancers
