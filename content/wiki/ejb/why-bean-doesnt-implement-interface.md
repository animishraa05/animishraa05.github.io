---
concept: "Why Bean Doesn't Implement Component Interface"
aliases: [bean interface design, EJB object vs bean class]
tags: [dev, ejb]
sources_count: 1
last_source: ejb5.md
created: 2026-04-29
updated: 2026-04-29
---

# Why Bean Doesn't Implement Component Interface

## The Problem
The component interface (Remote/Local) defines the business methods the client can call. It seems natural for the bean class to implement this interface directly—this would give compile-time checking that method signatures match. So why doesn't `HelloBean implements Hello`?

## Core Idea
There are two good reasons NOT to have the bean class implement the component interface:

1. **Pollution**: Component interfaces extend `EJBObject` or `EJBLocalObject`, which have extra methods (`remove()`, `getHandle()`, etc.) intended for clients. If the bean implements the interface, you'd need to provide no-op implementations of these methods—they don't belong in the bean.

2. **The "this" danger**: If the bean implements the same interface as the EJB object, you could accidentally pass `this` (the bean instance) to another bean instead of the EJB object (proxy). All clients must go through the proxy, never the bean directly.

## How It Works

**The Solution — Business Interface Pattern:**
```java
// Business interface (no EJB stuff)
public interface HelloBusinessMethods {
    String hello() throws RemoteException;
}

// Remote interface extends both EJBObject and business interface
public interface HelloRemote extends EJBObject, HelloBusinessMethods {}

// Bean implements business interface only
public class HelloBean implements SessionBean, HelloBusinessMethods {
    public String hello() { return "Hello, World!"; }
}
```

## Visual Explanation

```dot
digraph BeanInterface {
    rankdir=LR;
    node [shape=box, style=filled];

    subgraph cluster_wrong {
        label="WRONG: Bean implements Remote Interface";
        RI [label="Remote Interface\n(EJBObject + hello())", fillcolor=lightcoral];
        Bean [label="HelloBean\nimplements RemoteInterface\n(Must implement\nEJBObject methods too!)", fillcolor=lightcoral];
        RI -> Bean [style=dashed];
    }

    subgraph cluster_right {
        label="RIGHT: Business Interface Pattern";
        BI [label="Business Interface\n(hello() only)", fillcolor=lightgreen];
        R2 [label="Remote Interface\n(EJBObject + Business)", fillcolor=lightyellow];
        Bean2 [label="HelloBean\nimplements BusinessInterface", fillcolor=lightgreen];
        BI -> R2 [style=dashed];
        BI -> Bean2 [style=dashed];
    }
}
```

## Key Properties
- **Separation of concerns**: Bean handles business logic, EJB Object handles middleware
- **Compile-time safety**: Business interface ensures bean has required methods
- **No pollution**: Bean doesn't contain client-specific methods (`remove()`, etc.)
- **Avoids `this` danger**: Bean can't accidentally pass itself (only EJB object gets passed)

## Connections
- **Built from:** [[remote-interface|Remote Interface]], [[ejb-object|EJB Object]]
- **Builds into:** [[session-bean|Session Bean]], [[entity-bean|Entity Bean]]
- **Related:** [[business-interface-pattern|Business Interface Pattern]]
- **Contrasts with:** Regular Java (where impl implements the interface directly)

## Edge Cases & Gotchas
- **Local interface problem**: The business interface pattern still causes local interfaces to throw `RemoteException`—annoying but tolerable
- **Not mandatory**: You CAN implement the component interface—it's just not recommended
- **Modern EJB (3.x+)**: Uses annotations (`@Remote`, `@Local`)—this problem is largely solved

## Sources
- [[ejb5-summary|EJB5 Source Summary]]
