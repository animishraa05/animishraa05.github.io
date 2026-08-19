---
concept: Test-Driven Development
aliases: [TDD, Red-Green-Refactor]
tags: [dev, testing]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Writing code without tests leads to bugs that are found late, regression failures when refactoring, and code that's hard to change with confidence. Testing after coding often gets skipped due to deadlines. Developers need a discipline that ensures code is tested from the start.

## Core Idea

Test-Driven Development (TDD) is a software development practice where tests are written before the implementation code. The cycle is: Red (write a failing test) → Green (write the minimal code to pass) → Refactor (improve code while tests stay green). This ensures 100% test coverage of specified behavior and drives clean, testable design.

## How It Works

1. **Red**: Write a test for the NEXT piece of functionality. Run it — it should fail (red) because the code doesn't exist yet
2. **Green**: Write the SIMPLEST possible implementation code to make the test pass. Don't optimize, don't over-engineer
3. **Refactor**: With tests passing (green), improve the code: remove duplication, extract methods, rename variables. Tests ensure refactoring doesn't break anything
4. **Repeat**: Add the next test, see it fail, implement, refactor. Each cycle is 30-60 seconds
5. **JUnit + Mockito**: JUnit provides the test framework; Mockito isolates the unit under test by mocking its dependencies (services, repositories)

## Visual Explanation

```dot
digraph tdd_cycle {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  RED [label="RED\nWrite failing test\n(test doesn't compile\nor assertion fails)" fillcolor="#ffe5cc]
  GREEN [label="GREEN\nWrite minimal code\n(make test pass)" fillcolor="#d4edda]
  REFACTOR [label="REFACTOR\nImprove code\n(duplication, naming,\nstructure)" fillcolor="#cce5ff]
  NEXT [label="Next Test"]

  RED -> GREEN [label="1. implement"]
  GREEN -> REFACTOR [label="2. all green"]
  REFACTOR -> RED [label="3. add next test"]
  REFACTOR -> NEXT [label="loop"]
}
```

## Key Properties

- **Test-first**: Tests are written before implementation, not after
- **Small cycles**: Red-Green-Refactor in 30-60 second iterations
- **Minimal implementation**: Write just enough code to pass the test — no more
- **Continuous refactoring**: Improve code quality with the safety net of passing tests
- **Design driver**: TDD naturally drives decoupled, testable designs (dependency injection, interfaces)
- **Mockito integration**: `@Mock` for dependencies, `@InjectMocks` for the system under test
- **Test coverage**: Every line of production code exists because a test required it

## Connections

- **Built from:** [[junit-testing|JUnit Testing]] — JUnit is the testing framework used in TDD
- **Built from:** [[junit-annotations-lifecycle|JUnit Annotations and Lifecycle]] — Lifecycle hooks structure TDD test fixtures
- **Related:** [[junit-parameterized-tests|JUnit Parameterized Tests]] — Parameterized tests express TDD edge case coverage
- **Related:** [[java-methods|Java Methods]] — TDD drives clean method design with single responsibilities

## Edge Cases & Gotchas

- **TDD is a discipline, not a tool**: It takes practice to write tests first consistently — especially when under pressure
- **Mocking everything**: Over-mocking leads to brittle tests that break when implementation details change
- **Testing private methods**: Don't test private methods directly — test the public API that uses them
- **Integration vs unit**: TDD works best at the unit level; integration tests follow different patterns
- **Red phase must fail**: If the test passes before implementation, it tests the wrong thing or duplicates an existing test

## Sources

- [[java3-summary|Advanced Java Tutorial — Source Summary]] — Test-driven development with JUnit and Mockito
