---
title: "Full Subtractor in Digital Logic"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# Full Subtractor in Digital Logic
A Full Subtractor is a combinational circuit used to perform binary subtraction. It has three inputs:

- A (Minuend)
- B (Subtrahend)
- B-IN (Borrow-in from the previous stage)

It produces two outputs:

- Difference (D): The result of the subtraction.
- Borrow-out (B-OUT): Indicates if a borrow is needed for the next stage.

The full subtractor is essential because a half-subtractor can only subtract the least significant bit (LSB) of binary numbers. However, if a borrow is generated during the subtraction of the LSBs, it will affect the subtraction in the next stages. A full subtractor handles this situation by considering the borrow from the previous stage, ensuring accurate subtraction even when a borrow is present.

The full subtractor is used to subtract binary numbers with borrow handling, making it suitable for multi-bit subtraction in digital circuits like Arithmetic Logic Units (ALUs).

![Full-Subtractor-in-Digital-Logic](images_full-subtractor-in-digital-logic.webp)

## Truth Table of Full Subtractor

| Input | Output |  |  |  |
| --- | --- | --- | --- | --- |
| A | B | Bin | D | Bout |
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 1 |
| 0 | 1 | 0 | 1 | 1 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 0 |
| 1 | 1 | 0 | 0 | 0 |
| 1 | 1 | 1 | 1 | 1 |

Input

Output

Bin

Bout

## K-Map for Full Subtractor

From above table we can draw the K-Map as shown for "difference" and "borrow".

![Full-Subtractor-in-Digital-Logic-1](images_full-subtractor-in-digital-logic-1.webp)

Logical expression for difference

The basic expression is:

> D = A'B'Bin + A'BBin' + AB'Bin' + ABBin

D = A'B'Bin + A'BBin' + AB'Bin' + ABBin

Factoring common terms:

> D = Bin(A'B' + AB) + Bin'(AB' + A'B)

D = Bin(A'B' + AB) + Bin'(AB' + A'B)

Recognizing XOR and XNOR properties:

> A'B' + AB = A XNOR BAB' + A'B = A XOR B

A'B' + AB = A XNOR BAB' + A'B = A XOR B

Substituting these values:

> D = Bin(A XNOR B) + Bin' (A XOR B)

D = Bin(A XNOR B) + Bin' (A XOR B)

Using XNOR identity:

> D = Bin ⊕ (A ⊕ B)

D = Bin ⊕ (A ⊕ B)

Thus, the final simplified expression for the difference in a full subtractor is:D = (A ⊕ B) ⊕ Bin

![Full-Subtractor-in-Digital-Logic-2](images_full-subtractor-in-digital-logic-2.webp)

Logical expression for borrow

The borrow (Bout) output is derived as follows:

The basic expression:

> Bout = A'B'Bin + A'BBin' + A'BBin + ABBin

Bout = A'B'Bin + A'BBin' + A'BBin + ABBin

Factoring common terms:

> Bout = A'Bin(B + B') + A'B(Bin + Bin') + BBin(A + A')

Bout = A'Bin(B + B') + A'B(Bin + Bin') + BBin(A + A')

Simplifying:

> Bout = A'Bin + A'B + BBin

Bout = A'Bin + A'B + BBin

Alternatively, using another approach:

> Bout = A'B'Bin + A'BBin' + A'BBin + ABBin

Bout = A'B'Bin + A'BBin' + A'BBin + ABBin

Factoring common terms:

> Bout = Bin(AB + A'B') + A'B(Bin + Bin')

Bout = Bin(AB + A'B') + A'B(Bin + Bin')

Using XOR and XNOR properties:

> AB + A'B' = A XNOR B

AB + A'B' = A XNOR B

Substituting these values:

> Bout = Bin(A XNOR B) + A'B

Bout = Bin(A XNOR B) + A'B

Using XNOR identity:

> Bout = Bin (A XOR B)' + A'B

Bout = Bin (A XOR B)' + A'B

Thus, the final simplified expression for borrow in a full subtractor is:

## Logic Circuit for Full Subtractor

![Full-Subtractor-in-Digital-Logic-3](images_full-subtractor-in-digital-logic-3.webp)

## Implementation of Full Subtractor using Half Subtractors

2 Half Subtractors and an OR gate is required to implement a Full Subtractor.

![Full-Subtractor-in-Digital-Logic-4](images_full-subtractor-in-digital-logic-4.webp)