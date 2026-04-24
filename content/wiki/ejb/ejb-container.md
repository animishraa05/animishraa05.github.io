---
concept: EJB Container
aliases: [EJB Server]
tags: [dev, ejb, architecture]
created: 2026-04-11
updated: 2026-04-11
---

# EJB Container

## The Problem

How do you provide middleware services (security, transactions, concurrency) to enterprise beans without requiring developers to write that infrastructure code?

## Core Idea

The EJB container is the runtime environment that manages enterprise beans. It intercepts all client calls and provides middleware services transparently—developers focus on business logic while the container handles everything else.

## How It Works

- Container sits between client and bean
- All client requests go through the container (proxy pattern)
- Container handles: security, transactions, concurrency, lifecycle, persistence
- Container creates, manages, and destroys bean instances
- Vendor implements the container (e.g., JBoss, WebSphere, WebLogic)

## Key Properties

- Manages bean lifecycle (creation, passivation, activation, removal)
- Provides declarative transaction management
- Provides security (authentication/authorization)
- Manages resource pooling (especially for stateless beans)
- Generates EJB objects and home objects

## Connections

- Builds into: [[session-bean|Session Bean]], [[entity-bean|Entity Bean]]
- Related: [[instance-pooling|Instance Pooling]], [[ejb-lifecycle-stateless|Stateless Lifecycle]], [[ejb-lifecycle-stateful|Stateful Lifecycle]]

## Edge Cases & Gotchas

- Container behavior is vendor-specific
- Some features may not be configurable at bean level
- Performance overhead of container interception

## Sources

- [[ejb-source-summary|EJB Source]]
