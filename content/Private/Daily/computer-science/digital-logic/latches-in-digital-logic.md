---
title: "Latches in Digital Logic"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# Latches in Digital Logic
## What are Latches?

Latches are digital circuits that store a single bit of information and hold its value until it is updated by new input signals. They are used in digital systems as temporary storage elements to store binary information. Latches can be implemented using various digital [[logic-gates|logic gates]], such as AND, OR, NOT, NAND, and NOR gates.

Latches are widely used in digital systems for various applications, including data storage, control circuits, and flip-flop circuits. They are often used in combination with other digital circuits to implement sequential circuits, such as state machines and memory elements.

### Latches Definition

Latches are basic storage elements that operate with signal levels (rather than signal transitions). Latches controlled by a clock transition are flip-flops. Latches are level-sensitive devices. Latches are useful for the design of the asynchronous sequential circuit. Latches are sequential circuit with two stable states. These are sensitive to the input voltage applied and does not depend on the clock pulse. Flip flops that do not use clock pulse are referred to as latch.

## Types of Latches in Digital Electronics

In digital electronics different types of latches are:

- SR Latches
- Gated SR Latches
- D Latches
- Gated D Latches
- JK Latches
- T Laches

## SR Latch

S-R latches i.e., Set-Reset latches are the simplest form of latches and are implemented using two inputs: S (Set) and R (Reset). The S input sets the output to 1, while the R input resets the output to 0. When both S and R inputs are at 1, the latch is said to be in an "undefined" state. They are also known as preset and clear states. The SR latch forms the basic building blocks of all other types of flip-flops.

### Truth Table of SR Latch

The below table represents the truth table of SR latch.

| S | R | Q | Q' |
| --- | --- | --- | --- |
| 0 | 0 | Latch | Latch |
| 0 | 1 | 0 | 1 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 |

Latch

Latch

### Logic Diagram of SR Latch

SR Latch is a logic circuit with:

- 2 cross-coupled NOR gate or 2 cross-coupled NAND gate.
- 2 input S for SET and R for RESET
- 2 output Q, Q'.

The below logic diagram represents the SR latch using NAND gate.

![SR latch using NAND gate](images_sr-latch-using-nand-gate.png)

The below logic diagram represents SR latch using NOR Gate.

![ SR latch using NOR Gate.](images_sr-latch-using-nor-gate.png)

### Different Cases of SR Latch

The different cases of SR latch are discussed below.

Case 1: S' = R' = 1 (S = R = 0)

If Q = 1, Q and R' inputs for 2nd NAND gate are both 1.

If Q = 0, Q and R' inputs for 2nd NAND gate are 0 and 1 respectively.

Case 2: S' = 0, R' = 1 (S = 1, R = 0)

![Case 1: S' = R' = 1 (S = R = 0) ](images_case-1-s-r-1-s-r-0.png)

- As S' = 0, the output of 1st NAND gate, Q = 1 (SET state).
- In second NAND gate, as Q and R' inputs are 1, Q'=0.

![Case 2: S' = 0, R' = 1 (S = 1, R = 0) ](images_case-2-s-0-r-1-s-1-r-0.png)

Case 3: S' = 1, R' = 0 (S = 0, R = 1)

- As R'=0, the output of 2nd NAND gate, Q' = 1.
- In first NAND gate, as Q and S' inputs are 1, Q = 0 (RESET state).

Case 4: S' = R' = 0 (S = R = 1)

![Case 3: S' = 1, R' = 0 (S = 0, R = 1) ](images_case-3-s-1-r-0-s-0-r-1.png)

When S = R = 1, both Q and Q' becomes 1 which is not allowed. So, the input condition is prohibited.

## Gated SR Latch

A Gated SR latch is a SR latch with enable input which works when enable is 1 and retain the previous state when enable is 0.

### Truth Table of Gated SR Latch

The below table represents the truth table of Gated SR latch.

| Enable | S | R | Qn+1 |
| --- | --- | --- | --- |
| 0 | X | X | Qn |
| 1 | 0 | 0 | Qn |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | X |

Enable

Qn+1

### Logic Diagram of Gated SR Latch

The below logic diagram represents the gated SR latch.

![Logic Diagram of Gated SR Latch](images_logic-diagram-of-gated-sr-latch.jpg)

## D Latch

