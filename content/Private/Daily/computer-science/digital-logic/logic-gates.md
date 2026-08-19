---
title: "Logic Gates"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# Logic Gates
Logic gates are the fundamental building blocks in digital electronics.

- Used to perform logical operations based on the inputs provided to it and gives a logical output that can be either high(1) or low(0).
- The operation of logic gates is based on [[Private/Daily/computer-science/digital-logic/boolean-algebra|Boolean algebra]], or mathematics.
- There are basically seven main types of logic gates that are used to perform various logical operations in digital systems.
- By combining different logic gates, complex operations are performed, and circuits like flip-flops, counters, and processors are designed. In this article, we will see various types of logic gates in detail.
- Logic gates find their uses in our day-to-day lives, such as in the architecture of our telephones, laptops, tablets and memory devices.

## Types of Logic Gates

Logic gates can be broadly classified into three main categories :

## AND GATE

An AND gate is used to perform logical Multiplication of binary input. The Output state of the AND gate will be high (1) if both the input is high (1), else the output state will be low(0) if any of the input is low (0).

The Boolean Expression or logic for the AND gate is the logical multiplication of inputs denoted by a full stop or single dot as :

> X = A.BThe value of X will be True when both the inputs will be True.

X = A.B

The value of X will be True when both the inputs will be True.

![1](Daily/computer-science/digital-logic/images/1.webp)

### Properties of AND Gate

The following are two main properties of the AND gate:

1. AND gate can accept two or more than two input values at a time.
2. When all of the inputs are logic 1, the output of this gate is logic 1.

## OR GATE

OR GATE is most widely used digital logic circuit. The output state of OR gate will be high i.e., (1) if any of the input state is high or 1, else output state will be low i.e., 0.

The Boolean Expression for the OR gate is the logical addition of inputs denoted by plus sign (+) as

> X= A+B

X= A+B

The value of X will be high(true) when one of the inputs is set to high (true).

![2](Daily/computer-science/digital-logic/images/2.webp)

### Properties of OR Gate

An OR gate have the following two properties:

1. It can have two or more input lines at a time.
2. When all of the inputs to the OR gate are low or logic 0, the output of it is low or logic 0.

## NOT GATE

In digital electronics, the NOT gate is one of the basic Logic Gate having only a single input and a single output. It is also known as inverter or inverting buffer. When the input signal is "low" the output signal is "high" and vice-versa.

The Boolean expression of NOT Gate is as follows

> Y = Ā orY = A’the value of Y will be high when A will be low.

Y = Ā or

Y = A’

the value of Y will be high when A will be low.

![3](Daily/computer-science/digital-logic/images/3.webp)

### Properties of NOT Gate

- The output of a NOT gate is complemented or inverse of the input applied to it.
- NOT gate takes only one output.

## NOR GATE

The NOR gate is the type of universal logic gate. It takes two or more inputs and gives only one output. The output state of the NOR gate will be high (1) when all the inputs are low (0). NOR gate returns the complement result of the OR gate. It is basically a combination of two basic logic gates i.e., OR gate and NOT gate.

The Boolean expression of NOR gate is as follows:

If A and B are considered as two inputs, and O as output, then the expression for a two input NOR gate will be

> O = (A + B)’The value of O will be true when all of its inputs are set to 0.

O = (A + B)’

The value of O will be true when all of its inputs are set to 0.

![4](Daily/computer-science/digital-logic/images/4.webp)

### Properties of NOR Gate

The following are two important properties of NOR gate:

1. A NOR gate can have two or more inputs and gives an output.
2. A NOR gate gives a high or logic 1 output only when it's all inputs are low or logic 0.

## NAND GATE

The NAND Gate is another type of Universal logic gate. The NAND gate or "Not AND" is the combination of two basic logic gates AND gate and the NOT gate connected in series. It takes two or more inputs and gives only one output. The output of the NAND gate will give result high (1) when either of its input is high (1) or both of its input are low (0). In simple, it performs the inverted operation of AND gate.

The Boolean Expression of NAND Gate is as follows

Say we have two inputs, A and B and the output is called X, then the expression is

