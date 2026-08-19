---
title: "BCD Adder in Digital Logic"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# BCD Adder in Digital Logic
BCD stands for binary coded decimal. It is used to perform the addition of BCD numbers. A BCD digit can have any of ten possible four-bit representations. Suppose, we have two 4-bit numbers A and B. The value of A and B can vary from 0(0000 in binary) to 9(1001 in binary) because we are considering decimal numbers.

![](images_ab.png)

The output will vary from 0 to 18 if we are not considering the carry from the previous sum. But if we are considering the carry, then the maximum value of output will be 19 (i.e. 9+9+1 = 19). When we are simply adding A and B, then we get the binary sum. Here, to get the output in BCD form, we will use BCD Adder.

## What is BCD Adder?

A BCD adder is a circuit for the addition of two binary-coded decimal numbers. BCD is another format used in representing numbers where each digit will be represented using a 4-bit binary code. In BCD, it is obvious that the most significant bit (leftmost) is always 0, and therefore each digit will be confined to the range 0-9.

A BCD adder contains four [[full-adder]] circuits in cascade. Each [[full-adder]] is contrived to consider both the two BCD digits being added and a carry-in from the previous stage. The output of each [[full-adder]] produces a sum bit and a carry-out bit, which becomes the input to the following stage.

When adding BCD numbers, if the sum of two BCD digits is greater than 9, the result is greater than 1001 in binary and hence is not valid in BCD. A correction needs to be performed by adding 0110 (6 in BCD) to the sum to get the correct BCD result.

A BCD adder is, overall, a design capable of correctly adding two BCD numbers and making all necessary corrections so that the answer is also a valid BCD number.

## Steps to Design a BCD Adder

- Find Number of Digits : Find out how many Extended digits of BCD the adder should support. A BCD digit requires 4 bits.
- Adder Structure : The [[full-adder|full adder]] connected in series could be selected as the general adder structure. Any extra [[full-adder]] shall be incremented by one BCD digit addition plus a carry from the previous stage.
- [[full-adder|Full-Adder]] Circuit Implementation : Implement a [[full-adder]] circuit capable of adding two 4-bit BCD digits with a carry-in. The [[full-adder|full adder]] shall output a sum bit and a carry-out bit
- Interconnect the Full-Adders : Now, full-adders are connected in series with each other; at this point, carry-out from each stage will be given to carry-in of the next higher order stage.
- Provide BCD Correction : The logic is implemented detecting whether the sum of two BCD digits is greater than 9. In the case of such, 0110 is added to the sum, and carry propagates to the next higher order stage.
- [[test|Test]] the BCD Adder : The BCD adder functionality needs to be checked with the application of different BCD numbers to its input for the correctness of addition and correction handling.

Example 1:

> Input :A = 0111 B = 1000 Output :Y = 1 0101Explanation: We are adding A(=7) and B(=8). The value of binary sum will be 1111(=15). But, the BCD sum will be 1 0101, where 1 is 0001 in binary and 5 is 0101 in binary.

Input :A = 0111 B = 1000 Output :Y = 1 0101Explanation: We are adding A(=7) and B(=8). The value of binary sum will be 1111(=15). But, the BCD sum will be 1 0101, where 1 is 0001 in binary and 5 is 0101 in binary.

Example 2:

> Input :A = 0101 B = 1001Output :Y = 1 0100Explanation: We are adding A(=5) and B(=9). The value of binary sum will be 1110(=14). But, the BCD sum will be 1 0100, where 1 is 0001 in binary and 4 is 0100 in binary.

Input :A = 0101 B = 1001Output :Y = 1 0100Explanation: We are adding A(=5) and B(=9). The value of binary sum will be 1110(=14). But, the BCD sum will be 1 0100, where 1 is 0001 in binary and 4 is 0100 in binary.

> Note: If the sum of two numbers is less than or equal to 9, then the value of BCD sum and binary sum will be same otherwise they will differ by 6(0110 in binary). Now, lets move to the table and find out the logic when we are going to add "0110".

Note: If the sum of two numbers is less than or equal to 9, then the value of BCD sum and binary sum will be same otherwise they will differ by 6(0110 in binary). Now, lets move to the table and find out the logic when we are going to add "0110".

![](images_tt-1.png)

We are adding "0110" (=6) only to the second half of the table. The conditions are:

1. If C' = 1 (Satisfies 16-19)
2. If S3'.S2' = 1 (Satisfies 12-15)
3. If S3'.S1' = 1 (Satisfies 10 and 11)

So, our logic is

> C' + S3'.S2' + S3'.S1' = 1

C' + S3'.S2' + S3'.S1' = 1

![](images_cc.png)

## Advantages of BCD Adder

There are various reasons why a BCD adder is beneficial in digital logic.

- Decimal Precision : BCD adders guarantee that when adding decimal numbers, they do not make mistakes since the process is conducted on digits that are Binary-Coded Decimal direct (0-9) this rules out any error related to switching from base 10 to base 2 or vice versa.
- Simplified Decimal Arithmetic : When it comes to decimal arithmetic operations, BCD adders offer computerized systems with an easier way out making them fit for fields where calculations are predominantly in decimals such as, anywhere money is involved – shopping stores or market areas; calculators; and even real-time clocks.
- Common Display Compatibility : The common display technologies such as 7-segment displays are directly compatible with BCD numbers thus making BCD adders suitable for applications where output should be displayed directly in decimal format.
- Mistake Recognition : Just a simple addition is all that is required by such devices so as to find out the parity of invalid BCDs (for instance those larger than digit 9), making it easier for FEC systems. In this manner it forms part of an error detection system and correction scheme that ensure precision results.
- High-Efficiency Circuit Design : BCD adders facilitate the creation of efficient, optimized circuits specifically designed for decimal arithmetic, which results in speedier processing times and less complicated digital circuits.

These benefits show how critical BCD adders are in processing decimal arithmetic using digital logic well and correctly.

## Disadvantages of BCD Adder

- Memory Misallocation : In comparison to binary digits, the BCD figures take up more memory to portray comparable values, hence generating greater memory use within BCD operational systems.
- Restricted Set of Values : BCD adders are constrained to only decimal digits (0-9) hence cannot carry out direct arithmetic on values that are beyond this range without extra conversion circuitry thus restricting their versatility in some applications.
- Lower Speed of Arithmetic Operations : Since they require BCD correction and manage decimal numbers, BCD adders may have lower operational speeds than binary ones affecting the overall performance of digital systems.
- Compatibility concerns : BCD arithmetic could be at odds with some techniques or algorithms especially those that are improved to perform better in binary arithmetic; hence you get such compatibility problems when using both types of arithmetics within a system.
- High Circuit Complexity : BCD adders are more complicated than binary adders owing to BCD correction logic requirements that make sure valid BCD outputs are produced. This increased complexity can also lead to bigger circuit sizes as well as more difficult designs.