---
concept: Spring Security Authentication
aliases: [Authentication Provider, UserDetailsService, Role-Based Authentication]
tags: [dev, security]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Applications need to verify user identities and control access based on roles. Hard-coded authentication logic is inflexible, insecure, and doesn't integrate with standard identity providers. Developers need a pluggable authentication system that supports multiple strategies.

## Core Idea

Spring Security Authentication verifies user identity via configurable `AuthenticationProvider` implementations. The `UserDetailsService` interface loads user data (username, password hash, roles) from any backend. Role-based authorization restricts access to specific endpoints or methods based on granted authorities.

## How It Works

1. **Authentication request**: User submits credentials (username/password, token, certificate)
2. **AuthenticationProvider chain**: Each provider checks if it can handle the authentication type — first match wins
3. **UserDetailsService**: Loads user from database: `loadUserByUsername(String username) → UserDetails`
4. **Password verification**: `PasswordEncoder.matches(rawPassword, encodedPassword)` — should be BCrypt, not plain text
5. **GrantedAuthority**: User roles returned as `GrantedAuthority` objects (prefix `ROLE_` for role-checking)
6. **SecurityContextHolder**: `SecurityContextHolder.getContext().setAuthentication(auth)` — stored in ThreadLocal
7. **Role-based access**: `@PreAuthorize("hasRole('ADMIN')")` or `hasAuthority('WRITE_PRIVILEGE')`

## Visual Explanation

```dot
digraph auth_flow {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  LOGIN [label="User submits\username/password"]
  FILTER [label="Authentication Filter\n(e.g., UsernamePasswordAuthFilter)"]
  PROVIDER [label="AuthenticationProvider\n(chain of providers)" fillcolor="#ffe5cc]
  UDS [label="UserDetailsService\n(load from DB)"]
  ENC [label="PasswordEncoder\n(BCrypt match)"]
  CTX [label="SecurityContextHolder\n(ThreadLocal)"]
  ROLE [label="Role Check\n@PreAuthorize\n(hasRole('ADMIN'))"]
  ACCESS [label="Access\nGranted / Denied"]

  LOGIN -> FILTER
  FILTER -> PROVIDER
  PROVIDER -> UDS
  UDS -> ENC
  ENC -> PROVIDER
  PROVIDER -> CTX [label="store auth"]
  CTX -> ROLE
  ROLE -> ACCESS
}
```

## Key Properties

- **Multiple providers**: DAO, LDAP, OAuth2, remember-me, JWT — configured as a provider chain
- **UserDetailsService**: Core interface for loading users from any data source (JDBC, JPA, Mongo)
- **PasswordEncoder**: Never store plain-text passwords; BCrypt, SCrypt, Argon2 recommended
- **Role hierarchy**: `ROLE_ADMIN > ROLE_USER` — admin inherits user permissions
- **Remember-me**: Persistent token-based authentication across browser sessions
- **Pre-authentication**: For environments where authentication happens upstream (e.g., SSO, X.509 certs)

## Connections

- **Built from:** [[spring-security|Spring Security]] — Authentication is a core component of Spring Security
- **Related:** [[spring-security-csrf-jwt|Spring Security CSRF and JWT]] — JWT is an alternative authentication mechanism
- **Related:** [[jaas|JAAS]] — JAAS is Java's standard auth; Spring Security abstracts and improves it
- **Contrasts with:** [[session-authentication|Session Authentication]] — Session auth stores state on server; JWT is self-contained
- **Builds into:** [[jwt-authentication|JWT Authentication]] — JWT can be used as a Spring Security authentication provider

## Edge Cases & Gotchas

- **PasswordEncoder upgrade**: Migrating from MD5/SHA to BCrypt requires supporting both encoders simultaneously during transition
- **UserDetailsService caching**: Without caching, every request to check auth triggers a database load; use caching layer
- **ROLE_ prefix**: `hasRole('ADMIN')` automatically checks for `ROLE_ADMIN`; `hasAuthority('ADMIN')` checks for exact string
- **ThreadLocal cleanup**: SecurityContextHolder is ThreadLocal — in async processing, the context doesn't propagate automatically
- **Blank passwords**: `PasswordEncoder` should throw exception for blank/null passwords, not silently accept