> X = (A. B)’

X = (A. B)’

![5](Daily/computer-science/digital-logic/images/5.webp)

### Properties of NAND Gate

The following are the two key properties of NAND Gate

- NAND gate can take two or more inputs at a time and produces one output based on the combination of inputs applied.
- NAND gate produces a low or logic 0 output only when its all inputs are high or logic 1.

## XOR GATE

In digital electronics, there is a specially designed logic gate named, XOR gate, which is used in digital circuits to perform modulo sum. It is also referred to as Exclusive OR gate or Ex-OR gate. it is used extensively in arithmetic logic circuits., logic comparators and error detection circuits. The XOR gate can take only two inputs at a time and give an output. The output of the XOR gate is high (1) only when its two inputs are dissimilar i.e., if one of them is low (0) then other one will be high (1).

Say we have two inputs, A and B and the output is called X, then the expression is

The Boolean expression of XOR Gate is as follows

> X = A’B + AB’

X = A’B + AB’

![6](Daily/computer-science/digital-logic/images/6.webp)

### Properties of XOR Gate

The following two are the main properties of the XOR gate:

- It can accept only two inputs at a time. There is nothing like a three or more input XOR gate.
- The output of the XOR gate is logic 1 or high, when its inputs are dissimilar.

## XNOR GATE

The XNOR is the combination of XOR gate and NOT gate. The output of the XNOR gate is high(1) when both the inputs are high (1) or low(0). In other words, the output of the XNOR gate is high(1) when both the inputs are the same. the XNOR gate can sometimes be called as Equivalence gate. In simple words, The XNOR gate is the complement of the XOR gate.

The following is the Boolean expression of the XNOR gate,

> Y = A ⊙ B

Y = A ⊙ B

Here, A and B are the input variables and Y is the output variable.

This expression can also be written as follows,

> Y = AB + A’B’

Y = AB + A’B’

We can also express the operation of an XNOR gate using XOR gate logic as follows:

> Y = (A ⊕ B)’

Y = (A ⊕ B)’

![7](images_7.webp)

### Properties of XNOR Gate

The following are two key properties of XNOR gate:

- XNOR gate takes only two inputs and produces one output.
- The output of the XNOR gate is high or logic 1 only when it has similar inputs.

## Logic Gates with Symbols, Boolean Expressions, and Truth Tables

![Introduction-of-Logic-Gates](images_introduction-of-logic-gates.webp)

## Logic Gates in Programming

- Program to Implement Logic Gates
- VHDL Code for AND and OR Logic Gates
- Logic Gates in Python

## Design and Implementation of Adders in Digital Logic

- [[full-adder|Full Adder]] in Digital Logic
- Implementation of [[full-adder|Full Adder]] using NOR Gates
- Implementation of [[full-adder|Full Adder]] using NAND Gates
- [[half-adder|Half Adder]] in Digital Logic
- Adders and Subtractors in Digital Logic
- [[half-adder|Half Adder]] and Half Subtractor using NAND NOR Gates
- Difference Between [[half-adder|Half Adder]] and [[full-adder|Full Adder]]
- Binary Adder with Logic Gates
- Implementation of Binary Adder with Logic Gates
- Serial Binary Adder in Digital Logic
- 4 -bit Binary Adder - Subtractor
- What is [[parallel-adder-and-parallel-subtractor|Parallel Adder and Parallel Subtractor]]
- Difference between Serial Adder and Parallel Adder

## Advanced Digital Logic

- Basic Conversion of Logic Gates
- Two-level implementation of logic Gates
- Array Multiplier in Digital Logic
- Self - Dual Functions in Digital Logic
- Realization of logic gate using Universal Gates

## Applications of Logic Gates

Logic gates are the fundamental building blocks of all digital circuits and devices like computers. Here are some key digital devices in which logic gates are utilized to design their circuits.

Here are some devices, where logic gates is used;

- Computers
- Microprocessors
- Microcontrollers
- Various Smartphone Sensors

## Logic Gates For Competitive Exams

- Logic Gates For Aptitude Preparation
- Logic Gates For GATE
- Digital Electronics and Logic Design Tutorials