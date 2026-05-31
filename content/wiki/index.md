---
title: Wiki
tags: [wiki, index]
---

# The Wiki — Compounding Knowledge Base

> This is the persistent, interlinked knowledge layer. Maintained by the LLM. Fed by raw sources. Read by the human in Obsidian.

---

## How This Works

- **Raw sources** live in `sources/` — drop articles, transcripts, papers here
- **The wiki** lives in `wiki/` — topic folders, each containing atomic concept pages that cross-link and compound
- When a new source is ingested, the LLM reads it and creates/updates as many wiki pages as the source contains concepts
- The wiki gets richer with every source, not just bigger

---

## Concept Index

### Java (dev)

- [[java-platform-independence|Java Platform Independence]] — JVM bytecode enables WORA across platforms
- [[java-program-structure|Java Program Structure]] — class with main() is the entry point
- [[java-identifiers-and-keywords|Java Identifiers and Keywords]] — naming rules and 67 reserved words
- [[java-data-types|Java Data Types]] — 8 primitives with fixed, platform-independent sizes
- [[java-wrapper-classes|Java Wrapper Classes]] — autoboxing bridges primitives and object types
- [[java-variables|Java Variables]] — local (stack), instance (heap), and static (method area)
- [[java-operators|Java Operators]] — arithmetic, relational, logical, bitwise, ternary, assignment
- [[java-control-flow|Java Control Flow]] — if-else chains and switch for multi-way branching
- [[java-loops|Java Loops]] — for, while, do-while, and enhanced for-each
- [[java-methods|Java Methods]] — reusable code blocks with pass-by-value semantics
- [[java-access-modifiers|Java Access Modifiers]] — private, default, protected, public visibility
- [[java-varargs|Java Variable Arguments]] — ellipsis syntax for flexible parameter counts
- [[java-arrays|Java Arrays]] — fixed-size, indexable, zero-based containers
- [[java-strings|Java Strings]] — immutable character sequences with String Pool optimization
- [[java-stringbuilder-stringbuffer|StringBuilder and StringBuffer]] — mutable string alternatives with different thread-safety profiles
- [[java-constructors|Java Constructors]] — object initialization with overloading and chaining
- [[java-class|Java Class]] — blueprint/prototype from which objects are created
- [[java-object|Java Object]] — runtime instance with state, behavior, and identity
- [[java-object-class|Java Object Class]] — root of hierarchy with equals, hashCode, toString
- [[java-abstraction|Java Abstraction]] — abstract classes hide implementation details
- [[java-encapsulation|Java Encapsulation]] — data hiding via access modifiers and getters/setters
- [[java-association|Java Association]] — relationship between independent class objects
- [[java-aggregation|Java Aggregation]] — weak "has-a" relationship with independent lifecycles
- [[java-composition|Java Composition]] — strong "has-a" relationship with dependent lifecycles
- [[java-inheritance|Java Inheritance]] — extends and super for code reuse and hierarchy
- [[java-inheritance-types|Inheritance Types]] — single, multilevel, hierarchical, multiple, hybrid in Java
- [[java-single-inheritance|Single Inheritance]] — one subclass inherits from one superclass
- [[java-multilevel-inheritance|Multilevel Inheritance]] — chain of derived classes
- [[java-hierarchical-inheritance|Hierarchical Inheritance]] — multiple subclasses from one superclass
- [[java-multiple-inheritance|Multiple Inheritance]] — through interfaces only
- [[java-hybrid-inheritance|Hybrid Inheritance]] — combined inheritance through interfaces
- [[java-polymorphism|Java Polymorphism]] — compile-time overloading and runtime dynamic dispatch
- [[java-compile-time-polymorphism|Compile-Time Polymorphism]] — method overloading resolved at compile time
- [[java-runtime-polymorphism|Runtime Polymorphism]] — method overriding resolved at runtime via vtable
- [[java-oop-advantages|OOP Advantages]] — code reusability, structure, DRY, faster development
- [[java-oop-disadvantages|OOP Disadvantages]] — learning curve, overhead, debugging, memory
- [[java-packages|Java Packages]] — namespace organization with directory-based structure
- [[java-interfaces|Java Interfaces]] — behavioral contracts supporting multiple inheritance
- [[java-exception-hierarchy|Java Exception Hierarchy]] — Throwable, checked vs unchecked exceptions
- [[java-try-catch-finally|Java Try-Catch-Finally]] — structured error handling with auto-closable resources
- [[java-throw-throws|Java Throw and Throws]] — exception creation and propagation declaration
- [[java-custom-exceptions|Java Custom Exceptions]] — domain-specific exception classes
- [[java-regex|Java Regular Expressions]] — Pattern and Matcher for text processing
- [[java-memory-management|Java Memory Management]] — stack, heap, method area JVM organization
- [[java-garbage-collection|Java Garbage Collection]] — generational automatic memory reclamation
- [[java-collections-framework|Java Collections Framework]] — List, Set, Map interface hierarchy
- [[java-arraylist|Java ArrayList]] — resizable array with O(1) indexed access
- [[java-hashmap|Java HashMap]] — hash table with O(1) average key-value lookups
- [[java-iterator|Java Iterator]] — uniform collection traversal with fail-fast behavior
- [[java-comparable-and-comparator|Java Comparable and Comparator]] — natural and custom object ordering
- [[java-lambda-and-streams|Java Lambda Expressions and Streams]] — functional pipeline data processing
- [[java-multithreading|Java Multithreading]] — concurrent execution via Thread and Runnable
- [[java-synchronization|Java Synchronization]] — coordinated shared resource access with monitors
- [[java-deadlock|Java Deadlock]] — circular wait prevention and detection
- [[java-executor-framework|Java Executor Framework]] — thread pool abstraction for scalable concurrency
- [[java-file-handling|Java File Handling]] — stream-based and NIO.2 file I/O
- [[java-socket-programming|Java Socket Programming]] — TCP/IP client-server networking
- [[java-jdbc|Java JDBC]] — vendor-independent database connectivity API

**Java Syntheses (dev):**

- [[java-checked-vs-unchecked|Checked vs Unchecked Exceptions]] — compiler-enforced vs runtime exception handling comparison
- [[java-string-types-compared|String vs StringBuffer vs StringBuilder]] — immutability vs thread safety vs performance tradeoffs
- [[java-oop-pillars|The Four OOP Pillars]] — encapsulation, inheritance, polymorphism, abstraction interplay
- [[java-aggregation-vs-composition|Aggregation vs Composition]] — weak vs strong association lifecycle comparison
- [[java-overloading-vs-overriding|Overloading vs Overriding]] — compile-time vs runtime polymorphism
- [[java-abstract-class-vs-interface|Abstract Class vs Interface]] — partial vs full abstraction

**Advanced Java (dev):**

- [[hibernate-orm-framework|Hibernate ORM Framework]] — ORM framework mapping Java objects to database tables with automatic SQL generation
- [[hibernate-entity-mapping|Hibernate Entity Mapping]] — @OneToOne, @OneToMany, @ManyToMany relationship mapping strategies
- [[hibernate-annotations|Hibernate Annotations]] — JPA annotations (@Entity, @Id, @Column) replacing XML mapping files
- [[hql|Hibernate Query Language]] — Object-oriented query language using class and field names instead of SQL
- [[hibernate-caching|Hibernate Caching]] — First-level (session), second-level (SessionFactory), and query cache architecture
- [[spring-framework|Spring Framework]] — Modular enterprise framework centered on IoC, DI, and AOP
- [[spring-ioc-container|Spring IoC Container]] — ApplicationContext and BeanFactory for managing bean lifecycle and wiring
- [[spring-bean-lifecycle|Spring Bean Lifecycle]] — From instantiation through dependency injection, init, ready, and destruction
- [[spring-autowiring|Spring Autowiring]] — Automatic dependency resolution via @Autowired, @Qualifier, @Primary
- [[spring-annotations|Spring Annotations]] — @Component, @Service, @Repository, @Configuration for declarative bean definition
- [[spring-spel|Spring Expression Language]] — Runtime expression evaluation for dynamic configuration values
- [[spring-mvc|Spring MVC]] — Web framework built on DispatcherServlet front controller with Model-View-Controller
- [[dispatcher-servlet|DispatcherServlet]] — Front controller coordinating handler mapping, adapter execution, and view resolution
- [[spring-controller|Spring Controller]] — @Controller, @RestController, @RequestMapping for handling HTTP requests
- [[spring-form-handling|Spring Form Handling]] — @ModelAttribute, @Valid, BindingResult for form-to-object binding and validation
- [[spring-mvc-exception-handling|Spring MVC Exception Handling]] — @ExceptionHandler and @ControllerAdvice for declarative error handling
- [[spring-boot|Spring Boot]] — Opinionated framework with auto-configuration, embedded server, and production readiness
- [[spring-boot-auto-configuration|Spring Boot Auto-Configuration]] — Conditional auto-configuration triggered by classpath dependencies
- [[spring-boot-rest-api|Spring Boot REST API]] — Building RESTful web services with @RestController and auto-configured Jackson
- [[spring-boot-actuator|Spring Boot Actuator]] — Production endpoints for health, metrics, environment, and runtime management
- [[spring-data-jpa|Spring Data JPA]] — Repository-based data access eliminating DAO implementation code
- [[jpa-repository|JpaRepository]] — CRUD, paging, sorting repository interface hierarchy
- [[jpa-query-methods|JPA Query Methods]] — Derived queries from method names like findByLastName
- [[jpa-pagination-sorting|JPA Pagination and Sorting]] — Pageable and Sort for efficient subset queries
- [[spring-orm|Spring ORM]] — Integration layer between Spring and Hibernate for session/transaction management
- [[spring-jdbc-template|Spring JDBC Template]] — Template-based JDBC eliminating boilerplate resource management
- [[spring-security|Spring Security]] — Comprehensive auth/authz framework with filter chain architecture
- [[spring-security-authentication|Spring Security Authentication]] — UserDetailsService, AuthenticationProvider, role-based access
- [[spring-security-csrf-jwt|Spring Security CSRF and JWT]] — CSRF token protection, CORS, and JWT bearer authentication
- [[spring-aop|Spring AOP]] — Proxy-based aspect-oriented programming for cross-cutting concerns
- [[spring-aop-advice|Spring AOP Advice Types]] — @Before, @After, @Around, @AfterReturning, @AfterThrowing
- [[spring-cloud|Spring Cloud]] — Suite for building cloud-native microservices (discovery, gateway, config, tracing)
- [[spring-cloud-service-discovery|Spring Cloud Service Discovery]] — Eureka service registry and client-side load balancing
- [[spring-cloud-api-gateway|Spring Cloud API Gateway]] — Reactive gateway for routing, filtering, and cross-cutting concerns
- [[java-microservices|Java Microservices]] — Architectural style of independently deployable, database-per-service components
- [[api-gateway-pattern|API Gateway Pattern]] — Single entry point handling routing, auth, and rate limiting
- [[service-discovery-registry|Service Discovery and Registry]] — Dynamic service registration and discovery via central registry
- [[distributed-tracing|Distributed Tracing]] — End-to-end request tracing with Sleuth/Zipkin across service boundaries
- [[junit-testing|JUnit Testing]] — JUnit 5 framework for writing and running automated Java tests
- [[junit-annotations-lifecycle|JUnit Annotations and Lifecycle]] — @BeforeEach, @AfterEach, @BeforeAll, @AfterAll lifecycle hooks
- [[junit-parameterized-tests|JUnit Parameterized Tests]] — Running tests with multiple argument sources
- [[test-driven-development|Test-Driven Development]] — Red-Green-Refactor cycle for writing tests before implementation

