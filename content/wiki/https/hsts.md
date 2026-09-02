---
concept: HSTS
aliases: [HTTP Strict Transport Security, HSTS check, security shortcut]
tags: [security, https]
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

Users might accidentally visit the HTTP version of a site instead of HTTPS, exposing them to downgrade attacks. Without HSTS, a man-in-the-middle could strip TLS and force a connection to use insecure HTTP.

## Core Idea

HTTP Strict Transport Security (HSTS) is a security policy that tells browsers to always use HTTPS for a domain, never allowing HTTP fallback. It prevents protocol downgrade attacks and cookie hijacking.

## How It Works

1. **First Visit**: Server sends `Strict-Transport-Security` header with `max-age` value
2. **Browser Records**: Browser stores the HSTS policy for the specified duration
3. **Subsequent Visits**: Browser automatically upgrades HTTP requests to HTTPS
4. **Preload List**: Popular sites are hardcoded into browser HSTS preload lists

When a site is in the HSTS list, the browser:
- Never attempts HTTP for that domain
- Refuses to connect if certificate errors occur (no "proceed anyway" option)

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    User [label="User types google.com"];
    CheckHSTS [label="Check HSTS List"];
    UseHTTPS [label="Use HTTPS only"];
    UseHTTP [label="Try HTTP first"];
    Secure [label="Secure Connection"];
    
    User -> CheckHSTS;
    CheckHSTS -> UseHTTPS [label="In HSTS list"];
    CheckHSTS -> UseHTTP [label="Not in list"];
    UseHTTPS -> Secure;
    UseHTTP -> Secure [label="after TLS"];
}
```

## Key Properties

- Header: `Strict-Transport-Security: max-age=31536000; includeSubDomains`
- Prevents SSL stripping man-in-the-middle attacks
- Browsers refuse to bypass certificate errors for HSTS sites
- `includeSubDomains` extends policy to all subdomains

## Connections

- **Built from:** [[https|HTTPS]] — HSTS enforces HTTPS usage
- **Contrasts with:** [[http|HTTP]] — HSTS explicitly prevents HTTP fallback
- **Related:** [[tls-handshake|TLS Handshake]] — HSTS ensures TLS is always used
- **Related:** [[url-parsing|URL Parsing]] — HSTS check happens after URL is parsed

## Edge Cases & Gotchas

- First visit before HSTS is set is still vulnerable (use preload list)
- Max-age expiry requires re-visit to refresh policy
- `includeSubDomains` can break subdomains not ready for HTTPS
- Cannot be disabled by user even if site has issues (must wait for expiry)