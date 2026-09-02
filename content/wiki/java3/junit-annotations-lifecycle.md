---
concept: JUnit Annotations and Lifecycle
aliases: ["@BeforeEach", "@AfterEach", "@BeforeAll", "@AfterAll", "@Tag"]
tags: [dev, testing]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Tests need setup (creating objects, connecting to databases) and cleanup (closing resources, deleting test data). Without lifecycle methods, every test duplicates setup and cleanup code. Different tests may need different setup, and some tests need to be conditionally included or excluded.

## Core Idea

JUnit 5 provides lifecycle annotations that define methods to run before/after all tests and before/after each test. These eliminate duplication and establish a clear fixture lifecycle. `@Tag` filters which tests run in which environments, and `@DisplayName` provides readable test descriptions.

## How It Works

1. **@BeforeAll**: Runs once before any test in the class. Must be static (or use `@TestInstance(Lifecycle.PER_CLASS)`). Used for expensive setup (DB connection, file system init)
2. **@BeforeEach**: Runs before each `@Test` method. Used to set up test data, create fresh objects, reset state
3. **@AfterEach**: Runs after each `@Test` method (even if the test fails). Used to clean up test data, close resources
4. **@AfterAll**: Runs once after all tests. Must be static. Used to close global resources
5. **@Tag**: Labels tests for filtering — `@Tag("slow")`, `@Tag("integration")`. Maven: `mvn test -Dgroups="fast"`
6. **@DisplayName**: Human-readable test name in reports and IDE — `@DisplayName("should return user when valid ID")`
7. **@Disabled**: Temporarily skip a test (with reason) instead of commenting it out

## Visual Explanation

```dot
digraph lifecycle_order {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  CLASS [label="TestClass"]
  B4ALL [label="@BeforeAll\nstatic void init()" fillcolor="#cce5ff"]
  B4_1 [label="@BeforeEach\nvoid setUp()" fillcolor="#cce5ff"]
  TEST1 [label="@Test\ntest1()" fillcolor="#ffe5cc]
  AFT_1 [label="@AfterEach\nvoid tearDown()" fillcolor="#cce5ff"]
  B4_2 [label="@BeforeEach\nvoid setUp()" fillcolor="#cce5ff"]
  TEST2 [label="@Test\ntest2()" fillcolor="#ffe5cc]
  AFT_2 [label="@AfterEach\nvoid tearDown()" fillcolor="#cce5ff"]
  AFTALL [label="@AfterAll\nstatic void cleanup()" fillcolor="#cce5ff"]

  CLASS -> B4ALL
  B4ALL -> B4_1
  B4_1 -> TEST1
  TEST1 -> AFT_1
  AFT_1 -> B4_2
  B4_2 -> TEST2
  TEST2 -> AFT_2
  AFT_2 -> AFTALL
}
```

## Key Properties

- **@BeforeAll**: One-time setup, runs once per test class, must be static
- **@BeforeEach**: Setup before every test, fresh state per test
- **@AfterEach**: Cleanup after every test, runs even if test fails
- **@AfterAll**: One-time teardown, runs once per test class
- **@Tag**: Filter tests by category (fast/slow, unit/integration, api/db)
- **@DisplayName**: Human-readable names visible in IDE and HTML reports
- **@Disabled**: Skip test with a descriptive reason; better than commenting out

## Connections

- **Built from:** [[junit-testing|JUnit Testing]] — Lifecycle annotations are a core part of JUnit 5
- **Related:** [[junit-parameterized-tests|JUnit Parameterized Tests]] — Lifecycle hooks work with parameterized tests too
- **Related:** [[java-try-catch-finally|Try-Catch-Finally]] — @AfterEach acts like a finally block for each test
- **Related:** [[test-driven-development|Test-Driven Development]] — TDD relies on well-structured test fixtures

## Edge Cases & Gotchas

- **Static @BeforeAll**: Must be static in default PER_METHOD mode; in PER_CLASS mode, can be instance method
- **@AfterEach runs always**: Even if the test throws an exception, @AfterEach runs (like finally) — but if @AfterEach throws, the test may be masked
- **Tag inheritance**: Tags are inherited from parent classes and interfaces
- **@Disabled vs @Ignore (JUnit 4)**: JUnit 5 uses @Disabled; JUnit 4 used @Ignore — don't confuse them
- **Execution order**: Tests should not depend on order, but if needed, use @TestMethodOrder(MethodName/OrderAnnotation/Random)