D latches are also known as transparent latches and are implemented using two inputs: D (Data) and a clock signal. The output of the latch follows the input at the D terminal as long as the clock signal is high. When the clock signal goes low, the output of the latch is stored and held until the next rising edge of the clock.

### Truth Table of D Latch

The below table represents the truth table of D latch.

| E | D | Q | Q' |
| --- | --- | --- | --- |
| 0 | 0 | Latch | Latch |
| 0 | 1 | Latch | Latch |
| 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 0 |

Latch

Latch

Latch

Latch

### Logic Diagram of D Latch

The below logic diagram represents the D latch.

![Logic Diagram of D Latch](images_logic-diagram-of-d-latch.jpg)

## Gated D Latch

D latch is similar to SR latch with some modifications made. Here, the inputs are complements of each other. The D latch stands for "data latch" as this latch stores single bit temporarily.

### Truth Table of Gated D Latch

The below table represents the truth table of Gated D latch.

| Enable | D | Qn | Qn+1 | STATE |
| --- | --- | --- | --- | --- |
| 1 | 0 | x | 0 | RESET |
| 1 | 1 | x | 1 | SET |
| 0 | x | x | Q(n) | No Change |
| Characteristics Equation: Qn+1 = EN.D + EN'.Qn |  |  |  |  |

Characteristics Equation: Qn+1 = EN.D + EN'.Qn

### Logic Diagram of Gated D Latch

The below logic diagram represents the gated D latch.

![Logic Diagram of Gated D Latch](images_logic-diagram-of-gated-d-latch.png)

## JK Latch

JK latch has two inputs J and K. The output gets toggled when the J and K inputs are high. JK latch is just like SR latch, but it eliminates the undefined state of SR latch.

### Truth Table of JK Latch

The below table represents the truth table of JK latch.

| J | K | Qn+1 | Comment |
| --- | --- | --- | --- |
| 0 | 0 | Q | No change |
| 0 | 1 | 0 | Reset |
| 1 | 0 | 1 | Set |
| 1 | 1 | Q' | Toggle |

Qn+1

Comment

No change

Reset

Set

Toggle

### Logic Diagram of JK Latch

The below logic diagram represents the JK latch.

![Logic-Diagram-of-JK-Latch](images_logic-diagram-of-jk-latch.webp)

## T Latch

When the JK inputs of JK latch are shorted we get the T latch. In T latch the outputs are toggled when the inputs are high.

### Logic Diagram of T Latch

The below logic diagram represents the T latch.

![Logic-Diagram-of-T-Latch](images_logic-diagram-of-t-latch.webp)

## Advantages of Latches

Some of the advantages of latches are listed below.

1. Easy to Implement: Latches are simple digital circuits that can be easily implemented using basic digital [[logic-gates|logic gates]].
2. Low Power Consumption: Latches consume less power compared to other sequential circuits such as flip-flops.
3. High Speed: Latches can operate at high speeds, making them suitable for use in high-speed digital systems.
4. Low Cost: Latches are inexpensive to manufacture and can be used in low-cost digital systems.
5. Versatility: Latches can be used for various applications, such as data storage, control circuits, and flip-flop circuits.

## Disadvantages of Latches

Some of the disadvantages of latches are listed below.

1. No Clock: Latches do not have a clock signal to synchronize their operations, making their behavior unpredictable.
2. Unstable State: Latches can sometimes enter into an unstable state when both inputs are at 1. This can result in unexpected behavior in the digital system.
3. Complex Timing: The timing of latches can be complex and difficult to specify, making them less suitable for real-time control applications.

## Reference

Here are a few books that you can refer to for further information on latches:

1. "Digital Design: Principles and Practices" by John F. Wakerly
2. "Digital Systems Design using VHDL" by Charles H. Roth and Lizy Kurian John
3. "Digital Circuit Analysis and Design" by Victor P. Nelson and H. Troy Nagle
4. "Digital Design and Computer Architecture" by David Harris and Sarah Harris
5. "Fundamentals of Digital Logic with Verilog Design" by Stephen Brown and Zvonko Vranesic

These books provide a comprehensive overview of digital logic, including latches, and cover various topics, such as design and implementation, simulation, and verification of digital circuits.

DIGITAL ELECTRONICS – Atul P. Godse, Mrs. Deepali A. Godse