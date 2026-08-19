---
title: URL to Rendering — Full Flow Analysis
type: deep-dive
tags: [networking, browser]
created: 2026-04-30
updated: 2026-04-30
---

## Framing

This synthesis traces the complete path from pressing a key to seeing pixels on screen. It integrates hardware, OS, network, and browser concepts into one coherent flow.

## The Complete Flow

```
Key Press → OS Interrupt → Browser Input
    ↓
URL Parsing → HSTS Check
    ↓
DNS Lookup (Browser → OS → Router → ISP → Root → TLD → Auth)
    ↓
ARP (IP → MAC)
    ↓
TCP Handshake (SYN → SYN-ACK → ACK)
    ↓
TLS Handshake (ClientHello → ServerHello → Key Exchange)
    ↓
HTTP Request (GET / HTTP/1.1 + Headers)
    ↓
HTTP Response (200 OK + HTML)
    ↓
Browser Rendering:
  HTML Parsing → DOM Tree
  CSS Parsing → CSSOM
  DOM + CSSOM → Render Tree
  Layout (position/size)
  Painting (pixels)
  Compositing (layers)
  GPU Rendering (screen)
```

## Layer-by-Layer Analysis

### Layer 1: Hardware (Keyboard)
- **[[keyboard-interrupt|Keyboard Interrupt]]**: Physical key press → scan code
- **[[os-interrupt-handler|OS Interrupt Handler]]**: Converts scan code to character
- **[[browser-autocomplete|Browser Autocomplete]]**: Local suggestions (no network)

### Layer 2: Browser (URL Processing)
- **[[url-parsing|URL Parsing]]**: Break into protocol, domain, path
- **[[hsts|HSTS]]**: Security check—force HTTPS if required

### Layer 3: Network (DNS + Connection)
- **[[dns-lookup|DNS Lookup]]**: Domain → IP resolution
  - **[[dns-cache|DNS Cache]]**: Browser → OS → Router → ISP caches
  - **[[recursive-dns|Recursive DNS]]**: Full hierarchy traversal
  - **[[dns-hierarchy|DNS Hierarchy]]**: Root → TLD → Authoritative
- **[[arp-protocol|ARP Protocol]]**: IP → MAC for local delivery
- **[[tcp-handshake|TCP Handshake]]**: Reliable connection (3-way)
- **[[tls-handshake|TLS Handshake]]**: Encrypted tunnel (for HTTPS)

### Layer 4: Application (HTTP)
- **[[http-request|HTTP Request]]**: GET/POST + headers + body
- **[[http-response|HTTP Response]]**: Status + headers + body (HTML)

### Layer 5: Rendering (Browser Engine)
- **[[html-parsing|HTML Parsing]]** → **[[dom-tree|DOM Tree]]**
- **[[css-parsing|CSS Parsing]]** → **[[cssom|CSSOM]]**
- **[[render-tree|Render Tree]]**: DOM + CSSOM (visible only)
- **[[layout|Layout]]**: Calculate positions and sizes
- **[[painting|Painting]]**: Rasterize to pixels
- **[[compositing|Compositing]]**: Combine layers
- **[[gpu-rendering|GPU Rendering]]**: Hardware acceleration

## Key Insights

1. **Each layer is independent**: Keyboard works without network; DNS works without HTTP; Rendering works without network
2. **Caching everywhere**: DNS caches at 4+ levels; browser caches HTML/CSS/JS
3. **Security is layered**: HSTS (app) + TLS (transport) + HTTPS (protocol)
4. **Rendering is parallel**: HTML parsing + CSS parsing happen somewhat independently
5. **GPU acceleration**: Only the final stages (compositing, paint) use GPU

## Contrasts

| Aspect | HTTP | HTTPS |
|--------|------|-------|
| Encryption | None | TLS (all data encrypted) |
| Port | 80 | 443 |
| Security | Vulnerable to MITM | Protects against eavesdropping |
| Performance | Faster (no handshake) | Slower (TLS handshake overhead) |

## Connections

This synthesis connects to ALL 29 concept pages in this ingestion, plus existing pages:
- **[[dns|DNS]]** (existing, updated)
- **[[tls-handshake|TLS Handshake]]** (existing, updated)
- **[[tcp-handshake|TCP Handshake]]** (existing, updated)
- **[[socket|Socket]]** (existing, updated)
- **[[https|HTTPS]]** (new concept page)

## Edge Cases

- **Packet loss**: **[[tcp-packet-drop|TCP Packet Drop]]** triggers retransmission
- **DNS failure**: Browser shows error page (DNS_PROBE_FINISHED_NXDOMAIN)
- **TLS error**: Certificate warnings, HSTS blocks override
- **HTML errors**: Parser auto-corrects malformed HTML
- **CSS errors**: Silently ignored (lenient parsing)
