---
concept: "EJB Development Lifecycle"
aliases: [EJB build process, EJB development steps, 8-step EJB process]
tags: [dev, ejb]
sources_count: 1
last_source: ejb5.md
created: 2026-04-29
updated: 2026-04-29
---

## The Problem
Building an EJB component involves more than just writing Java code. You need to compile, package, configure, and deploy—missing any step results in a non-functional component. What's the correct order?

## Core Idea
The EJB development lifecycle is an 8-step process from raw Java files to a running, tested component in the container. Each step has a specific purpose and must be done in order.

## How It Works

1. **Write Java files**: Component interfaces, home interfaces, bean class, helper classes
2. **Write deployment descriptor**: `ejb-jar.xml` with bean metadata (or use IDE/XDoclet to generate)
3. **Compile**: `javac` to convert `.java` → `.class`
4. **Create EJB-JAR**: Use `jar` utility to package `.class` files + `ejb-jar.xml`
5. **Deploy**: Copy JAR to container's deployment folder or use vendor tools
6. **Configure**: Set database connections, thread pools via vendor console/config files
7. **Start container**: Verify the JAR loaded successfully
8. **Test**: Write a client, generate stubs, compile, run, and verify

## Visual Explanation

```dot
digraph EJBLifecycle {
    rankdir=TB;
    node [shape=box, style=filled, fillcolor=lightblue];

    S1 [label="1. Write .java files\n(Bean, Home, Remote)"];
    S2 [label="2. Write ejb-jar.xml\n(Deployment Descriptor)"];
    S3 [label="3. Compile .java → .class"];
    S4 [label="4. jar utility\nCreate .jar file"];
    S5 [label="5. Deploy .jar to Container"];
    S6 [label="6. Configure Server\n(DB, Threads)"];
    S7 [label="7. Start Container\nVerify Load"];
    S8 [label="8. Test Client\nRun & Verify"];

    S1 -> S2 -> S3 -> S4 -> S5 -> S6 -> S7 -> S8;

    S4 -> S5 [label="Ejb-jar file"];
}
```

## Key Properties
- **Standardized process**: Every EJB component follows these steps (vendor-neutral)
- **Step 5 is vendor-specific**: Each container has its own deployment mechanism
- **Step 6 is vendor-specific**: Configuration differs (Web console vs config files)
- **Deployment descriptor is key**: Tells container how to manage the bean

## Connections
- **Built from:** [[ejb-deployment-descriptor|Deployment Descriptor]], [[home-interface|Home Interface]], [[remote-interface|Remote Interface]]
- **Builds into:** [[ejb-object|EJB Object]] (generated in step 5), [[ejb-container|EJB Container]]
- **Related:** [[ejb-jar-file|EJB-JAR File]] (output of step 4)
- **Contrasts with:** Simple Java app (just compile and run—no deployment descriptor needed)

## Edge Cases & Gotchas
- **Forgetting step 2**: Without `ejb-jar.xml`, container doesn't know about your beans
- **Classpath issues**: Step 3 needs EJB APIs (javax.ejb.*) in classpath
- **Vendor tools automate**: Modern IDEs (Eclipse, IntelliJ) automate steps 2-4

## Sources
- [[ejb5-summary|EJB5 Source Summary]]
