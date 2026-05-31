---
concept: JUnit Parameterized Tests
aliases: [ParameterizedTest, @ValueSource, @CsvSource, @MethodSource]
tags: [dev, testing]
created: 2026-05-13
updated: 2026-05-13
---

## The Problem

Testing a method with different inputs requires either writing multiple test methods (one per input) or using loops inside a single test. Multiple tests are repetitive to write and maintain; loops make it hard to identify which input caused a failure.

## Core Idea

JUnit 5's `@ParameterizedTest` allows running the same test method with different arguments. By providing a source of arguments (`@ValueSource`, `@CsvSource`, `@MethodSource`), the test runs once per argument set, with each run reported independently — making it easy to see exactly which input failed.

## How It Works

1. **@ParameterizedTest**: Replaces `@Test` to indicate a parameterized test
2. **@ValueSource**: Provides literal values (ints, strings) — `@ValueSource(ints = {1, 2, 3})`
3. **@CsvSource**: Provides comma-separated values for multiple parameters — `@CsvSource({"1,2,3", "4,5,9"})`
4. **@MethodSource**: References a static method that returns a `Stream<Arguments>` — most flexible
5. **@EnumSource**: Provides enum constants as test arguments
6. **@CsvFileSource**: Loads test data from a CSV file on classpath
7. **@NullSource / @EmptySource**: Provides null and empty values for edge case testing

## Visual Explanation

```dot
digraph parameterized {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  TEST [label="@ParameterizedTest\nvoid testAdd(int a, int b, int expected)"]
  SRC [label="Argument Sources"]
  VS [label="@ValueSource\n(single param)"]
  CS [label="@CsvSource\n(multi params)"]
  MS [label="@MethodSource\n(complex args)"]
  ES [label="@EnumSource\n(enum values)"]
  RUN [label="Run 1: (1, 2, 3)\nRun 2: (4, 5, 9)\nRun 3: (0, 0, 0)" fillcolor="#ffe5cc]
  PASS [label="PASS: 1+2=3"]
  FAIL [label="FAIL: 4+5=9?\n(expected 9, got 8)"]

  TEST -> SRC
  SRC -> VS
  SRC -> CS
  SRC -> MS
  SRC -> ES
  VS -> RUN
  CS -> RUN
  MS -> RUN
  ES -> RUN
  RUN -> PASS [label="test passes"]
  RUN -> FAIL [label="test fails"]
}
```

## Key Properties

- **@ParameterizedTest**: Replaces `@Test` for tests that take arguments
- **@ValueSource**: Simple literal values — ints, strings, longs, doubles
- **@CsvSource**: Multiple parameters as CSV — supports null values via empty field
- **@MethodSource**: References a factory method returning `Stream<Arguments>`, `Arguments[]`, or `Stream<T>`
- **@CsvFileSource**: Load test data from CSV files (lines = test cases, columns = parameters)
- **@EnumSource**: All enum values or a filtered subset
- **@NullAndEmptySource**: Combines both @NullSource and @EmptySource
- **Custom display names**: `@ParameterizedTest(name = "{index}: add({0}, {1}) = {2}")`

## Connections

- **Built from:** [[junit-testing|JUnit Testing]] — Parameterized tests extend JUnit 5's test capabilities
- **Related:** [[junit-annotations-lifecycle|JUnit Annotations and Lifecycle]] — Lifecycle hooks work with parameterized tests
- **Related:** [[sql-database|SQL Database]] — @CsvSource provides tabular test data, similar to query result sets
- **Related:** [[test-driven-development|Test-Driven Development]] — TDD benefits from parameterized tests for boundary value analysis

## Edge Cases & Gotchas

- **MethodSource must be static**: Factory methods for @MethodSource must be static (unless PER_CLASS lifecycle)
- **Type conversion**: JUnit automatically converts strings to primitives, but custom types need `@ConvertWith` or `@JavaTimeConversionPattern`
- **Large CSV files**: @CsvFileSource for large datasets — but test data in CSV may be harder to maintain than inline
- **Argument name in display name**: Use `{0}`, `{1}`, etc. in the `name` attribute of @ParameterizedTest to reference arguments
- **Null handling**: Primitive parameters can't accept null — use `Integer` instead of `int` for nullable tests

## Sources

- [[java3-summary|Advanced Java Tutorial — Source Summary]] — JUnit parameterized tests
