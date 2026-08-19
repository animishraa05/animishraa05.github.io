---
title: CORS
concept: true
aliases: [Cross-Origin Resource Sharing]
tags: [networking, http]
sources_count: 1
last_source: understanding-http-for-backend-engineers
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Browsers enforce the Same-Origin Policy by default—scripts on domain A cannot access resources on domain B. This protects users from malicious cross-site requests, but blocks legitimate API calls between domains.

## Core Idea

CORS (Cross-Origin Resource Sharing) is a mechanism that lets servers explicitly declare which domains (origins) can access their resources and under what conditions.

## How It Works

### Simple Request Flow

For simple requests (GET/POST/HEAD with standard headers):

1. Client sends request with `Origin` header
2. Server checks policy, responds with `Access-Control-Allow-Origin`
3. Browser allows/blocks response based on header

### Pre-flight Request Flow

For non-simple requests (PUT, DELETE, custom headers, non-standard Content-Type):

1. Browser sends OPTIONS request first (pre-flight)
2. Server responds with allowed methods, headers, and origins
3. Browser caches this (via `Access-Control-Max-Age`)
4. Then sends actual request

### Key Headers

| Header                         | Purpose                           |
| ------------------------------ | --------------------------------- |
| `Origin`                       | Client's domain (sent by browser) |
| `Access-Control-Allow-Origin`  | Allowed origins (server)          |
| `Access-Control-Allow-Methods` | Allowed methods (server)          |
| `Access-Control-Allow-Headers` | Allowed headers (server)          |
| `Access-Control-Max-Age`       | Cache duration for pre-flight     |

```java
@Configuration
public class CorsConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedOrigins("http://localhost:5173")
            .allowedMethods("GET", "POST", "PUT", "DELETE")
            .allowedHeaders("*")
            .allowCredentials(true);
    }
}
```

## Key Properties

- Server controls access—not the client
- Pre-flight caching reduces overhead
- Credentials require specific origin (not '\*')

## Connections

- **Related to:** [[http-headers|HTTP Headers]] (uses headers for negotiation: Access-Control-Allow-Origin)
- **Builds on:** [[http-methods|HTTP Methods]] (OPTIONS is the pre-flight method)
- **Related to:** HTTP Status Codes (401, 403 errors appear in CORS failures)
- **Related to:** Statelessness (CORS requests must include all auth per request)

## Edge Cases & Gotchas

- CORS errors in browser console ≠ server error; request reached server
- Preflight required for PUT, DELETE, PATCH methods
- Authorization header triggers pre-flight (custom header)
- Misconfiguration appears as "blocked by CORS policy"

## Sources

- [[understanding-http-for-backend-engineers-summary|Understanding HTTP for Backend Engineers]]
