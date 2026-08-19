---
source: EJB6 - JNDI, J2EE, and EJB Deep Learning
source_path: sources/ejb6.md
content_hash: ejb6-gemini-conversation
ingested: 2026-04-29
concepts_count: 21
tags: [dev, ejb]
---

## Source Overview
**Title:** EJB6 - JNDI, J2EE, and EJB Deep Learning  
**Type:** Gemini conversation transcript (88+ messages)  
**Date:** 2026-04-29  
**Description:** Comprehensive conversation covering JNDI architecture, J2EE platform, RMI-IIOP, and enterprise middleware concepts with Hinglish explanations and exam preparation tips.

## Concepts Extracted (21)

### JNDI Concepts (8)
1. [[jndi-architecture|JNDI Architecture]] — Client API vs SPI, pluggable providers
2. [[jndi-spi|JNDI SPI]] — Service Provider Interface for vendors
3. [[jndi-naming-concepts|JNDI Naming Concepts]] — Atomic, compound, bindings, contexts
4. [[atomic-name|Atomic Name]] — Indivisible name component
5. [[compound-name|Compound Name]] — Path-like name combinations
6. [[jndi-binding|JNDI Binding]] — Name-to-object associations
7. [[jndi-context|JNDI Context]] — Container of bindings
8. [[subcontext|Subcontext]] — Context within a context

### J2EE Platform Concepts (4)
9. [[j2ee-specification|J2EE Specification]] — Rules, not a product
10. [[j2ee-compliance|J2EE Compliance]] — TCK tests, certification
11. [[java-platforms|Java Platforms]] — J2ME, J2SE, J2EE hierarchy
12. [[jax-rpc|JAX-RPC]] — Web Services API for J2EE

### Integration & APIs (6)
13. [[java-idl|Java IDL]] — CORBA integration for cross-language
14. [[jca|J2EE Connector Architecture]] — Legacy system integration
15. [[jaxp|JAXP]] — XML parsing API
16. [[jaas|JAAS]] — Authentication and authorization
17. [[jta-jts|JTA and JTS]] — Transaction API and service
18. [[javamail|JavaMail]] — Email sending API

### Web Technologies (3)
19. [[servlets|Servlets]] — Request/response web components
20. [[jsp|JSP]] — HTML-centric presentation technology

### Communication (1)
21. [[rmi-iiop|RMI-IIOP]] — RMI over IIOP for CORBA integration

## Wiki Pages Created
- 21 concept pages in `wiki/ejb/` (all new, none existed before)
- 1 source summary: `wiki/ejb/ejb6-summary.md`

## Key Takeaways
- **JNDI Architecture**: Two-part system (Client API for developers, SPI for vendors) similar to JDBC driver model
- **JNDI Naming**: Hierarchical tree with atomic names, compound names, bindings, contexts, and subcontexts (like file system)
- **J2EE is a specification**, not a product—vendors implement it to earn compliance certification via TCK
- **Java Platform Hierarchy**: J2EE ⊃ J2SE ⊃ J2ME (conceptual superset relationship)
- **RMI-IIOP**: Official J2EE remoting protocol, extends RMI with IIOP for CORBA integration
- **EJB objects are RMI-IIOP objects**: `javax.ejb.EJBObject` extends `java.rmi.Remote`
- **Instance Pooling**: Resource optimization using client "think time" to serve many clients with few bean instances

## Novelty
This source provides:
1. **Complete JNDI understanding**: Architecture (API vs SPI), naming concepts (5 core concepts), and practical usage
2. **J2EE big picture**: Specification vs product, compliance certification, Java platform hierarchy
3. **All major J2EE APIs**: JAX-RPC, Java IDL, JCA, JAXP, JAAS, JTA/JTS, JavaMail, Servlets, JSP
4. **RMI-IIOP deep dive**: How EJB objects are networked RMI-IIOP objects
5. **Exam preparation**: 20-mark question structure for "What is J2EE?" with 4-part answer format
6. **Instance pooling explained**: Resource optimization with "bank ATM" analogy and benefits

## Open Questions
- How does JNDI federation actually work across different directory types (LDAP + NDS)?
- What are the exact differences between JAX-RPC and modern JAX-WS?
- How does the TCK actually test compliance—what percentage must pass?

## Cross-References Added
All 21 concept pages have 4+ connections with bidirectional linking to existing EJB wiki pages.

## Connections

- [[jndi-architecture|JNDI Architecture]] — 8 JNDI concepts
- [[j2ee-specification|J2EE Specification]] — 4 J2EE platform concepts
- [[jax-rpc|JAX-RPC]] — web services
- [[rmi-iiop|RMI-IIOP]] — official J2EE remoting
- [[servlets|Servlets]] — web components
- [[jaas|JAAS]] — authentication/authorization
- [[jta-jts|JTA and JTS]] — distributed transactions
- [[java-platforms|Java Platforms]] — J2ME/J2SE/J2EE hierarchy
- [[jndi-spi|JNDI SPI]] — vendor implementations
- [[instance-pooling|Instance Pooling]] — resource optimization
