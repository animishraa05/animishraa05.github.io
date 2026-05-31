---
source: EJB — Enterprise JavaBeans
source_path: sources/Ejb.md
ingested: 2026-04-11
tags: [dev, ejb]
---

# EJB Source Summary

## Concepts Extracted

This source covered **Chapter 4 (Session Beans)** and **Chapter 6 (Introduction to Entity Beans)** from an EJB textbook.

### Session Beans (Chapter 4)

- **Session Bean** — Business process objects that implement logic; non-persistent, short-lived
- **Stateful Session Bean** — Retains client state across multiple method calls; examples: shopping cart, bank teller
- **Stateless Session Bean** — Single method call conversation; supports instance pooling; examples: credit card verification, calculations
- **Passivation** — Serializing stateful bean to disk to save memory
- **Activation** — Restoring passivated bean to memory
- **Instance Pooling** — Pre-created beans shared among clients (stateless only)
- **EJB Lifecycle — Stateless** — Does Not Exist → Pool → Method Ready → Destroy
- **EJB Lifecycle — Stateful** — Does Not Exist → Ready → (Passivate/Activate) → Destroy

### Entity Beans (Chapter 6)

- **Entity Bean** — Persistent objects representing business data; has identity (primary key); survives server crashes
- **Object-Relational Mapping** — Mapping Java objects to database tables
- **Container-Managed Persistence (CMP)** — Container handles all DB operations automatically
- **Bean-Managed Persistence (BMP)** — Developer writes explicit JDBC code

### Architecture

- **EJB Container** — Runtime managing beans, providing middleware services

## Key Insights

1. Session beans = "Verbs" (actions/processes), Entity beans = "Nouns" (data/things)
2. Stateful beans cannot be pooled (each unique client), stateless beans can be pooled
3. Passivation/Activation only for stateful; conserves memory but adds latency
4. CMP reduces code but less control; BMP gives full control but more code
5. Don't rely on ejbRemove() or ejbPassivate() for critical cleanup—they may not be called

## Wiki Pages Created/Updated

- [[session-bean|Session Bean]]
- [[stateful-session-bean|Stateful Session Bean]]
- [[stateless-session-bean|Stateless Session Bean]]
- [[passivation|Passivation]]
- [[activation|Activation]]
- [[entity-bean|Entity Bean]]
- [[container-managed-persistence|Container-Managed Persistence]]
- [[bean-managed-persistence|Bean-Managed Persistence]]
- [[instance-pooling|Instance Pooling]]
- [[ejb-lifecycle-stateless|EJB Lifecycle — Stateless]]
- [[ejb-lifecycle-stateful|EJB Lifecycle — Stateful]]
- [[object-relational-mapping|Object-Relational Mapping]]
- [[ejb-container|EJB Container]]

## Connections

- [[session-bean|Session Bean]] — Chapter 4 coverage
- [[stateful-session-bean|Stateful Session Bean]] — stateful variant
- [[stateless-session-bean|Stateless Session Bean]] — stateless variant
- [[entity-bean|Entity Bean]] — Chapter 6 coverage
- [[passivation|Passivation]] — memory optimization
- [[activation|Activation]] — restoration from disk
- [[bean-managed-persistence|Bean-Managed Persistence]] — manual JDBC
- [[container-managed-persistence|Container-Managed Persistence]] — auto-generated
- [[ejb-lifecycle-stateless|Stateless Bean Lifecycle]] — lifecycle coverage
- [[ejb-lifecycle-stateful|Stateful Bean Lifecycle]] — lifecycle coverage
- [[instance-pooling|Instance Pooling]] — resource optimization
- [[object-relational-mapping|Object-Relational Mapping]] — ORM concept
- [[ejb-container|EJB Container]] — runtime environment
