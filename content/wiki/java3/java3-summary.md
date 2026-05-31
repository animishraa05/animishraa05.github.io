---
source: "Advanced Java Tutorial"
source_path: sources/java3.md
ingested: 2026-05-13
concepts_count: 42
tags: [dev, java]
---

## What This Source Is

A comprehensive GeeksforGeeks tutorial index covering the Advanced Java landscape: JDBC, Servlets, JSP, Hibernate ORM, the entire Spring ecosystem (Core, MVC, Boot, Data JPA, ORM, JDBC, Security, AOP, Cloud), Java Microservices, and JUnit testing. Each section links to detailed subtopics, mini-projects, and complete tutorials.

## Concepts Extracted

**Created (42 concept pages in `wiki/java3/`):**

**Hibernate (5):**
- [[hibernate-orm-framework|Hibernate ORM Framework]] — Hibernate configuration, SessionFactory, Sessions, CRUD operations
- [[hibernate-entity-mapping|Hibernate Entity Mapping]] — @OneToOne, @OneToMany, @ManyToMany relationship mappings
- [[hibernate-annotations|Hibernate Annotations]] — JPA annotations (@Entity, @Id, @Column, @GeneratedValue)
- [[hql|Hibernate Query Language]] — HQL and Native SQL queries
- [[hibernate-caching|Hibernate Caching]] — First-level, second-level, and query cache

**Spring Core (6):**
- [[spring-framework|Spring Framework]] — Modular framework, IoC container overview
- [[spring-ioc-container|Spring IoC Container]] — BeanFactory, ApplicationContext, DI
- [[spring-bean-lifecycle|Spring Bean Lifecycle]] — Bean lifecycle phases and scopes
- [[spring-autowiring|Spring Autowiring]] — @Autowired, @Qualifier, @Primary
- [[spring-annotations|Spring Annotations]] — @Component, @Service, @Repository, @Configuration, @Bean

**Spring Expression Language (1):**
- [[spring-spel|Spring Expression Language]] — SpEL syntax and runtime evaluation

**Spring MVC (5):**
- [[spring-mvc|Spring MVC]] — DispatcherServlet front controller, Model-View-Controller
- [[dispatcher-servlet|DispatcherServlet]] — Front controller, handler mapping, view resolution
- [[spring-controller|Spring Controller]] — @Controller, @RestController, @RequestMapping
- [[spring-form-handling|Spring Form Handling]] — @ModelAttribute, @Valid, BindingResult
- [[spring-mvc-exception-handling|Spring MVC Exception Handling]] — @ExceptionHandler, @ControllerAdvice

**Spring Boot (4):**
- [[spring-boot|Spring Boot]] — Auto-configuration, embedded server, production readiness
- [[spring-boot-auto-configuration|Spring Boot Auto-Configuration]] — Conditional auto-config, starters
- [[spring-boot-rest-api|Spring Boot REST API]] — @RestController, JSON serialization, RESTful services
- [[spring-boot-actuator|Spring Boot Actuator]] — Production monitoring endpoints, Micrometer

**Spring Data JPA (4):**
- [[spring-data-jpa|Spring Data JPA]] — Repository-based data access, query methods
- [[jpa-repository|JpaRepository]] — CrudRepository, PagingAndSortingRepository hierarchy
- [[jpa-query-methods|JPA Query Methods]] — Derived query methods from method names
- [[jpa-pagination-sorting|JPA Pagination and Sorting]] — Pageable, Sort, Page

**Spring ORM + JDBC (2):**
- [[spring-orm|Spring ORM]] — Spring-Hibernate integration, session management
- [[spring-jdbc-template|Spring JDBC Template]] — JdbcTemplate, NamedParameterJdbcTemplate

**Spring Security (3):**
- [[spring-security|Spring Security]] — Security filter chain, authentication, authorization
- [[spring-security-authentication|Spring Security Authentication]] — UserDetailsService, role-based access
- [[spring-security-csrf-jwt|Spring Security CSRF and JWT]] — CSRF, CORS, JWT authentication

**Spring AOP (2):**
- [[spring-aop|Spring AOP]] — Aspect-oriented programming, proxy-based weaving
- [[spring-aop-advice|Spring AOP Advice Types]] — @Before, @After, @Around, @AfterReturning, @AfterThrowing

**Spring Cloud (3):**
- [[spring-cloud|Spring Cloud]] — Distributed systems tooling for microservices
- [[spring-cloud-service-discovery|Spring Cloud Service Discovery]] — Eureka, client-side load balancing
- [[spring-cloud-api-gateway|Spring Cloud API Gateway]] — Reactive gateway, routing, filtering

**Java Microservices (5):**
- [[java-microservices|Java Microservices]] — Microservice architecture in Java
- [[api-gateway-pattern|API Gateway Pattern]] — Single entry point for microservices
- [[service-discovery-registry|Service Discovery and Registry]] — Dynamic service registration
- [[distributed-tracing|Distributed Tracing]] — Trace ID propagation, Zipkin visualization

**JUnit (4):**
- [[junit-testing|JUnit Testing]] — JUnit 5 test framework
- [[junit-annotations-lifecycle|JUnit Annotations and Lifecycle]] — @BeforeEach, @AfterEach, @BeforeAll, @AfterAll
- [[junit-parameterized-tests|JUnit Parameterized Tests]] — @ParameterizedTest, argument sources
- [[test-driven-development|Test-Driven Development]] — Red-Green-Refactor cycle

**Updated (5 existing pages):**
- [[java-jdbc|Java JDBC (java/)]] — Added CRUD operations, statement types, transaction details, java3 source
- [[jdbc|JDBC (ejb/)]] — Added java3 source reference
- [[servlets|Servlets (ejb/)]] — Added servlet lifecycle, filters, session management
- [[jsp|JSP (ejb/)]] — Added JSP lifecycle, directives, EL, JSTL, implicit objects
- [[object-relational-mapping|Object-Relational Mapping (ejb/)]] — Added Hibernate ORM details

## Syntheses Created (2)

- [[servlet-vs-jsp|Servlet vs JSP]] — Java-centric vs content-centric web development
- [[monolithic-vs-microservices|Monolithic vs Microservices Architecture]] — When each architecture suits

## Key Takeaways

- Spring is the dominant Java enterprise framework — its ecosystem covers every layer from web to data to cloud
- Spring Boot's auto-configuration and starters eliminate most boilerplate configuration
- Spring Data JPA eliminates DAO implementation code through derived query methods
- Hibernate provides multi-level caching (L1, L2, query cache) for database performance
- Spring Cloud provides the full toolkit for building production microservices (discovery, gateway, tracing)
- JUnit 5's parameterized tests and lifecycle hooks enable clean, comprehensive test suites
- The monolithic vs microservices decision depends on team size and operational maturity, not technology

## Open Questions

- How does Spring Boot's auto-configuration perform at very large scale (1000+ auto-config classes)?
- What are the performance characteristics of Spring Cloud Gateway vs Nginx/HAProxy at high throughput?
- How does Hibernate's second-level cache performance compare to dedicated caching solutions (Redis-only)?
- What is the operational cost of running a full Spring Cloud microservices stack?