**Advanced Java Syntheses (dev):**

- [[servlet-vs-jsp|Servlet vs JSP]] — Java-centric vs content-centric web presentation technologies
- [[monolithic-vs-microservices|Monolithic vs Microservices Architecture]] — Simplicity vs independence tradeoff analysis

### Enterprise JavaBeans (dev)

- [[session-bean|Session Bean]] — Server-side component representing work being performed for client code, implementing business logic and workflow
- [[stateless-session-bean|Stateless Session Bean]] — Handles single method calls without retaining conversational state between invocations
- [[stateful-session-bean|Stateful Session Bean]] — Services business processes spanning multiple method requests, retaining state on behalf of an individual client
- [[entity-bean|Entity Bean]] — Persistent object representing business data stored in permanent storage, the "nouns" of EJB
- [[message-driven-bean|Message-Driven Bean (MDB)]] — JMS message consumer, no client-visible interfaces, async, stateless, onMessage() only
- [[bean-managed-persistence|Bean-Managed Persistence]] — Developer writes explicit JDBC code in the entity bean to handle all database operations
- [[container-managed-persistence|Container-Managed Persistence]] — EJB container automatically handles all database operations; developer writes no JDBC code
- [[activation|Activation]] — Container deserializes a previously passivated stateful session bean back into memory to handle a client request
- [[passivation|Passivation]] — Container serializes a stateful session bean to secondary storage to free up memory
- [[instance-pooling|Instance Pooling]] — Container maintains a pool of ready-to-use bean instances instead of creating new objects per request
- [[ejb-lifecycle-stateless|Stateless Bean Lifecycle]] — Three states: Does Not Exist → Method-Ready Pool → Removed, all managed by the container
- [[ejb-lifecycle-stateful|Stateful Bean Lifecycle]] — Four states with passivation and activation unique to stateful beans for memory management
- [[ejb-object|EJB Object]] — Container-generated stub acting as proxy between client and actual Enterprise Bean, handling RMI communication
- [[home-interface|Home Interface]] — Factory interface defining methods for creating, finding, and removing Enterprise Bean instances
- [[remote-interface|Remote Interface]] — Declares the business methods that clients can invoke on an Enterprise Bean
- [[local-home-interface|Local Home Interface]] — High-performance version of Home Interface for same-JVM clients with no network calls or RemoteException
- [[ejb-deployment-descriptor|EJB Deployment Descriptor]] — XML file declaring how an Enterprise Bean should behave in the container
- [[ejb-jar-file|EJB-JAR File]] — Standard Java archive containing all classes plus the ejb-jar.xml deployment descriptor for vendor-neutral deployment
- [[ejb-roles|EJB Roles]] — Distinct roles: Bean Provider, Application Assembler, Deployer, System Administrator, and Container Provider
- [[ejb-development-lifecycle|EJB Development Lifecycle]] — 8-step process from raw Java files to a running tested component in the container
- [[ejb-context|EJB Context]] — EJBContext is the bean's gateway to the container, encapsulating everything about its environment
- [[entity-context|Entity Context]] — Provides the entity bean instance with access to container services and information about the current entity
- [[session-context|SessionContext]] — EJB context specific to session beans, providing getEJBObject() and getEJBLocalObject() methods
- [[middleware|Middleware]] — Software layer sitting between client and server, handling infrastructure concerns like transactions and security transparently
- [[explicit-vs-implicit-middleware|Explicit vs Implicit Middleware]] — Explicit requires developers to manually write infrastructure code; implicit has the container handle it automatically
- [[distributed-objects|Distributed Objects]] — Java object running on a remote server that can be accessed as if it were local, with container handling all network complexity
- [[component-architecture-soa|Component Architecture & SOA]] — Break a large application into small independent components where each handles a specific responsibility
- [[location-transparency|Location Transparency]] — JNDI nickname lookup, not physical address; write once run anywhere
- [[ejb-verification-generation|EJB Verification & Generation]] — Container verifies bean validity and automatically generates EJB Object and Home Object implementations
- [[ejb-client-jar|EJB Client JAR]] — Optional smaller archive containing only the files clients need: interfaces, helper classes, and generated stubs
- [[application-vs-system-exceptions|Application vs System Exceptions]] — Two exception types with different handling: application for routine business problems, system for critical failures
- [[why-bean-doesnt-implement-interface|Why Bean Doesn't Implement Component Interface]] — Avoids pollution from EJBObject methods and the "this" danger of bypassing proxies
- [[business-interface-pattern|Business Interface Pattern]] — Define a pure business interface containing only business method signatures, implemented by both bean and EJB Object
- [[dont-rely-on-ejbremove|Don't Rely on ejbRemove()]] — Container may not call ejbRemove() on crash; never rely on it for critical cleanup
- [[session-bean-lifetime|Session Bean Lifetime]] — Short-lived, non-persistent objects whose lifetime roughly matches the client session duration
- [[session-bean-subtypes|Session Bean Subtypes]] — Stateful (maintains client-specific state) vs Stateless (no conversational state, pooled and shared)
- [[session-bean-relationships|Session Bean Relationships]] — Session beans can perform persistence with relationships using JDBC but lack identity of entity beans
- [[stateless-session-bean-pooling|Stateless Session Bean Pooling]] — Method-Ready Pool where any client can use any instance since there's no conversational state
- [[client-think-time|Client Think Time]] — Period when a user is viewing a page between actions, during which the server-side bean can serve other clients
- [[resource-pooling|Resource Pooling]] — DB connections, sockets shared across clients for efficiency
- [[count-bean-example|Count Bean Example]] — Simple stateful session bean example maintaining conversational state demonstrating the full EJB development cycle
- [[account-bean-bmp-example|Account Bean BMP Example]] — BMP entity bean representing a bank account with remote/home interfaces, PK class, JDBC CRUD code
- [[persistence-concepts|Persistence Concepts]] — Two main ways to persist Java objects: serialization (byte blob, not queryable) and ORM (relational tables, queryable)
- [[serialization-vs-orm|Serialization vs ORM]] — Serialization stores objects as unreadable byte blobs; ORM maps objects to relational tables for queryability

**Entity Bean Callbacks (dev):**

- [[ejbcreate|ejbCreate()]] — Called when a client creates a new entity bean instance, inserting a new database record and returning the primary key
- [[ejbpostcreate|ejbPostCreate()]] — Called immediately after ejbCreate() once the bean is associated with an EJB object, allowing post-creation initialization
- [[ejbremove|ejbRemove()]] — Container callback that deletes the entity's database record, using getPrimaryKey() to identify which record
- [[ejbload|ejbLoad()]] — Container callback that loads entity state from the database into the bean instance using getPrimaryKey()
- [[ejbstore|ejbStore()]] — Container callback that synchronizes the bean's in-memory field values to the database via an UPDATE query
- [[ejbactivate|ejbActivate()]] — Callback called on a stateful session bean AFTER it has been passivated and is being restored to ready state
- [[ejbpassivate|ejbPassivate()]] — Callback called on a stateful session bean BEFORE it is passivated, allowing release of non-serializable resources
- [[setentitycontext|setEntityContext()]] — Called by the container when a new entity bean instance is created, providing the EntityContext
- [[unsetentitycontext|unsetEntityContext()]] — Called by the container right before destroying a bean instance, allowing release of acquired resources
- [[finder-methods|Finder Methods]] — Special methods on entity beans that search the database and return primary keys of matching entity records
- [[ejbhome|ejbHome()]] — Business methods that operate on the entity bean class as a whole, not on specific instances, running while in the pool
- [[getprimarykey|getPrimaryKey()]] — Method on EntityContext that returns the primary key of the entity currently associated with the bean instance
- [[entity-bean-identity|Entity Bean Identity]] — Entity beans have a primary key that uniquely distinguishes each instance, enabling comparison and shared access
- [[entity-bean-instance-vs-data|Entity Bean Instance vs Data]] — EJB spec distinguishes entity bean instances (in-memory Java objects) from entity bean data (persistent database records)
- [[primary-key|Primary Key]] — Column or set of columns whose values uniquely identify each row in a database table
- [[primary-key-class|Primary Key Class]] — Custom Java class wrapping one or more primary key fields, used as return type of ejbCreate() and parameter for findByPrimaryKey()
- [[cmp-abstract-accessors|CMP Abstract Accessors and Methods]] — CMP entity beans use abstract getter/setter pairs for persistent fields, abstract ejbSelect, and ejbHome methods
- [[cmp-lifecycle|CMP Entity Bean Lifecycle]] — Identical to BMP lifecycle with all callback methods empty because the container handles everything automatically
- [[entity-bean-transactions|Entity Bean Transaction Rules]] — Entity Beans MUST use Container-Managed Transactions only; Programmatic Transactions are illegal

**CMP vs BMP Relationships (dev):**

- [[one-to-one-relationship|One-to-One Relationship]] — Each entity instance relates to at most one instance of another entity
- [[one-to-many-relationship|One-to-Many Relationship]] — One entity instance relates to multiple instances of another, modeled with Collection CMR fields
- [[many-to-many-relationship|Many-to-Many Relationship]] — Each entity instance can relate to multiple instances of another, requiring a junction table
- [[bidirectional-vs-unidirectional|Bidirectional vs Unidirectional]] — Bidirectional means both entities navigate to each other; unidirectional means only one can
- [[cmp-vs-bmp-relationships|BMP vs CMP Relationships Compared]] — BMP requires manual JDBC for relationships; CMP uses deployment descriptors and CMR fields
- [[normalized-vs-denormalized-schema|Normalized vs Denormalized Schema]] — Normalized minimizes redundancy but requires JOINs; denormalized duplicates data for faster queries

**Transactions (dev):**

- [[transactions|Transactions in EJB]] — ACID properties for enterprise bean operations with the container abstracting the underlying transaction system
- [[transaction-demarcation|Transaction Demarcation in EJB]] — Three ways: Programmatic (BMT), Declarative (CMT), and Client-Initiated
- [[declarative-vs-programmatic-transactions|Declarative vs Programmatic Transactions]] — CMT has container auto start/commit; BMT has bean explicitly call begin/commit
- [[client-initiated-transactions|Client-Initiated Transactions]] — Client code begins and ends the transaction, giving client control over outcomes
- [[flat-vs-nested-transactions|Flat vs Nested Transactions]] — Flat is all-or-nothing; nested has subtransactions that can roll back independently

**JMS / Messaging (dev):**

- [[jms|Java Message Service (JMS)]] — Standard Java API for messaging that abstracts vendor-specific MOM implementations
- [[jms-programming-model|JMS Programming Model]] — 6-step pipeline: lookup ConnectionFactory → create Connection → create Session → lookup Destination → produce/consume
- [[point-to-point-vs-pub-sub|Point-to-Point vs Publish/Subscribe]] — PTP uses Queues for one-to-one; Pub/Sub uses Topics for one-to-many broadcast
- [[message-oriented-middleware|Message-Oriented Middleware (MOM)]] — Infrastructure enabling asynchronous, reliable, many-to-many messaging between producers and consumers
- [[poison-message|Poison Message]] — Message that continuously fails processing and gets repeatedly retransmitted, creating an infinite retry loop
- [[pluggable-message-providers|Pluggable Message Providers]] — From EJB 2.1+, MDBs can consume any message type via JCA 1.5 resource adapters
- [[queue-partitioning|Queue Partitioning]] — Multiple JMS queues to route different message types to different server clusters for controlled load balancing

**JNDI Naming (dev):**

- [[jndi|JNDI]] — Java API providing a unified interface for locating resources through a naming and directory service by logical name
- [[jndi-architecture|JNDI Architecture]] — Two-part: Client API for application developers and SPI for vendor implementations
- [[jndi-spi|JNDI Service Provider Interface]] — Framework that naming service vendors implement to bridge JNDI client API calls to their protocols
- [[jndi-naming-concepts|JNDI Naming Concepts]] — Hierarchical naming model with five concepts: atomic names, compound names, bindings, contexts, subcontexts
- [[atomic-name|Atomic Name]] — Simple, basic, indivisible name in JNDI that serves as a building block for compound names
- [[compound-name|Compound Name]] — Zero or more atomic names combined using a specific syntax representing a full path through the naming hierarchy
- [[jndi-binding|JNDI Binding]] — Association of a name with an object, the fundamental association that makes up contexts
- [[jndi-context|JNDI Context]] — Set of zero or more bindings where each binding has a distinct atomic name, like a folder in the naming tree
- [[subcontext|Subcontext]] — Context contained within another context, enabling tree-structured hierarchical naming
- [[ejb-naming-service|EJB Naming Service]] — EJB uses JNDI to store and look up resources by logical name rather than physical address

**RMI / Serialization (dev):**

- [[rmi-remote-method-invocation|RMI Remote Method Invocation]] — Allows an object in one JVM to invoke methods on an object in another JVM, creating the illusion of local calls
- [[rmi-iiop|RMI-IIOP]] — RMI extended to use the IIOP protocol, enabling CORBA integration and serving as the official API in J2EE
- [[object-serialization|Object Serialization]] — Converts a Java object into a byte stream for network transmission or file storage, then reconstructs it later
- [[pass-by-value-in-rmi|Pass-by-Value in RMI]] — Normal objects are serialized, sent over the network, and reconstructed as a completely separate copy
- [[pass-by-reference-in-rmi|Pass-by-Reference in RMI]] — Objects implementing Remote are passed by reference via a stub that forwards method calls

**J2EE Platform (dev):**

- [[j2ee-specification|J2EE Specification]] — Specification defining APIs and behaviors that vendors must implement to be compliant, ensuring portability
- [[j2ee-compliance|J2EE Compliance]] — Achieved when a vendor's product passes the Test Compatibility Kit, earning the "J2EE-compliant" brand
- [[java-platforms|Java Platforms]] — Three platforms in hierarchical relationship: J2ME for mobile, J2SE for desktop, J2EE for enterprise
- [[jax-rpc|JAX-RPC]] — Main technology for developing web services on J2EE, defining servlet-based and EJB-based endpoint models for SOAP
- [[java-idl|Java IDL]] — Sun's Java-based implementation of CORBA, allowing Java objects to integrate with other languages
- [[jca|J2EE Connector Architecture]] — Enables J2EE applications to access existing enterprise information systems through standard resource adapters
- [[jaxp|JAXP]] — De facto API for parsing XML documents in J2EE applications, implementation-neutral, working with DOM and SAX
- [[jaas|JAAS]] — Standard API for performing authentication and authorization in J2EE with pluggable authentication mechanisms
- [[jta-jts|JTA and JTS]] — JTA is the API for transaction demarcation; JTS is the underlying transaction service implementation based on CORBA OTS
- [[javamail|JavaMail]] — Enables sending email messages in a platform-independent, protocol-independent manner from Java programs
- [[servlets|Servlets]] — Networked components extending web server functionality, handling HTTP requests and generating responses
- [[jsp|JSP]] — Similar to servlets but centered on look-and-feel, with HTML-like scripts containing embedded Java that compile into servlets

**EJB Query & Config (dev):**

- [[ejb-ql|EJB Query Language (EJB-QL)]] — Object-oriented query language used in CMP deployment descriptors to define finder and select queries
- [[cdata-hack|CDATA Hack for XML]] — CDATA section tells the XML parser to treat everything inside as raw text, escaping special characters in EJB-QL queries
- [[jdbc|JDBC]] — Standard Java API providing universal database access through database-specific drivers
- [[object-relational-mapping|Object-Relational Mapping]] — Converts in-memory Java objects to relational database data and back, mapping class fields to table columns

**EJB Syntheses:**

- [[cmp-vs-bmp|CMP vs BMP — Entity Bean Persistence]] — Compares container-managed vs bean-managed persistence across developer JDBC writing, portability, code size, and control
- [[stateful-vs-stateless-session-beans|Stateful vs Stateless Session Beans]] — Compares across conversational state, client relationship, lifetime, memory management, pooling, and scalability
- [[j2ee-tech-stack-compared|J2EE Technology Stack — Platform Components Compared]] — J2EE technologies grouped into 5 logical layers: Presentation/Web, Business Logic, Communication/Integration, Data/Persistence, Foundation Services

### Backend Engineering (dev)

- [[backend-as-program|Backend as Program]] — A backend is simply a program running on a server that receives requests, processes logic, talks to databases, and sends responses
- [[backend-architecture|Backend Architecture]] — Modern backend typically layers into: Client → API Server → Database → Cache → Background Workers
- [[backend-framework|Backend Framework]] — Library providing boilerplate for building web servers: HTTP server, routing, database connectors, middleware, helpers
- [[curl|curl]] — Command-line tool that sends HTTP requests and prints the response

### Browser Rendering (dev)

- [[browser-rendering|Browser Rendering]] — Multi-step pipeline converting HTML, CSS, and JS into visible pixels: parse → style → layout → paint → composite
- [[html-parsing|HTML Parsing]] — Tokenizes HTML text and constructs the DOM tree, automatically correcting malformed HTML
- [[dom-tree|DOM Tree]] — Tree structure built by parsing HTML where each element becomes a node, serving as JavaScript's programmatic interface
- [[css-parsing|CSS Parsing]] — Converts CSS text into the CSSOM tree of style rules for later style computation
- [[cssom|CSSOM]] — Tree structure created by parsing CSS, containing all style rules used to compute styles for DOM elements
- [[render-tree|Render Tree]] — Combines DOM and CSSOM, keeping only visible elements with their computed styles for layout and painting
- [[layout|Layout]] — Calculates the exact position (x,y) and size of each element in the render tree using the CSS box model
- [[painting|Painting]] — Converts layout output into actual pixels drawn into bitmap layers for compositing
- [[compositing|Compositing]] — Combines multiple painted layers into a single image for display, handled by the GPU
- [[gpu-rendering|GPU Rendering]] — Uses the GPU to accelerate painting and compositing for smooth 60+ FPS animations and scrolling
- [[browser-autocomplete|Browser Autocomplete]] — Suggests URLs locally as you type using history, bookmarks, cookies, and popular queries

### Vim (dev)

- [[vim-modes|Vim Modes]] — Modal editing: Normal, Insert, Visual; the fundamental design
- [[vim-basic-commands|Vim Basic Survival Commands]] — Five core Normal-mode commands: insert text, delete characters, save, and quit
- [[vim-text-objects|Vim Text Objects]] — Select delimited content with two-character commands: ci", da", yi(
- [[vim-visual-selection|Vim Visual Selection]] — v, V, <C-v> for selecting text ranges then applying operators
- [[vim-search-navigation|Vim Search and Navigation]] — Granular movement commands: character, word, line, search, and screen-level navigation
- [[vim-rectangular-blocks|Vim Rectangular Blocks]] — Block-wise visual mode selects rectangular columns across multiple lines
- [[vim-repetition|Vim Repetition]] — Two mechanisms: dot command repeats the last change; numeric prefixes repeat commands N times
- [[vim-macros|Vim Macros]] — Record and replay sequences of Normal-mode commands using registers
- [[vim-splits|Vim Splits]] — Horizontal and vertical window splits for simultaneous file viewing
- [[vim-buffers|Vim Buffers]] — A buffer is an in-memory copy of a file
- [[vim-completion|Vim Completion]] — In Insert mode, Vim provides keyword completion from the current buffer and loaded files

### Neovim LSP (dev)

- [[language-server-protocol|Language Server Protocol]] — Protocol defining communication between a code editor and a language analysis tool for code intelligence
- [[vim-lsp|vim.lsp]] — Neovim's built-in Lua framework for creating LSP clients and building LSP-powered tools
- [[lsp-configuration|LSP Configuration]] — Uses vim.lsp.config() to define server settings, with a merge chain: global → plugin → user overrides
- [[lsp-client|LSP Client]] — Neovim object representing an active connection to a language server with capabilities and state
- [[lsp-root-markers|Root Markers]] — Files or directories that Neovim uses to identify the project workspace root
- [[lsp-events|LSP Events]] — Neovim autocmd events triggered during LSP client lifecycle (attach, detach, progress, etc.)
- [[lsp-semantic-tokens|Semantic Tokens]] — LSP protocol extensions letting servers provide additional highlighting based on semantic meaning

### Front End / Back End (dev)

- [[front-end|Front End]] — Presentation layer of software that users interact with directly
- [[back-end|Back End]] — Data management and processing layer behind the scenes
- [[full-stack|Full Stack]] — Both the front end and back end together
- [[client-server-model|Client-Server Model]] — Distributed architecture where clients request services from servers
- [[api|API]] — Interface through which software components communicate
- [[client|Client]] — Computer or software that requests services from a server
- [[server|Server]] — Computer or software providing services to other computers over a network

---

### Compiler Design (dev)

- [[compiler|Compiler]] — Software translating high-level source code into low-level machine code through a multi-phase pipeline
- [[phases-of-compiler|Phases of a Compiler]] — Six phases: lexical, syntax, semantic analysis, IR gen, optimization, code gen
- [[lexical-analysis|Lexical Analysis]] — First phase scanning source characters into a token stream
- [[token|Token]] — Atomic unit of lexical analysis: token class paired with attribute value
- [[syntax-analysis|Syntax Analysis]] — Parsing token stream against a context-free grammar to build a parse tree
- [[semantic-analysis|Semantic Analysis]] — Type checking, scope resolution, and semantic rule enforcement
- [[intermediate-code-generation|Intermediate Code Generation]] — Producing machine-independent intermediate representation from annotated syntax tree
- [[code-optimization|Code Optimization]] — Semantics-preserving transformations improving IR efficiency (constant folding, CSE, loop optimizations)
- [[code-generation|Code Generation]] — Final phase producing target machine code via instruction selection, register allocation, scheduling
- [[object-code|Object Code]] — Relocatable output of compilation with symbol tables and relocation metadata
- [[compiler-pass|Compiler Pass]] — Single complete scan of source/IR; single-pass vs multi-pass compiler design
- [[compiler-construction-tools|Compiler Construction Tools]] — Lex, Yacc, Flex, Bison for automating lexer/parser generation
- [[symbol-table-in-compiler|Symbol Table in Compiler]] — Data structure storing identifier info (name, type, scope, address) used across all phases
- [[error-handling-in-compiler|Error Handling in Compiler Design]] — Detecting, reporting, and recovering from lexical, syntax, and semantic errors
- [[programming-language-generations|Programming Language Generations]] — Classification from 1GL (machine code) to 5GL (constraint/logic languages)
- [[flex-lexical-analyzer-generator|Flex — Fast Lexical Analyzer Generator]] — Tool generating DFA-based C lexers from regular expression specifications
- [[context-free-grammar|Context-Free Grammar]] — Formal system (BNF) for specifying programming language syntax via production rules
- [[first-and-follow-sets|FIRST and FOLLOW Sets]] — Terminal sets computed from CFG for constructing predictive parsing tables
- [[ambiguous-grammar|Ambiguous Grammar]] — Grammar with multiple parse trees for the same input; resolved via precedence/associativity
- [[parser-introduction|Parser Introduction]] — Component performing syntax analysis; classified as top-down (LL) or bottom-up (LR)
- [[top-down-parsing|Top-Down Parsing]] — Builds parse tree from root to leaves; recursive descent and LL(1) predictive parsing
- [[bottom-up-parsing|Bottom-Up Parsing]] — Builds parse tree from leaves to root using shift-reduce operations
- [[shift-reduce-parser|Shift Reduce Parser]] — Stack-based bottom-up parser with shift/reduce/accept/error actions
- [[lr-parsers|LR Parsers]] — SLR (simple), CLR (canonical), LALR (look-ahead) — increasing power vs table size trade-off
- [[operator-precedence-parser|Operator Precedence Parser]] — Simple bottom-up parser using precedence relations between operators for expression grammars
- [[syntax-directed-translation|Syntax-Directed Translation]] — Attaching semantic actions to grammar productions for type checking and code emission
- [[attributed-sdt|S-Attributed and L-Attributed SDTs]] — Classification of SDTs by attribute flow: synthesized (up) vs inherited (down/left)
- [[three-address-code|Three-Address Code]] — IR form with ≤3 operands per instruction; flat sequence ideal for optimization
- [[loop-detection-in-tac|Detection of a Loop in TAC]] — Dominator-based loop identification in control-flow graphs for optimization
- [[code-generator-design-issues|Issues in Code Generator Design]] — Instruction selection, register allocation, addressing modes, scheduling
- [[data-flow-analysis|Data Flow Analysis]] — Collecting reaching definitions, live variables, available expressions via data-flow equations
- [[static-and-dynamic-scoping|Static and Dynamic Scoping]] — Compile-time (lexical nesting) vs runtime (call stack) variable binding
- [[runtime-environment|Runtime Environment]] — Call stack, heap, activation records, and runtime system for executing compiled programs
- [[linker-and-loader|Linker and Loader]] — Symbol resolution, relocation (linker); memory loading and execution start (loader)
- [[storage-allocation-strategies|Storage Allocation Strategies]] — Static (globals), stack (locals), heap (dynamic) allocation for different data lifetimes
- [[working-of-lexical-analyzer|Working of Lexical Analyzer]] — Input buffering, lookahead, and maximal munch in lexer tokenization
- [[classification-of-context-free-grammars|Classification of Context-Free Grammars]] — Ambiguous/unambiguous, LL(k), LR(k) grammar class hierarchy
- [[recursive-descent-parser|Recursive Descent Parser]] — Hand-written top-down parser with one function per non-terminal
- [[predictive-parser|Predictive Parser]] — Table-driven non-recursive LL(1) parser using a parsing table and stack
- [[ll1-parsing-table|LL(1) Parsing Table]] — Construction from FIRST and FOLLOW sets for predictive parsing
- [[ll1-parsing-algorithm|LL(1) Parsing Algorithm]] — Stack-based algorithm driving the LL(1) predictive parser
- [[lr0-parser|LR(0) Parser]] — Simplest LR variant using LR(0) items with zero lookahead
- [[sdt-schemes|SDT Schemes]] — Semantic actions embedded in grammar productions for controlled execution order
- [[application-of-sdts|Application of SDTs]] — Practical SDT uses: infix-to-postfix, type checking, code emission
- [[basic-blocks|Basic Blocks]] — Straight-line code sequences in TAC with single entry and single exit
- [[control-flow-graph|Control Flow Graph]] — Directed graph of basic blocks for global program analysis
- [[peephole-optimization|Peephole Optimization]] — Local target-level optimization via small-window pattern matching
- [[common-subexpression-elimination|Common Subexpression Elimination]] — Detecting and replacing redundant expression computations
- [[constant-propagation|Constant Propagation]] — Replacing variable uses with compile-time-known constant values
- [[liveliness-analysis|Liveliness Analysis]] — Backward data-flow analysis determining which variables are live at each point

**Compiler Design Syntheses:**

- [[single-pass-vs-multi-pass|Single-Pass vs Multi-Pass Compiler]] — Compilation speed vs code quality trade-off in pass organization
- [[compiler-vs-interpreter|Compiler vs Interpreter]] — Ahead-of-time translation vs line-by-line execution with modern JIT hybrids
- [[parsing-techniques-compared|Parsing Techniques Compared]] — Comparing LL(1), LR(0), SLR, CLR, and LALR across power, table size, and use cases
- [[optimization-techniques-compared|Code Optimization Techniques Compared]] — Comparing peephole, CSE, constant propagation, and liveliness analysis

---

### Computer Networks — Fundamentals (networking)

- [[protocol|Network Protocol]] — Set of rules, formats, and procedures that define how devices communicate
- [[service|Network Service]] — Abstract description of the capabilities that a lower layer provides to the layer directly above it
- [[service-access-point|Service Access Point]] — Interface point between two adjacent protocol layers where the upper layer requests services from the lower layer
- [[service-primitives|Service Primitives]] — Set of operations available at a SAP for requesting services, receiving indications, and confirming operations
- [[layered-model|Layered Model]] — Conceptual framework dividing network functionality into layers, each providing services to the layer above
- [[encapsulation|Encapsulation]] — Wrapping data with layer-specific headers as it moves down the protocol stack
- [[decapsulation|Decapsulation]] — Removing layer-specific headers and trailers as data moves up the protocol stack
- [[connection-oriented-service|Connection-Oriented Service]] — Establishes a dedicated logical connection before exchanging data, guaranteeing reliable, ordered delivery
- [[connectionless-service|Connectionless Service]] — Packets sent independently without connection setup, offering best-effort delivery with no guarantees
- [[stateful-protocol|Stateful Protocol]] — Endpoints maintain persistent information about the connection across multiple packet exchanges
- [[full-duplex|Full-Duplex Communication]] — Both endpoints can send and receive data simultaneously
- [[datagram|Datagram]] — Self-contained, independent packet in a connectionless service carrying its own addressing
- [[virtual-circuit|Virtual Circuit]] — Logical connection where packets follow the same path using pre-established routing state

### Transport & Reliability (networking)

- [[tcp|TCP]] — Connection-oriented, reliable transport protocol providing ordered, error-checked, flow-controlled, congestion-controlled byte-stream delivery
- [[udp|UDP]] — Connectionless, unreliable transport protocol sending independent datagrams with minimal overhead
- [[three-way-handshake|Three-Way Handshake]] — Three-message exchange (SYN, SYN-ACK, ACK) establishing a TCP connection by synchronizing sequence numbers
- [[stop-and-wait|Stop-and-Wait Protocol]] — Simple reliable protocol: sender transmits one packet then waits for acknowledgment before sending the next
- [[sliding-window-protocol|Sliding Window Protocol]] — Allows sender to transmit multiple packets before receiving ACKs, using a window that slides forward
- [[go-back-n|Go-Back-N ARQ]] — Sliding window protocol where sender retransmits all unacknowledged packets from the lost packet onward
- [[selective-repeat|Selective Repeat ARQ]] — Sliding window protocol where only lost packets are retransmitted; correctly received out-of-order packets are buffered
- [[sequence-numbers|Sequence Numbers]] — Unique consecutive numbers assigned to each packet allowing the receiver to detect missing packets, reorder, and identify duplicates
- [[acknowledgment|Acknowledgment]] — Control message sent by receiver back to sender confirming successful receipt of data
- [[cumulative-acknowledgment|Cumulative Acknowledgment]] — Acknowledgment confirming receipt of all packets up to and including a specific sequence number
- [[negative-acknowledgment|Negative Acknowledgment]] — Control message indicating a packet was lost or corrupted and needs retransmission
- [[piggybacking|Piggybacking]] — Acknowledgments attached to outgoing data packets instead of being sent separately
- [[flow-control|Flow Control]] — Mechanism preventing a sender from transmitting data faster than the receiver can accept it
- [[congestion-control|Congestion Control]] — Algorithms detecting network congestion and reducing sending rate to prevent overwhelming the network
- [[reliable-data-transfer|Reliable Data Transfer]] — Mechanisms ensuring data is delivered completely, in order, without errors, despite network unreliability
- [[socket-api|Socket API]] — API providing functions for applications to use network services, acting as the SAP between application and transport layers

### Network Layer & Infrastructure (networking)

- [[ip-protocol|IP Protocol]] — Fundamental network-layer protocol providing logical addressing and routing packets across networks
- [[dns|DNS (networking)]] — Distributed hierarchical system translating human-readable domain names into IP addresses
- [[icmp|ICMP]] — Network-layer protocol used by routers and hosts to send error messages and operational information about IP packet processing
- [[arp|ARP]] — Protocol resolving IP addresses to MAC addresses within a local network by broadcasting a request and receiving a unicast reply

### Link Layer & Access Control (networking)

- [[csma|CSMA]] — Protocol where devices listen to the channel before transmitting, reducing but not eliminating collisions
- [[csma-cd|CSMA/CD (networking)]] — Extension of CSMA that detects collisions during transmission and immediately stops, then uses backoff before retrying
- [[binary-exponential-backoff|Binary Exponential Backoff]] — Algorithm where the maximum random wait time doubles after each successive collision
- [[jam-signal|Jam Signal]] — Special signal sent immediately after a collision is detected, ensuring all devices become aware and stop transmitting
- [[best-effort-delivery|Best Effort Delivery]] — Network makes its best effort to deliver packets but provides no guarantees

### Data Link Protocols (networking)

- [[ppp-protocol|PPP Protocol]] — Data link layer protocol suite for direct connections providing link establishment, authentication, and multiprotocol support
- [[lcp|LCP]] — Protocol within the PPP suite responsible for establishing, configuring, testing, and terminating the data link connection
- [[ncp|NCP]] — Family of protocols within the PPP suite that configure network-layer protocols to run over the established PPP link

### Network Switching (networking)

- [[circuit-switching|Circuit Switching]] — Before any data is sent, a dedicated physical path is established through the network from source to destination
- [[packet-switching|Packet Switching]] — Data broken into small packets; each carries destination address and packets from different conversations share the same links
- [[broadcast-links|Broadcast Links]] — Every machine on the network receives every transmission; each packet contains an address field specifying the intended recipient

### Backend Networking (networking)

- [[ip-address|IP Address]] — Numerical identifier assigned to each device connected to a computer network
- [[port|Port]] — 16-bit number (0-65535) that identifies a specific service or application on a machine
- [[socket|Socket]] — Communication endpoint between two machines, uniquely identified by the 4-tuple: (client IP, client port, server IP, server port)
- [[tcp-handshake|TCP Handshake]] — Three-way handshake establishes reliable TCP connection: SYN → SYN-ACK → ACK
- [[tls-handshake|TLS Handshake]] — Negotiation process where client and server agree on encryption methods, exchange keys, and verify identities
- [[http-protocol|HTTP Protocol]] — Text-based request-response protocol defining how clients and servers exchange messages
- [[dns|DNS (Backend)]] — The phonebook of the internet — translates domain names to IP addresses

### HTTP / Web (networking)

- [[http|HTTP]] — Standardized language enabling any client to communicate with any server, regardless of technology stack
- [[statelessness|Statelessness]] — Each HTTP request contains all information needed for the server to process it
- [[http-methods|HTTP Methods]] — Define the intent of a request (GET, POST, PUT, DELETE, etc.)
- [[http-headers|HTTP Headers]] — Key-value pairs providing metadata about the request or response
- [[http-status-codes|HTTP Status Codes]] — Standardized three-digit numbers communicating the outcome of a request
- [[http-versions|HTTP Versions]] — Four major versions: 1.0 (new connection) → 1.1 (persistent) → 2.0 (multiplexing) → 3.0 (QUIC/UDP)
- [[cors|CORS]] — Mechanism letting servers explicitly declare which domains can access their resources and under what conditions

### DNS Deep Dive (networking)

- [[dns-lookup|DNS Lookup]] — Translates a human-readable domain name into a machine-readable IP address via caches and hierarchical servers
- [[dns-cache|DNS Cache]] — Stores resolved domain-to-IP mappings at browser, OS, router, and ISP levels to skip full lookups
- [[dns-hierarchy|DNS Hierarchy]] — Hierarchical distributed database (Root → TLD → Authoritative) making DNS scalable and fault-tolerant
- [[dns-root-server|DNS Root Server]] — 13 logical servers at the top of the DNS hierarchy that know the locations of all TLD servers
- [[dns-tld-server|DNS TLD Server]] — Manages all domains under a specific extension (.com, .org) and points to their authoritative servers
- [[dns-authoritative-server|DNS Authoritative Server]] — Holds the actual DNS records for a domain and returns the real IP address
- [[recursive-dns|Recursive DNS]] — Resolver server that performs the full DNS lookup (root → TLD → authoritative) on behalf of clients

### URL to Rendering (networking)

- [[url-parsing|URL Parsing]] — Breaks a URL string into protocol, domain, path, query parameters, and fragments for routing
- [[url-to-rendering-flow|URL to Rendering — Full Flow Analysis]] — Synthesis tracing the complete path from key press to pixels, integrating hardware, OS, network, and browser layers
- [[http-request|HTTP Request]] — Structured client-to-server message with method, path, headers, and optional body
- [[http-response|HTTP Response]] — Server's reply containing status code, headers, and body (HTML, JSON, etc.)
- [[tcp-packet-drop|TCP Packet Drop]] — TCP detects lost packets via timeout or duplicate ACKs and retransmits them for reliable delivery
- [[mac-address|MAC Address]] — 48-bit hardware identifier burned into a NIC, used by Ethernet/Wi-Fi for local network delivery
- [[arp-protocol|ARP Protocol]] — Translates IP addresses to MAC addresses on local networks via broadcast query and unicast reply
- [[network-byte-order|Network Byte Order]] — Big Endian — the standard byte order mandated by TCP/IP protocols for all data transmitted over the network

### Wireless / Mobile Networks (networking)

- [[wireless-network|Wireless Network]] — Communication networks using radio waves through air instead of cables, managing shared unreliable channels with mobility
- [[multipath-propagation|Multipath Propagation]] — Radio signals arriving at the receiver via multiple paths with different delays, causing ISI and fading
- [[channel-fading|Channel Fading]] — Variations in received signal strength caused by constructive/destructive interference from multipath propagation
- [[modulation|Modulation]] — Encoding digital information onto high-frequency carrier waves by varying amplitude, frequency, or phase
- [[multiplexing|Multiplexing]] — Combining multiple signals into a shared medium via space (SDMA), frequency (FDMA), time (TDMA), or code (CDMA)
- [[spread-spectrum|Spread Spectrum]] — Modulation technique spreading signals across wider bandwidth for interference resistance, stealth, and CDMA capability
- [[frequency-shift-keying|Frequency Shift Keying]] — Digital modulation technique encoding binary data by shifting carrier frequency between two values
- [[minimum-shift-keying|Minimum Shift Keying]] — Continuous-phase FSK technique with minimum orthogonal frequency separation, eliminating phase discontinuities
- [[antenna-types|Antenna Types]] — Classified by radiation pattern: isotropic, dipole, directional, sectorized, and diversity
- [[frequency-reuse|Frequency Reuse]] — Using the same radio frequencies in geographically separated, non-adjacent cells to massively increase capacity
- [[cellular-mobile-system|Cellular Mobile System]] — Dividing geographical areas into small cells with low-power base stations to increase capacity via frequency reuse
- [[cell-sectoring|Cell Sectoring]] — Dividing cells into directional sectors to reduce co-channel interference and increase capacity
- [[co-channel-interference|Co-Channel Interference]] — Interference between cells using the same frequency, constrained by the Carrier-to-Interference ratio
- [[handoff|Handoff]] — Transferring active calls between base stations as users move, either hard (break-before-make) or soft (make-before-break)
- [[hidden-terminal-problem|Hidden Terminal Problem]] — Two nodes out of each other's range both transmit to a common receiver, causing undetectable collisions
- [[exposed-terminal-problem|Exposed Terminal Problem]] — Node unnecessarily defers transmission when it detects a neighbor's signal, even though its own transmission would not cause interference
- [[near-far-terminal|Near/Far Terminal Effect]] — Strong nearby transmitter drowning out weak distant transmitter at the same receiver due to path loss
- [[maca|MACA Protocol]] — MAC protocol solving hidden terminal problem via RTS/CTS handshake that announces reservation zones
- [[dama|DAMA Protocol]] — Dynamic channel allocation combining random access for requests and fixed assignment for data transmission
- [[code-division-multiple-access|CDMA]] — Spread-spectrum technology where all users share the same frequency simultaneously, distinguished by unique orthogonal codes
- [[gsm|GSM (Global System for Mobile Communications)]] — 2G digital cellular standard introducing encryption, international roaming, and SIM cards using TDMA/FDMA
- [[gsm-architecture|GSM Architecture]] — Three hierarchical subsystems: RSS (radio), NSS (switching/routing), and OSS (operations/security)
- [[gsm-services|GSM Services]] — Three service categories: bearer services (data transport), tele services (end-user apps), and supplementary services (call enhancements)
- [[gprs|GPRS]] — Adding packet-switched data capability to GSM's circuit-switched voice network for mobile internet
- [[ieee-802-11|IEEE 802.11]] — Wireless LAN standard using CSMA/CA with RTS/CTS for collision avoidance over radio waves
- [[bluetooth|Bluetooth]] — Wireless personal area network standard for short-range device-to-device communication in the 2.4 GHz band using FHSS
- [[zigbee|ZigBee]] — Ultra-low-power WPAN standard (IEEE 802.15.4) for battery-powered IoT sensors with years of battery life
- [[wimax|WiMAX]] — Metropolitan-area wireless broadband standard (IEEE 802.16) providing up to 75 Mbps over 50 km using OFDM
- [[mobile-ad-hoc-network|Mobile Ad Hoc Network]] — Self-configuring network of mobile devices routing data through each other without infrastructure
- [[mobile-tcp|Mobile TCP]] — TCP adaptations (I-TCP, snooping TCP, fast retransmit) that handle wireless link packet loss misattributed as congestion

**Wireless Syntheses:**

- [[modulation-techniques-compared|Modulation Techniques Compared]] — Comparison of FSK, MSK, and GMSK showing progression from discontinuous-phase to continuous-phase modulation
- [[wireless-mac-problems-compared|Wireless MAC Problems Compared]] — Synthesis comparing hidden terminal, exposed terminal, and near/far problems that cause wired CSMA/CD to fail in wireless

---

### AI / Image Generation (ai)

- [[neural-networks|Neural Networks]] — Computing systems inspired by biological neurons that learn by adjusting connection weights between layers of artificial neurons
- [[transformers|Transformers]] — Use self-attention mechanisms to process all tokens in a sequence simultaneously, enabling parallel training and capturing long-range relationships
- [[diffusion-models|Diffusion Models]] — Work by learning to reverse a gradual noising process to generate images from random noise
- [[vae|Variational Autoencoder]] — Compresses an image into a smaller latent representation, works with that compressed version during generation, then decompresses back
- [[clip|CLIP Text Encoder]] — Uses contrastive learning to align the vector representation of an image with its corresponding text description
- [[t5-encoder|T5 Text Encoder]] — Pure language model trained on massive text corpora that maintains character-level information
- [[flux-architecture|Flux Architecture]] — Modern diffusion model using DiT architecture instead of UNet, dual text encoders, and a 16-channel VAE
- [[lora-finetuning|LoRA Fine-tuning]] — Adds small adapter weights to a pre-trained model instead of updating all parameters
- [[controlnet|ControlNet]] — Additional neural network running in parallel with the diffusion model, taking extra input and adding spatial constraints
- [[glyph-injection|Glyph Injection via ControlNet]] — Don't ask the model to generate letters — give it the exact letter shapes as a spatial constraint
- [[text-rendering-problem|Text Rendering Problem in Diffusion Models]] — Three separate problems occurring at three different layers: character-blind encoder, semantic drift, VAE stroke loss
- [[hybrid-pipeline|Hybrid LLM-Guided Diffusion Pipeline]] — Combines an LLM for language understanding with a diffusion model for pixel synthesis

**AI Syntheses:**

- [[text-rendering-solutions|Text Rendering Solutions — Layer by Layer]] — Combines three core concepts to show how the text rendering problem is solved across multiple architectural layers

### Data Science / ML (ml)

- [[data-science|Data Science]] — Interdisciplinary field combining statistics, programming, and domain expertise to extract knowledge from structured and unstructured data
- [[data-wrangling|Data Wrangling]] — Process of cleaning, structuring, and enriching raw data into a usable format for analysis and modeling
- [[data-cleaning|Data Cleaning]] — Identifying and fixing errors, inconsistencies, and missing values in a dataset to make it suitable for analysis
- [[data-transformation|Data Transformation]] — Converting data from one format, structure, or scale to another to make it suitable for analysis and modeling
- [[exploratory-data-analysis|Exploratory Data Analysis]] — Iterative process of summarizing, visualizing, and understanding data to formulate hypotheses and guide modeling
- [[data-visualization|Data Visualization]] — Representing data graphically to enable pattern recognition, comparison, and communication of insights
- [[feature-engineering|Feature Engineering]] — Creating new input variables from raw data that make machine learning algorithms work better
- [[data-modeling|Data Modeling]] — Process of selecting, training, and evaluating machine learning algorithms to make predictions or discover patterns
- [[supervised-learning|Supervised Learning]] — Models learn a mapping from input features to output labels using labeled training examples
- [[unsupervised-learning|Unsupervised Learning]] — Models find patterns, structure, or reduced representations in unlabeled data
- [[regression|Regression]] — Supervised learning task predicting a continuous numeric output variable from input features
- [[classification|Classification]] — Supervised learning task predicting a discrete categorical label from input features
- [[train-test-split|Train-Test Split]] — Dividing a dataset into separate subsets for training and testing to detect overfitting
- [[overfitting|Overfitting]] — Model learns training data too well, including noise and idiosyncrasies, resulting in poor generalization to new data
- [[underfitting|Underfitting]] — Model is not complex enough to capture the true patterns in the data, resulting in poor performance everywhere
- [[cross-validation|Cross-Validation]] — Resampling technique that repeatedly splits data into train and validation sets for robust performance estimation
- [[prophet-forecasting|Prophet Forecasting]] — Facebook Prophet is a time-series forecasting library designed for business data with strong seasonal patterns

**Decision Trees (ml):**

- [[decision-tree-structure|Decision Tree Structure]] — Hierarchical tree with root (first split), internal nodes (attribute tests), branches (outcomes), leaves (predictions)
- [[root-node|Root Node]] — Topmost node performing the first and most impactful attribute split on the full dataset
- [[internal-node|Internal Node]] — Intermediate decision points testing a specific feature and routing data to child branches
- [[leaf-node|Leaf Node]] — Terminal nodes holding final predictions: class labels (classification) or continuous values (regression)
- [[decision-tree-splitting|Decision Tree Splitting]] — Partitioning node data into subsets based on attribute values to increase purity
- [[entropy|Entropy]] — Measure of uncertainty/impurity: 0 = pure, 1 = maximum uncertainty (binary classification)
- [[entropy-calculation|Entropy Calculation]] — Step-by-step computation: count classes, compute proportions, apply log₂, sum, negate
- [[information-gain|Information Gain]] — Reduction in entropy after a split; highest IG attribute is chosen for splitting
- [[information-gain-calculation|Information Gain Calculation]] — IG = Entropy(parent) - weighted average of Entropy(children)
- [[gini-index|Gini Index]] — Probability that a random element would be misclassified; 1 - Σpᵢ², default in sklearn
- [[gini-index-properties|Gini Index Properties]] — Six characteristics: squared probabilities, faster than entropy, favors equal-sized splits
- [[attribute-selection-measures|Attribute Selection Measures]] — Mathematical criteria (IG, Gini) to evaluate and rank candidate attributes at each node
- [[recursive-tree-building|Recursive Tree Building]] — Top-down algorithm: start at root, select best attribute, recurse on children until stopping conditions
- [[node-purity|Node Purity]] — How homogeneous a subset is; pure = all same class; goal of every split
- [[decision-tree-prediction|Decision Tree Prediction]] — Traverse root-to-leaf by evaluating node tests; O(depth) inference time
- [[decision-tree-stopping-conditions|Decision Tree Stopping Conditions]] — Three conditions: pure class, no attributes left, no instances
- [[decision-tree-interpretability|Decision Tree Interpretability]] — Trees are white-box models; every prediction is a traceable if-then rule
- [[decision-tree-preprocessing|Decision Tree Preprocessing]] — Trees need minimal preprocessing: no scaling, no encoding, handles mixed types
- [[decision-tree-flexibility|Decision Tree Flexibility]] — Same framework supports classification and regression with mixed feature types
- [[id3-algorithm|ID3 Algorithm]] — Foundational algorithm using Information Gain, top-down recursion, and three stopping conditions

**Decision Tree Syntheses (ml):**

- [[entropy-vs-gini|Entropy vs Gini — Impurity Measures Compared]] — Information-theoretic rigor vs computational efficiency; nearly identical results in practice

### Data Engineering / Analytics (database)

- [[star-schema|Star Schema]] — Denormalized data modeling approach where a central fact table is surrounded by dimension tables
- [[fact-table|Fact Table]] — Central table in a star schema, containing measurable business events with foreign keys to dimension tables
- [[dimension-table|Dimension Table]] — Denormalized table containing descriptive attributes about a business entity
- [[data-warehouse|Data Warehouse]] — Separate analytical database optimized for read-heavy queries
- [[etl-pipeline|ETL Pipeline]] — Three-phase data pipeline that reads raw data, applies transformations, and loads it into a data warehouse
- [[sql-database|SQL Database]] — Stores data in rigidly defined tables with rows and columns
- [[nosql-database|NoSQL Database]] — Stores data in flexible, schema-less formats: documents (JSON-like), key-value pairs, wide-column stores, or graphs
- [[rfm-segmentation|RFM Segmentation]] — Customer segmentation technique scoring each customer on three dimensions: Recency, Frequency, and Monetary
- [[customer-lifetime-value|Customer Lifetime Value]] — Total revenue expected from a customer over their entire relationship with the company
- [[apache-airflow|Apache Airflow]] — Workflow orchestration platform that defines pipelines as directed acyclic graphs (DAGs) of tasks
- [[docker-compose|Docker Compose]] — Tool for defining and running multi-container applications

**Data Warehousing Fundamentals (database):**

- [[data-warehouse-definition|Data Warehouse Definition]] — Inmon's 4 pillars: subject-oriented, integrated, time-variant, nonvolatile
- [[subject-oriented-dwh|Subject-Oriented DWH]] — Organizing data around business subjects (Customer, Product, Sales) rather than applications
- [[integrated-dwh|Integrated DWH]] — Resolving format inconsistencies across heterogeneous sources into a uniform structure
- [[time-variant-dwh|Time-Variant DWH]] — Storing historical data (5-10 years) with time elements in every record
- [[nonvolatile-dwh|Nonvolatile DWH]] — Read-only after load; no UPDATE/DELETE, only initial loading and querying
- [[oltp-vs-olap|OLTP vs OLAP]] — Transaction processing (current, ER model, CRUD) vs analytical processing (historical, star schema, read-only)
- [[three-tier-dwh-architecture|Three-Tier DWH Architecture]] — Bottom (storage), Middle (OLAP engine), Top (presentation tools)
- [[dwh-gateway|DWH Gateway]] — ODBC, JDBC, OLE-DB providing uniform API access to heterogeneous sources
- [[etl-pipeline-dwh|ETL Pipeline (DWH)]] — Four-phase backend: Extract, Transform (clean/standardize), Load (batch), Refresh (sync)
- [[data-extraction|Data Extraction]] — Gathering raw "as is" data from production, legacy, office, external, and metadata sources
- [[data-scrubbing|Data Scrubbing]] — Standardizing values, units, names, and entities across disparate source formats
- [[enrichment-dwh|Enrichment]] — Augmenting operational data with external sources (surveys, demographics)
- [[conditioning-dwh|Conditioning]] — Converting source data types to warehouse target types
- [[scoring-dwh|Scoring]] — Computing probability scores for events (e.g., purchase likelihood) during ETL
- [[householding-dwh|Householding]] — Grouping records by address to eliminate redundant communications and reduce costs
- [[loading-dwh|Loading (DWH)]] — Batch load with integrity checks, sorting, and checkpoint-based failure recovery
- [[dwh-refresh|DWH Refresh]] — Periodic synchronization via Data Shipping (triggers) or Transaction Shipping (log scanning)
- [[dwh-server-models|DWH Server Models]] — Enterprise (centralized), Tiered (with data marts), Virtual (logical query layer)
- [[data-mart-types|Data Mart Types]] — Dependent (top-down from DWH), Independent (bottom-up from sources), Hybrid (both paths)
- [[snowflake-schema|Snowflake Schema]] — Normalized star schema where dimension tables are split to reduce redundancy
- [[fact-constellation-schema|Fact Constellation Schema]] — Multiple fact tables sharing common dimension tables (Galaxy Schema)
- [[multidimensional-data-model|Multidimensional Data Model]] — Organizing data as N-dimensional cubes with facts at cell intersections
- [[olap-operations|OLAP Operations]] — Roll-up (aggregate), Drill-down (detail), Slice (1D filter), Dice (multi-D filter), Pivot (rotate)
- [[olap-servers|OLAP Servers]] — ROLAP (relational, dynamic SQL), MOLAP (pre-computed cubes), HOLAP (hybrid), Specialized SQL
- [[rolap-server|ROLAP Server]] — Relational storage with dynamic SQL generation; scalable but slow
- [[molap-server|MOLAP Server]] — Pre-computed MDDB cubes; fastest response but limited volume and proprietary
- [[holap-server|HOLAP Server]] — ROLAP for detail + MOLAP for aggregations; best of both worlds
- [[metadata-in-dwh|Metadata in DWH]] — Business, Technical, and Operational metadata as the warehouse's roadmap
- [[metadata-repository|Metadata Repository]] — Centralized store of structure definitions, business terms, lineage, and performance data
- [[metadata-management-challenges|Metadata Management Challenges]] — Scattered formats, no industry standards, vendor silos
- [[dwh-application-areas|DWH Application Areas]] — Finance, Insurance, Telecom, Transport, Consumer Goods, Utilities, Data Services
- [[dwh-benefits|DWH Benefits]] — Fast aggregates, cross-segment analysis, simplified queries, OLTP relief, historical analysis
- [[dwh-scale|DWH Scale]] — Terabytes (Walmart) → Petabytes (GIS) → Exabytes (Medical) → Zettabytes (Weather)
- [[dwh-evolution|DWH Evolution]] — 60s batch → 70s terminal → 80s desktop → 90s warehouse + OLAP

**DWH Syntheses:**

- [[schema-comparison|Star vs Snowflake vs Galaxy]] — Query simplicity vs storage efficiency vs modeling expressiveness
- [[olap-server-comparison|ROLAP vs MOLAP vs HOLAP]] — Computation timing: query-time vs load-time vs hybrid
- [[inmon-vs-kimball|Inmon vs Kimball]] — Top-down (enterprise first) vs bottom-up (data marts first)

---

### I/O System (systems)

- [[io-system|I/O System]] — OS subsystem managing communication between the CPU and external devices, providing abstraction layers so applications can perform I/O without knowing hardware details
- [[io-software-structure|I/O Software Structure]] — Four layers: user-level, device-independent, drivers, interrupt handlers — each handling a specific abstraction level
- [[io-request-to-hardware|I/O Request to Hardware Operation]] — Multi-step process where request flows down through I/O software layers, gets translated into hardware commands, executes, and returns data via interrupts
- [[device-driver|Device Driver]] — Software module translating generic OS I/O commands into device-specific instructions, acting as intermediary between OS and hardware
- [[device-controller|Device Controller]] — Hardware component interfacing between the system bus and the physical I/O device, containing registers and local buffers
- [[device-independent-io-software|Device-Independent I/O Software]] — Provides uniform interface to user-level software, handling device naming, protection, buffering, and error reporting
- [[user-level-io-software|User-Level I/O Software]] — Topmost layer providing system calls and library functions (read(), write(), fopen()) for applications
- [[interrupt-handler|Interrupt Handler]] — Special function executing when a device raises an interrupt, allowing CPU to respond asynchronously to I/O completion
- [[polling|Polling]] — CPU repeatedly checks a device's status register in a loop until the device is ready, instead of using interrupts
- [[dma|DMA]] — Allows I/O devices to transfer data directly to/from memory without CPU intervention, freeing the CPU for other tasks
- [[io-devices|I/O Devices]] — Classified by function (input/output/storage/communication) and data transfer mode (block vs character vs stream)
- [[block-driver|Block Driver]] — Handles block-oriented devices, managing block-sized data transfers, supporting random access and buffering
- [[character-driver|Character Driver]] — Handles byte-stream devices, managing sequential data transfer one character/byte at a time
- [[network-driver|Network Driver]] — Manages network interface cards (NICs), handling packet send/receive, DMA for packet buffers, and hardware acceleration
- [[system-bus|System Bus]] — Shared communication pathway connecting CPU, memory, and I/O controllers: data bus, address bus, control bus
- [[buffering|Buffering]] — Use of temporary storage in memory to hold data while being transferred between devices or between device and application

### Secondary Storage (systems)

- [[disk-structure|Disk Structure]] — Hard disk consists of platters, tracks, sectors, cylinders, and read/write heads — the physical organization determining data access
- [[disk-scheduling|Disk Scheduling]] — Algorithms deciding the order to service pending I/O requests to minimize seek time and improve throughput
- [[disk-management|Disk Management]] — Partitioning (dividing disks), formatting (creating file systems), and error handling (bad block management)
- [[swap-space|Swap Space]] — Portion of disk used as an extension of RAM — inactive pages are moved from RAM to disk to free memory
- [[raid|RAID]] — Combines multiple physical disks into a logical unit to provide redundancy (data safety) and/or improved performance
- [[fcfs|FCFS]] — First Come First Serve disk scheduling; processes requests in the exact order they arrive
- [[sstf|SSTF]] — Shortest Seek Time First; always picks the request closest to the current disk head position, minimizing seek time
- [[scan-scheduling|SCAN Scheduling]] — Elevator algorithm; moves the disk arm in one direction servicing requests, then reverses
- [[c-scan|C-SCAN]] — Services requests in one direction only, then jumps back to the beginning without servicing on the return trip
- [[look-scheduling|LOOK Scheduling]] — SCAN variant; only goes as far as the last request in each direction, then reverses
- [[c-look|C-LOOK]] — Circular LOOK; combines C-SCAN (one direction) with LOOK (stop at last request) for uniform wait times

### Memory Management (systems)

- [[paging|Paging]] — Divides processes into fixed-size pages and RAM into page frames, allowing non-contiguous allocation and eliminating external fragmentation
- [[page-table|Page Table]] — Data structure maintained by the OS that maps each virtual page of a process to its physical frame in RAM
- [[page-fault|Page Fault]] — Occurs when a program accesses a page not loaded in RAM, triggering the OS to fetch the page from disk
- [[demand-paging|Demand Paging]] — Loads pages from disk only when they are first accessed (on-demand), reducing RAM usage and startup time
- [[tlb|TLB]] — Hardware cache storing recent virtual-to-physical page translations, making address translation O(1) in the common case
- [[virtual-memory|Virtual Memory]] — Gives each process the illusion of a large, contiguous address space, mapped to physical RAM via paging, with unused pages on disk
- [[segmentation|Segmentation]] — Divides memory into variable-size logical units (segments) like code, data, stack, each with a segment table mapping to physical memory
- [[thrashing|Thrashing]] — State where the OS spends most of its time handling page faults and swapping, leaving little CPU time for actual process execution

### Concurrency (systems)

- [[semaphore|Semaphore]] — Integer variable with two atomic operations (wait/signal) used to control access to shared resources and prevent race conditions
- [[binary-semaphore|Binary Semaphore]] — Can only take values 0 (locked) and 1 (unlocked), used for mutual exclusion of critical sections
- [[counting-semaphore|Counting Semaphore]] — Can take values 0 to N, where N is the number of available resources in the pool
- [[wait-operation|wait Operation]] — Decrements the semaphore value atomically; if the result is negative, the process blocks and waits
- [[signal-operation|signal Operation]] — Increments the semaphore value atomically; if there are waiting processes (S ≤ 0), one is woken up
- [[producer-consumer|Producer-Consumer Problem]] — Classic synchronization problem solved using three semaphores: empty, full, and mutex
- [[reader-writer|Reader-Writer Problem]] — Synchronization problem where multiple readers can read simultaneously, but a writer requires exclusive access

### Hashing (systems)

- [[hashing|Hashing]] — Uses a hash function to map keys to array indices, providing O(1) average-case insert, search, and delete operations
- [[hash-function|Hash Function]] — Maps keys to integer values such that equal keys always produce the same hash, and distribution is as uniform as possible
- [[collision-resolution|Collision Resolution]] — Handles cases where multiple keys map to the same index, using either chaining (linked lists) or probing (search for next slot)
- [[separate-chaining|Separate Chaining]] — Each slot in the hash table holds a linked list of all key-value pairs that hashed to that index
- [[linear-probing|Linear Probing]] — On collision, checks the next slot (index+1, +2, ...) until an empty slot is found, wrapping around if needed
- [[quadratic-probing|Quadratic Probing]] — Uses a quadratic function (i²) to determine probe sequence: h(k), h(k)+1², h(k)+2², ...
- [[double-hashing|Double Hashing]] — Uses two hash functions; the second hash determines the step size for probing, giving each key a unique probe sequence
- [[load-factor|Load Factor]] — Ratio of elements stored to total table size: α = elements/table_size; keep ≤0.7 for good performance

### Computer Architecture (systems)

- [[instruction-set|Instruction Set]] — Complete collection of machine-level instructions that a CPU can execute — the boundary between software and hardware
- [[operand|Operand]] — The data or the location of data that a CPU instruction operates on
- [[addressing-mode|Addressing Mode]] — Defines how a CPU instruction specifies the location of its operands — in registers, memory, or as immediate values
- [[immediate-addressing|Immediate Addressing]] — Embeds the operand value directly inside the instruction itself
- [[direct-addressing|Direct Addressing]] — Specifies the exact memory address of the operand within the instruction
- [[indirect-addressing|Indirect Addressing]] — Specifies a register (or memory location) that holds the address of the operand
- [[register-addressing|Register Addressing]] — Specifies a CPU register as the operand location
- [[register-indirect-with-displacement|Register Indirect with Displacement]] — Computes the effective address by adding a register value (base) and a constant displacement (offset)
- [[indexed-addressing|Indexed Addressing]] — Computes the effective address by adding a base address (from instruction) and an index value (from a register)
- [[relative-addressing|Relative Addressing]] — Computes the target address by adding an offset to the Program Counter (PC)
- [[stack-addressing|Stack Addressing]] — Uses the top of the stack as the operand location, with the stack pointer implicitly specifying the address
- [[pipelining|Pipelining]] — Overlaps multiple instructions in execution — while one executes, the next is being decoded, and the one after is being fetched
- [[risc-architecture|RISC Architecture]] — Small, simple instruction set where each instruction executes in one clock cycle, shifting complexity to the compiler
- [[cisc-architecture|CISC Architecture]] — Large set of complex instructions where a single instruction can perform multi-step operations
- [[programmed-io|Programmed I/O]] — CPU actively participates in every byte/word transfer between I/O devices and memory, using special I/O instructions

### DMA (systems)

- [[dma-controller|DMA Controller]] — Specialized hardware component managing data transfers between I/O devices and memory without CPU intervention, using bus mastering
- [[single-channel-dma|Single-Channel DMA]] — Only one DMA channel (and thus one device) can be active at a time
- [[multi-channel-dma|Multi-Channel DMA]] — Multiple independent DMA channels, each with its own registers, allowing multiple devices to transfer concurrently
- [[burst-mode-dma|Burst Mode DMA]] — Transfers the entire block of data in one continuous operation, holding exclusive bus control until complete
- [[cycle-stealing-mode-dma|Cycle Stealing Mode DMA]] — Transfers one byte or word at a time, releasing the bus to let the CPU run momentarily between transfers
- [[transparent-mode-dma|Transparent Mode DMA]] — Only transfers data when the CPU is not using the system bus, making the DMA operation completely invisible to the CPU

### Endianness (systems)

- [[endianness|Endianness]] — Byte order used to store multi-byte data in memory: Big Endian puts MSB first; Little Endian puts LSB first
- [[big-endian|Big Endian]] — Stores the Most Significant Byte (MSB) at the lowest memory address
- [[little-endian|Little Endian]] — Stores the Least Significant Byte (LSB) at the lowest memory address

**Systems Syntheses:**

- [[paging-vs-segmentation|Paging vs Segmentation — Memory Management Compared]] — Compare fixed-size chunks vs variable-size logical units for virtual memory
- [[hashing-performance|Hashing Performance — Collision Resolution Techniques Compared]] — Compare separate chaining, linear probing, quadratic probing, and double hashing
- [[disk-scheduling-compared|Disk Scheduling Algorithms — Performance and Trade-offs]] — Compare FCFS, SSTF, SCAN, C-SCAN, LOOK, and C-LOOK
- [[semaphore-types|Semaphore Types — Binary vs Counting Semaphores Compared]] — Compare binary semaphores (mutex) versus counting semaphores (resource pools)
- [[addressing-modes-compared|Addressing Modes Compared — Usage and Trade-offs]] — Different addressing modes efficiently access data in different scenarios: constants, registers, arrays, structs
- [[dma-modes-comparison|DMA Modes Comparison — Burst vs Cycle Stealing vs Transparent]] — Three DMA modes balancing transfer speed, CPU responsiveness, and implementation complexity
- [[endianness-comparison|Big Endian vs Little Endian Comparison]] — Two conventions for storing multi-byte data in memory with different trade-offs
- [[risc-vs-cisc|RISC vs CISC Architecture Comparison]] — Two fundamental CPU architecture approaches representing opposite philosophies about where complexity should live

### Hardware / Interrupts (systems)

- [[keyboard-interrupt|Keyboard Interrupt]] — Hardware signal sent to the CPU when a key is pressed, converting the physical keypress into a scan code
- [[os-interrupt-handler|OS Interrupt Handler]] — Function that runs when a hardware interrupt fires, reading device data and dispatching to the appropriate driver

### System Design (systems)

- [[performance-vs-scalability|Performance vs Scalability]] — Performance is speed for a single user; scalability is maintaining speed under load
- [[latency-vs-throughput|Latency vs Throughput]] — Latency is time per action; throughput is actions per unit time
- [[cap-theorem|CAP Theorem]] — In distributed systems, choose two: Consistency, Availability, Partition Tolerance
- [[cp-consistency-partition-tolerance|CP — Consistency and Partition Tolerance]] — Returns errors during partitions to guarantee consistency
- [[ap-availability-partition-tolerance|AP — Availability and Partition Tolerance]] — Returns available data during partitions, possibly stale
- [[weak-consistency|Weak Consistency]] — After a write, reads may or may not see it; best effort
- [[eventual-consistency|Eventual Consistency]] — After a write, reads will eventually see it as data replicates asynchronously
- [[strong-consistency|Strong Consistency]] — After a write, all reads see it; data replicated synchronously
- [[active-passive-failover|Active-Passive Failover]] — Standby server takes over if active fails via heartbeat monitoring
- [[active-active-failover|Active-Active Failover]] — Both servers handle traffic simultaneously, spreading load
- [[availability-nines|Availability Nines]] — Uptime measured as percentage of 9s (99.9%, 99.99%)
- [[availability-parallel-vs-sequence|Availability in Parallel vs Sequence]] — Parallel components multiply availability; sequential components reduce it
- [[dns-system-design|DNS in System Design]] — Hierarchical distributed system translating domain names to IP addresses
- [[cdn-push|Push CDN]] — Server pushes new content to CDN whenever changes occur
- [[cdn-pull|Pull CDN]] — CDN pulls content from origin on first user request
- [[layer4-load-balancing|Layer 4 Load Balancing]] — Distributes requests using transport-layer info (IP, port) via NAT
- [[layer7-load-balancing|Layer 7 Load Balancing]] — Distributes requests by inspecting application-layer content
- [[horizontal-scaling|Horizontal Scaling]] — Adding more commodity servers to distribute load
- [[reverse-proxy-pattern|Reverse Proxy]] — Centralizes internal services behind a unified public interface
- [[microservices-architecture|Microservices Architecture]] — Independently deployable small modular services
- [[service-discovery|Service Discovery]] — Dynamic service location via registry with health checks
- [[master-slave-replication|Master-Slave Replication]] — Single master for writes; slaves for reads with async replication
- [[master-master-replication|Master-Master Replication]] — Both nodes accept writes and coordinate with each other
- [[database-federation|Database Federation]] — Splitting databases by function (forums, users, products)
- [[sharding|Sharding]] — Distributing data across databases by key for horizontal scaling
- [[denormalization|Denormalization]] — Adding redundant data to avoid expensive joins
- [[sql-tuning|SQL Tuning]] — Optimizing schema, indices, and queries for database performance
- [[nosql-database-types|NoSQL Database Types]] — Four types: key-value, document, wide column, graph
- [[cache-aside|Cache-Aside]] — Application loads data into cache on demand (lazy loading)
- [[write-through-cache|Write-Through Cache]] — Cache synchronously writes data to database
- [[write-behind-cache|Write-Behind Cache]] — Cache asynchronously writes data to database
- [[refresh-ahead-cache|Refresh-Ahead Cache]] — Cache proactively refreshes entries before expiry
- [[message-queues|Message Queues]] — Receive, hold, and deliver messages asynchronously
- [[task-queues|Task Queues]] — Receive, schedule, execute, and deliver results for background jobs
- [[back-pressure|Back Pressure]] — Queue size limiting with HTTP 503 and exponential backoff
- [[rpc-remote-procedure-call|RPC]] — Remote procedure call that looks like a local call via marshaling
- [[rest-architectural-style|REST]] — Resource-oriented architectural style with stateless communication
- [[back-of-envelope-estimates|Back-of-Envelope Estimates]] — Quick capacity calculations using powers of two and latency numbers

**System Design Syntheses:**

- [[load-balancer-vs-reverse-proxy|Load Balancer vs Reverse Proxy]] — Traffic distribution vs backend abstraction compared
- [[sql-vs-nosql|SQL vs NoSQL]] — Relational vs non-relational database paradigms compared

---

### Security (security)

- [[https|HTTPS]] — HTTP over TLS/SSL encryption that wraps HTTP in an encrypted tunnel against eavesdropping and MITM attacks
- [[hsts|HSTS]] — Security policy forcing browsers to always use HTTPS for a domain, preventing protocol downgrade attacks
- [[jwt-authentication|JWT Authentication]] — Self-contained token containing user information encoded as JSON, signed cryptographically
- [[session-authentication|Session Authentication]] — Server creates a session ID, stores session data, sends session ID as a cookie, browser sends cookie with every request

### Theory of Computation (theory)

- [[theory-of-computation|Theory of Computation]] — Branch of theoretical computer science studying what problems can be solved on a model of computation using an algorithm
- [[model-of-computation|Model of Computation]] — Mathematical abstraction of a computer used to formally analyze what problems can be solved and how efficiently
- [[algorithm|Algorithm]] — Finite, unambiguous, step-by-step procedure for solving a problem or computing a function
- [[turing-machine|Turing Machine]] — Abstract machine consisting of an infinite tape, a read-write head, and a finite state control
- [[automata-theory|Automata Theory]] — Study of abstract machines and the computational problems that can be solved using these machines
- [[finite-automaton|Finite Automaton]] — Simplest computational model — a mathematical abstraction with a finite number of states that reads input and transitions between states
- [[computability-theory|Computability Theory]] — Deals with the question of whether a problem is solvable on a computer
- [[halting-problem|Halting Problem]] — Asks: given a program and its input, will it terminate or run forever?
- [[rices-theorem|Rice's Theorem]] — For all non-trivial properties of partial functions computed by Turing machines, it is undecidable whether a program has that property
- [[computational-complexity-theory|Computational Complexity Theory]] — Studies not just whether a problem can be solved, but how efficiently it can be solved
- [[big-o-notation|Big O Notation]] — Describes the upper bound on the growth rate of a function, allowing comparison of algorithms based on resource scaling
- [[p-vs-np-problem|P vs NP Problem]] — Asks whether every problem whose solution can be verified in polynomial time can also be solved in polynomial time
- [[formal-language-theory|Formal Language Theory]] — Branch of mathematics concerned with describing languages as sets of operations over an alphabet
- [[chomsky-hierarchy|Chomsky Hierarchy]] — Classification of formal languages into four types, where each type is defined by the grammar complexity required to generate it
- [[lambda-calculus|Lambda Calculus]] — Formal system for expressing computation based on function abstraction and application
- [[church-turing-thesis|Church-Turing Thesis]] — Turing machines capture the notion of computability; any effectively calculable function is computable by a Turing machine
- [[alan-turing|Alan Turing]] — British mathematician and computer scientist who created the Turing machine model and proved the halting problem undecidable
- [[mathematical-logic|Mathematical Logic]] — Uses formal languages with precise syntax and semantics to study mathematical reasoning, proof, and computation

---

## Quick Navigation

- All topic folders: `wiki/` — browse by topic
- `log.md` — grep-parseable operation log: `grep "^## \[" wiki/log.md | tail -5`
- `SCHEMA.md` — page format conventions
- `MAINTENANCE.md` — human's maintenance guide

---

## Stats

- **Topic folders:** 26
- **Concept pages:** 600 (excluding source summaries and synthesis pages)
- **Synthesis pages:** 29
- **Source summaries:** 21
- **Total wiki pages:** 650 (content) + 5 (meta) = 655
- **Domain distribution:** dev (276), networking (108), systems (132), database (50), ml (39), theory (19), ai (14), security (5)
- **Last full index rebuild:** 2026-05-15 (readmemd.md ingest)
- **Java:** 43 concept pages, 3 synthesis pages, 1 source summary (from java1.md + java2.md)
- **Advanced Java:** 34 new concept pages, 2 new syntheses, 1 source summary (new, ingested 2026-05-13 from java3.md)

---

## Tips

- **Graph view** — open Obsidian graph view on `wiki/` to see connections, hubs, and orphans
- **Web Clipper** — use Obsidian Web Clipper to save articles directly to `sources/`
- **Wiki is a git repo** — you get version history, branching, and collaboration for free
