---
title: "Introduction of Finite Automata"
topic: "theory-of-computation"
scraped_date: [[2026-03-29]]
---

# Introduction of Finite Automata
Finite automata are abstract machines used to recognize patterns in input sequences, forming the basis for understanding regular languages in computer science.

- Consist of states, transitions, and input symbols, processing each symbol step-by-step.
- If ends in an accepting state after processing the input, then the input is accepted; otherwise, rejected.
- Finite automata come in deterministic (DFA) and non-deterministic (NFA), both of which can recognize the same set of regular languages.
- Widely used in text processing, compilers, and network protocols.

![Fintie Automata](images/fintie-automata.png)

### Features of Finite Automata

- Input: Set of symbols or characters provided to the machine.
- Output: Accept or reject based on the input pattern.
- States of Automata: The conditions or configurations of the machine.
- State Relation: The transitions between states.
- Output Relation: Based on the final state, the output decision is made.

### Formal Definition of Finite Automata

A finite automaton can be defined as a tuple:

{ Q, Σ, q, F, δ }, where:

- Q: Finite set of states
- Σ: Set of input symbols
- q: Initial state
- F: Set of final states
- δ: Transition function

## Types of Finite Automata

There are two types of finite automata:

1. Deterministic Finite Automata (DFA)
2. Non-Deterministic Finite Automata (NFA)

### 1. Deterministic Finite Automata (DFA)

A DFA is represented as {Q, Σ, q, F, δ}. In DFA, for each input symbol, the machine transitions to one and only one state. DFA does not allow any null transitions, meaning every state must have a transition defined for every input symbol.

> DFA consists of 5 tuples {Q, Σ, q, F, δ}. Q : set of all states.Σ : set of input symbols. ( Symbols which machine takes as input )q : Initial state. ( Starting state of a machine )F : set of final state.δ : Transition Function, defined as δ : Q X Σ --> Q.

DFA consists of 5 tuples {Q, Σ, q, F, δ}. Q : set of all states.Σ : set of input symbols. ( Symbols which machine takes as input )q : Initial state. ( Starting state of a machine )F : set of final state.δ : Transition Function, defined as δ : Q X Σ --> Q.

Example: Construct a DFA that accepts all strings ending with 'a'.

Given:

Σ = {a, b},

Q = {q0, q1},

F = {q1}

![State Transition Diagram](images/state-transition-diagram.png)

| State\Symbol | a | b |
| --- | --- | --- |
| q0 | q1 | q0 |
| q1 | q1 | q0 |

In this example, if the string ends in 'a', the machine reaches state q1, which is an accepting state.

### 2. Non-Deterministic Finite Automata (NFA)

NFA is similar to DFA but includes the following features:

- It can transition to multiple states for the same input.
- It allows null (ϵ) moves, where the machine can change states without consuming any input.

Example: Construct an NFA that accepts strings ending in 'a'.

Given:

Σ = {a, b},

Q = {q0, q1},

F = {q1}

![](images/nfa_fsa.png)

State Transition Table for above Automaton,

| State\Symbol | a | b |
| --- | --- | --- |
| q0 | {q0,q1} | q0 |
| q1 | φ | φ |

In an NFA, if any transition leads to an accepting state, the string is accepted.

## NFA vs DFA

| DFA | NFA |
| --- | --- |
| Deterministic: exactly one transition per input symbol | Non-deterministic: multiple transitions per input symbol allowed |
| No ε (null) moves | Allows ε (null) moves |
| Simpler but sometimes larger in design | More flexible and easier to design |
| Next state is uniquely determined | Next state may be multiple possibilities |
| Recognizes regular languages; NFAs can be converted to DFA | Recognizes regular languages; equivalent in power to DFA |

DFA

NFA

Deterministic: exactly one transition per input symbol

Non-deterministic: multiple transitions per input symbol allowed

No ε (null) moves

Allows ε (null) moves

Simpler but sometimes larger in design

More flexible and easier to design

Next state is uniquely determined

Next state may be multiple possibilities

Recognizes regular languages; NFAs can be converted to DFA