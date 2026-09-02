---
title: Code Optimization Techniques Compared — Peephole, CSE, Constant Propagation, Liveliness
type: synthesis
tags: [dev, compiler-design]
created: 2026-05-13
updated: 2026-05-13
---

## What's Being Compared

Compiler code optimization encompasses a variety of techniques operating at different stages and scopes. Peephole optimization, common subexpression elimination (CSE), constant propagation (with folding), and liveliness (live variable) analysis represent four fundamental approaches that differ in scope, level, and mechanism.

## The Core Tension

Optimization is a trade-off between analysis cost and improvement. Local techniques (peephole) are cheap but miss global opportunities. Global techniques (CSE, CP) capture more but require expensive data-flow analysis. The techniques compound — constant propagation creates CSE opportunities, CSE reduces register pressure, and liveliness analysis enables further dead code elimination.

## Comparison

| Dimension | [[peephole-optimization\|Peephole]] | [[common-subexpression-elimination\|CSE]] | [[constant-propagation\|Constant Propagation]] | [[liveliness-analysis\|Liveliness Analysis]] |
|-----------|-----------|-----|-----|-----|
| Scope | Local (2-5 instructions) | Local + Global | Local + Global | Global (whole CFG) |
| Level | Target instructions | Intermediate representation (TAC) | Intermediate representation (TAC) | Intermediate representation (TAC) |
| Mechanism | Pattern matching & replacement | Available-expression DFA | Reaching-definitions DFA | Backward DFA (USE/DEF) |
| What it removes | Redundant loads/stores, no-ops | Redundant recomputation | Runtime constant evaluation | Dead variable assignments |
| Analysis cost | Very low (linear scan) | Medium (DFA iteration) | Medium (DFA iteration) | Medium (backward DFA iteration) |
| Dependency | Requires preceding CSE/CP | Benefits from CP | Independent | Used by CSE and DCE |
| Safety | Must preserve flags/conditions | Always safe (same operands) | Conservative (must be sure) | Conservative (assume live) |

## When to Choose Each

**Peephole:** Run last, after code generation. Best for cleaning up the final target instruction stream — removing redundant loads/stores and no-ops introduced by naive code generation.

**CSE:** Use when expressions repeat (especially in loops). Essential for array address calculations (`a[i*cols+j]`) and repeated field accesses.

**Constant Propagation + Folding:** Use always — the simplest and safest optimization. Creates cascading simplification opportunities for other optimizations.

**Liveliness Analysis:** Essential prerequisite for dead code elimination and register allocation. Run before register allocation to determine which values need registers.

## The Insight

These four techniques form a pipeline: constant propagation simplifies expressions (creating redundancies) → CSE eliminates the redundancies → code generator produces naive target code → peephole cleans it up — while liveliness analysis provides liveness information for both CSE (available expressions) and dead code elimination after each step. Individually each saves a few percent; together they can double performance.

## Connections

- [[peephole-optimization|Peephole Optimization]] — local target-level optimization
- [[common-subexpression-elimination|Common Subexpression Elimination]] — global IR-level redundancy removal
- [[constant-propagation|Constant Propagation]] — compile-time constant evaluation and propagation
- [[liveliness-analysis|Liveliness Analysis]] — backward data-flow analysis for live variable detection
- [[code-optimization|Code Optimization]] — the parent concept encompassing all techniques
- [[data-flow-analysis|Data Flow Analysis]] — the analysis framework enabling CSE, CP, and liveliness
- [[code-generator-design-issues|Issues in Code Generator Design]] — register allocation depends on liveness