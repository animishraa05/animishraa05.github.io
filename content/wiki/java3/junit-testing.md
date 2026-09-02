---
concept: JUnit Testing
aliases: [JUnit 5, JUnit Framework, Java Testing]
tags: [dev, testing]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Software defects are inevitable. Without a systematic testing approach, bugs are found only during manual testing or in production — making them expensive and time-consuming to fix. Developers need a way to automatically verify that code behaves correctly, especially after changes.

## Core Idea

JUnit is the standard framework for writing and running tests in Java. JUnit 5 (Jupiter) provides annotations for defining tests (`@Test`), lifecycle hooks (`@BeforeEach`, `@AfterEach`), assertions (`assertEquals`, `assertThrows`), assumptions, and test execution control. It integrates with build tools (Maven, Gradle) and CI/CD pipelines.

## How It Works

1. **Test class**: A plain Java class containing test methods annotated with `@Test`
2. **Assertions**: `assertEquals(expected, actual)`, `assertTrue(condition)`, `assertThrows(Exception.class, () → code)` — verify results
3. **Lifecycle methods**: `@BeforeAll` (once before all tests, static), `@BeforeEach` (before each test), `@AfterEach` (after each test), `@AfterAll` (once after all tests, static)
4. **Test runner**: JUnit discovers test classes (classpath scanning), instantiates a new test instance per method (default behavior), executes lifecycle hooks, runs the test, and reports results
5. **Test suites**: `@Suite` aggregates multiple test classes into a test suite for batch execution
6. **Build integration**: Maven Surefire Plugin runs JUnit tests during the `test` lifecycle phase
7. **Mockito integration**: Mockito creates mock objects to isolate the unit under test — `@Mock`, `@InjectMocks`, `when(mock.method()).thenReturn(value)`

## Visual Explanation

```dot
digraph junit_flow {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  CLASS [label="Test Class\n(StudentServiceTest)"]
  B4ALL [label="@BeforeAll\n(setup DB connection)"]
  B4 [label="@BeforeEach\n(create test data)"]
  TEST1 [label="@Test\ntestAddStudent()" fillcolor="#ffe5cc]
  TEST2 [label="@Test\ntestDeleteStudent()" fillcolor="#ffe5cc]
  AFT [label="@AfterEach\n(cleanup test data)"]
  AFTALL [label="@AfterAll\n(close DB connection)"]
  ASSERT [label="Assertions\nassertEquals\nassertNotNull\nassertThrows"]
  RESULT [label="Test Result\nPASS / FAIL"]

  CLASS -> B4ALL
  B4ALL -> B4
  B4 -> TEST1
  TEST1 -> ASSERT
  ASSERT -> RESULT
  RESULT -> AFT
  AFT -> B4 [label="next test"]
  B4 -> TEST2
  TEST2 -> AFT
  AFT -> AFTALL [label="all done"]
}
```

## Key Properties

- **@Test**: Marks a method as a test; JUnit discovers and executes it
- **Assertions**: Static methods comparing actual vs expected; `assertAll()` groups multiple assertions
- **Assumptions**: `assumeTrue()` skips tests when conditions aren't met (e.g., OS-specific tests)
- **Lifecycle hooks**: @BeforeAll, @BeforeEach, @AfterEach, @AfterAll for setup/cleanup
- **Parameterized tests**: `@ParameterizedTest` + `@ValueSource` / `@CsvSource` — run same test with different inputs
- **Test templates**: `@TestTemplate` for reusable test skeletons (e.g., repeated tests)
- **TestInfo/TestReporter**: Injection parameters providing test metadata and reporting

## Connections

- **Built from:** [[java-try-catch-finally|Try-Catch-Finally]] — Assertions and lifecycle hooks replace manual try-catch error handling
- **Related:** [[junit-annotations-lifecycle|JUnit Annotations and Lifecycle]] — The lifecycle annotations and their execution order
- **Related:** [[junit-parameterized-tests|JUnit Parameterized Tests]] — Testing multiple inputs with parameterized tests
- **Related:** [[test-driven-development|Test-Driven Development]] — TDD uses JUnit as the testing framework
- **Contrasts with:** [[java-exception-hierarchy|Java Exception Hierarchy]] — Exceptions signal runtime problems; JUnit assertions verify correctness

## Edge Cases & Gotchas

- **Test instance lifecycle**: Default is PER_METHOD (new instance per test) — `@TestInstance(Lifecycle.PER_CLASS)` shares instance for stateful tests
- **assertThrows usage**: Must wrap the code in a lambda — `assertThrows(IllegalArgumentException.class, () → obj.method())`
- **Test ordering**: Tests should be independent — don't rely on execution order; use `@TestMethodOrder` if order matters
- **Mockito annotations**: `@ExtendWith(MockitoExtension.class)` enables @Mock and @InjectMocks
- **Static methods in tests**: @BeforeAll and @AfterAll must be static (unless using PER_CLASS lifecycle)