---
title: "Parallel Adder and Parallel Subtractor"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# Parallel Adder and Parallel Subtractor
An adder adds two binary numbers one bit at a time using carry from each step. A subtractor subtracts one binary number from another using borrow when needed. A parallel adder adds all bits at once, making addition faster. Similarly, a parallel subtractor subtracts all bits at the same time for quicker results. These are important for fast calculations in computers.

## Binary Addition

Binary addition works same as a to regular addition but it only uses two digits: 0 and 1. Remember these rules:

> 0 + 0 = 00 + 1 = 11 + 0 = 11 + 1 = 10 (which means 0 with a carry of 1)

0 + 0 = 00 + 1 = 11 + 0 = 11 + 1 = 10 (which means 0 with a carry of 1)

### Example

Add 13 (1 1 0 1) and 11 (1 0 1 1).

> 1 1 0 1 + 1 0 1 1 ─────1 1 0 0 0

1 1 0 1 + 1 0 1 1 ─────1 1 0 0 0

The result is 11000 in binary, which is 24 in decimal.

## Binary Subtraction

Binary subtraction works like normal subtraction but with binary numbers, we mostly use 2’s complement to make subtraction simple.

### Steps

- Find the 1’s complement of the the number to be subtracted (change 0 to 1 and 1 to 0).
- Add 1 in the 1’s complement, and you will get the 2’s complement.
- Add the 2’s complement to the the original number (minuend).
- If there is a carry beyond the bit-length, ignore it.

### Example

Subtract 11 ( 1 0 1 1 ) from 13 ( 1 1 0 1 ).

- 1’s complement of 1011 → 0100
- Add 1 → 0101 (2’s complement)
- Add to minuend:

> 1 1 0 1 + 0 1 0 1 ───── 0 0 1 0

1 1 0 1 + 0 1 0 1 ───── 0 0 1 0

Ignore the leftmost carry (1), result is 0010 which is 2 in decimal.

## Parallel Adder

A [[full-adder|full adder]] adds two single bits and a carry from the previous addition. It gives two outputs: a sum and a carry. A parallel adder adds two binary numbers that have more than one bit (like 4-bit or 8-bit numbers). It adds all pairs of bits at the same time (in parallel) instead of one after another.

- It is made by connecting many full adders in a row (chain).
- Each [[full-adder|full adder]] handles one pair of bits from the two numbers.
- The carry output from one [[full-adder|full adder]] goes into the carry input of the next [[full-adder|full adder]] on the left (higher bit).
- For an n-bit number, you need n full adders connected in this way. This design helps add large binary numbers faster than adding bits one by one.

![](images_full_adder.png)

### Working of Parallel Adder

1. As you can show in the figure, first of all the [[full-adder|full adder]] FA1 add A1 and B1 along with the carry C1 to generate the sum S1 (the first bit of the output sum) and the carry C2 which is connected to the next adder in chain.
2. Next, the [[full-adder|full adder]] FA2 uses this carry bit C2 to add with the input bits A2 and B2 to generate the sum S2(the second bit of the output sum) and the carry C3 which is again further connected to the next adder in chain and so on.
3. The process continues till the last [[full-adder|full adder]] FAn uses the carry bit Cn to add with its input An and Bn to generate the last bit of the output along last carry bit Cout.

## Parallel Subtractor

A Parallel Subtractor is a digital circuit designed to subtract two binary numbers that are more than one bit long by processing pairs of bits simultaneously (in parallel). This allows subtraction to be performed much faster compared to subtracting bit by bit in sequence.

- The parallel subtractor works by subtracting corresponding bits of the two binary numbers at the same time.
- It uses borrow signals similar to how addition circuits use carry signals to handle differences that require borrowing from the next higher bit.

![](images_subtracter.png)

### Working of Parallel Subtractor

1. As shown in the figure, the parallel binary subtractor is formed by combination of all full adders with subtrahend complement input.
2. This operation considers that the addition of minuend along with the 2’s complement of the subtrahend is equal to their subtraction.
3. Firstly the 1’s complement of B is obtained by the NOT gate and 1 can be added through the carry to find out the 2’s complement of B. This is further added to A to carry out the arithmetic subtraction.
4. The process continues till the last [[full-adder|full adder]] FAn uses the carry bit Cn to add with its input An and 2’s complement of Bn to generate the last bit of the output along last carry bit Cout.

## Advantages of parallel Adder/Subtractor

1. The parallel adder/subtractor performs the addition operation faster as compared to serial adder/subtractor.
2. Time required for addition does not depend on the number of bits.
3. The output is in parallel form i.e. all the bits are added/subtracted at the same time.
4. It is less costly.

## Disadvantages of parallel Adder/Subtractor

1. Each adder has to wait for the carry to come from the previous adder in the chain.
2. The propagation delay( delay associated with the travelling of carry bit) is found to increase with the increase in the number of bits to be added.