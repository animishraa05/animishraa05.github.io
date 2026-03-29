---
title: "Converting Context Free Grammar to Chomsky Normal Form"
topic: "theory-of-computation"
scraped_date: [[2026-03-29]]
---

# Converting Context Free Grammar to Chomsky Normal Form
Converting a CFG to CNF is an important step in many parsing algorithms, like the CYK algorithm, and helps in understanding the structure of languages. A context free grammar (CFG) is in Chomsky Normal Form (CNF) if all production rules satisfy the following conditions:

- A non-terminal generating a terminal (e.g.; X→ x)
- A non-terminal generating two non-terminals (e.g.; X→YZ)
- Start symbol generating ε. (e.g.; S→ ε)

Consider the following grammars,

> G1 = {S→a, S→AZ, A→a, Z→z} G2 = {S→a, S→aZ, Z→a}

G1 = {S→a, S→AZ, A→a, Z→z} G2 = {S→a, S→aZ, Z→a}

The grammar G1 is in CNF as production rules satisfy the rules specified for CNF. However, the grammar G2 is not in CNF as the production rule S→aZ contains terminal followed by non-terminal which does not satisfy the rules specified for CNF.

### Key Properties of CNF

- A single CFG can be converted into different equivalent CNF forms.
- CNF produces the same language as the original CFG.
- CNF is widely used in parsing algorithms such as:Cocke - Younger - Kasami (CYK) algorithm for membership checking.[[bottom-up-parsers|Bottom-up parsers]] in compilers.
- For a string of length n, a CNF derivation requires at most 2n-1 derivation steps.
- Any CFG that does not generate ε has an equivalent CNF.

1. Cocke - Younger - Kasami (CYK) algorithm for membership checking.
2. [[bottom-up-parsers|Bottom-up parsers]] in compilers.

## Steps to Convert CFG to CNF

### Step 1: Eliminate the Start Symbol from RHS

If start symbol S is at the RHS of any production in the grammar, create a new production as: S0→S where S0 is the new start symbol.

### Step 2: Remove Null, Unit, and Useless Productions

- Null (ε) Productions: If a rule contains ε, remove it by modifying other rules accordingly.
- Unit Productions: If a rule has a single non-terminal on the RHS (e.g., A→B), replace it with B’s productions.
- Useless Productions: Remove non-reachable or non-generating symbols from the grammar.

### Step 3: Replace Terminals in Mixed Productions

Eliminate terminals from RHS if they exist with other terminals or non-terminals. e.g. , production rule X→ xY can be decomposed as: X→ZY, Z→x.

### Step 4: Reduce Productions with More Than Two Non-Terminals

Eliminate RHS with more than two non-terminals. e.g,; production rule X→XYZ can be decomposed as: X→PZ, P→XY

## Example: Converting a CFG to CNF

Let us take an example to convert CFG to CNF. Consider the given grammar G1:

> S → ASBA → aAS | a | ε B → SbS | A | bb

S → ASBA → aAS | a | ε B → SbS | A | bb

Step 1.

As start symbol S appears on the RHS, we will create a new production rule S0→S. Therefore, the grammar will become:

> S0→SS → ASBA → aAS | a | ε B → SbS | A | bb

S0→SS → ASBA → aAS | a | ε B → SbS | A | bb

Step 2.

As grammar contains null production A→ ε, its removal from the grammar yields:

> S0→SS → ASB | SBA → a | aAS | aSB → SbS | A | ε | bb

S0→SS → ASB | SBA → a | aAS | aSB → SbS | A | ε | bb

Now, it creates null production B→ ε, its removal from the grammar yields:

> S0→SS → AS | S | ASB | SBA → a | aAS | aSB → SbS | A | bb

S0→SS → AS | S | ASB | SBA → a | aAS | aSB → SbS | A | bb

Now, it creates unit production B→A, its removal from the grammar yields:

> S0→SS → AS | ASB | SB | SA → a | aAS | aSB → SbS | bb | aAS | aS | a

S0→SS → AS | ASB | SB | SA → a | aAS | aSB → SbS | bb | aAS | aS | a

Also, removal of unit production S0→S from grammar yields:

> S0→ AS | ASB | SB | SS → AS | ASB | SB | SA → aAS | aS | a B → SbS | bb | aAS | aS | a

S0→ AS | ASB | SB | SS → AS | ASB | SB | SA → aAS | aS | a B → SbS | bb | aAS | aS | a

Also, removal of unit production S→S and S0→S from grammar yields:

> S0→ AS | ASB | SBS → AS | ASB | SBA → aAS | aS | a B → SbS | bb | aAS | aS | a

S0→ AS | ASB | SBS → AS | ASB | SBA → aAS | aS | a B → SbS | bb | aAS | aS | a

Step 3.

In production rule A→aAS | aS and B→ SbS | aAS | aS, terminals a and b exist on RHS with non-terminates. Removing them from RHS:

> S0→ AS | ASB | SBS → AS | ASB | SBA → XAS | XS |aB → SYS | bb | XAS | XS |aX →aY→b

S0→ AS | ASB | SBS → AS | ASB | SBA → XAS | XS |aB → SYS | bb | XAS | XS |aX →aY→b

Also, B→ bb can’t be part of CNF, removing it from grammar yields:

> S0→ AS | ASB | SBS → AS | ASB | SBA → XAS | XS | aB → SYS | YY | XAS | XS | aX → aY → b

S0→ AS | ASB | SBS → AS | ASB | SBA → XAS | XS | aB → SYS | YY | XAS | XS | aX → aY → b

Step 4:

In production rule S0→ASB, S→ASB RHS has more than two symbols, removing it from grammar yields:

> S0→ AS | PB | SBS → AS | PB | SBA → XAS | XS | aB → SYS | YY | XAS | XS | aX → aY → bP → AS

S0→ AS | PB | SBS → AS | PB | SBA → XAS | XS | aB → SYS | YY | XAS | XS | aX → aY → bP → AS

Similarly, A→XAS has more than two symbols, removing it from grammar yields:

> S0→ AS | PB | SBS → AS | PB | SBA → RS | XS | aB → SYS | YY | RS | XS | aX → aY → bP → ASR → XA

S0→ AS | PB | SBS → AS | PB | SBA → RS | XS | aB → SYS | YY | RS | XS | aX → aY → bP → ASR → XA

Similarly, B→SYS has more than two symbols, removing it from grammar yields:

> S0→ AS | PB | SBS → AS | PB | SBA → RS | XS | aB → TS | YY | RS | XS | aX → aY → bP → ASR → XAT → SY

S0→ AS | PB | SBS → AS | PB | SBA → RS | XS | aB → TS | YY | RS | XS | aX → aY → bP → ASR → XAT → SY

So this is the required CNF for given grammar.