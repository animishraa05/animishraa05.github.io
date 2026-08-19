---
title: "Full Adder"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# Full Adder
Full Adder is a combinational circuit that adds three inputs and produces two outputs. The first two inputs are A and B and the third input is an input carry as C-IN. The output carry is designated as C-OUT and the normal output is designated as S which is SUM.

- The C-OUT is also known as the majority 1's detector, whose output goes high when more than one input is high.
- A full adder logic is designed in such a manner that can take eight inputs together to create a byte-wide adder and cascade the carry bit from one adder to another.
- We use a full adder because when a carry-in bit is available, another 1-bit adder must be used since a 1-bit [[half-adder]] does not take a carry-in bit.
- A 1-bit full adder adds three operands and generates 2-bit results.

## Full Adder Truth Table

A Full Adder takes three binary inputs:

- A (first bit)
- B (second bit)
- C-IN (carry input)

And it produces two outputs:

- Sum (S)
- Carry Out (C-OUT)

![frame_16](Daily/computer-science/digital-logic/images/frame_16.webp)

Here’s the truth table for the full adder:

| INPUT | OUTPUT |  |  |  |
| --- | --- | --- | --- | --- |
| A | B | C-IN | Sum | C-OUT |
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 1 | 1 |

INPUT

OUTPUT

C-IN

Sum

C-OUT

## Logical Expressions for SUM

From the truth table, the logical expression for the sum (S) in a full adder is:

> S = A'B'C-IN + A'BC-IN' + AB'C-IN' + ABC-IN

S = A'B'C-IN + A'BC-IN' + AB'C-IN' + ABC-IN

Since A'B + AB' =A ⊕ B. This simplifies to:

> S = C-IN(A ⊕ B)' + C-IN'(A ⊕ B)

S = C-IN(A ⊕ B)' + C-IN'(A ⊕ B)

The final simplified expression is:

> S = A ⊕ B ⊕ C-IN

S = A ⊕ B ⊕ C-IN

Thus, the sum output is the XOR of A, B, and C-IN.

## Logical Expression for C-OUT

From the truth table, the logical expression for C-OUT (carry-out) in a full adder is:

> C-OUT = A' B C-IN + A B' C-IN + A B C-IN' + A B C-IN

C-OUT = A' B C-IN + A B' C-IN + A B C-IN' + A B C-IN

This simplifies to:

> C-OUT = A B(C-IN'+C-IN) + C-IN(A'B+AB')

C-OUT = A B(C-IN'+C-IN) + C-IN(A'B+AB')

Since C-IN' + C-IN =1 and A'B + AB' =A ⊕ B. Thus, the final simplified expression is:

> C-OUT = A B + C-IN (A ⊕ B)

C-OUT = A B + C-IN (A ⊕ B)

## Logic Circuit of Full Adder

To implement a Full Adder using basic [[logic-gates|logic gates]]:

Sum (S) is implemented using XOR gates:

Use two XOR gates:

- First XOR gate: A ⊕ B
- Second XOR gate: (A ⊕ B) ⊕ C-IN to get the final sum S.

Carry (C-Out) is implemented using XOR,AND and OR gates:Finally, the two outputs from the AND gates are combined using an OR gate to generate the final C-OUT output.

First AND gate: This gate calculates A AND B.

Second AND gate: This gate calculates C-IN AND (A ⊕ B). To do this, you need the result of the first XOR gate (A ⊕ B) as an input to the second AND gate.

![frame_274](images_frame_274.webp)

## Implementation of Full Adder using Half Adders

2 Half Adders and an OR gate is required to implement a Full Adder.

![frame_277](images_frame_277.webp)

With this logic circuit, two bits can be added together, taking a carry from the next lower order of magnitude, and sending a carry to the next higher order of magnitude.

## Implementation of Full Adder using NAND gates

Total 9 NAND gates are required to implement a Full Adder.

![frame_275](images_frame_275.webp)

## Implementation of Full Adder using NOR gates

Total 9 NOR gates are required to implement a Full Adder.

![frame_276](images_frame_276.webp)

## Application of Full Adder in Digital Logic

- Arithmetic circuits: Full adders are utilized in math circuits to add twofold numbers. At the point when different full adders are associated in a chain, they can add multi-bit paired numbers.
- Data handling: Full adders are utilized in information handling applications like advanced signal handling, information encryption, and mistake rectification.
- Counters: Full adders are utilized in counters to addition or decrement the count by one.
- Multiplexers and demultiplexers: Full adders are utilized in multiplexers and demultiplexers to choose and course information.
- Memory tending to: Full adders are utilized in memory addressing circuits to produce the location of a particular memory area.
- ALUs: Full adders are a fundamental part of Number juggling Rationale Units (ALUs) utilized in chip and computerized signal processors.