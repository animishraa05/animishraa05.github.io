---
title: "Excess-3 Code"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# Excess-3 Code
Excess-3 is a binary coded decimal (BCD) code with unquestionable significance, seen for its work in enhancing number shuffling tasks in early enlisting structures and smaller-than-expected PCs. It offers an intriguing depiction for each decimal digit by adding a legitimate worth of 3 to the standard 4-cycle matched depiction. In a paired environment, the goal of this distinctive coding strategy was to smooth out math processes.

## What is Binary Coded Decimal (BCD)?

Binary Coded Decimal is a type of binary encoding method. It is used to represent the decimal number in a form of a binary. In BCD, each digit of the number is encoded by fixed binary numbers.

This type of coding is called Binary Coded Decimal, where it gives the decimal number a binary representation; instead of using one binary bit for every digit to represent in decimal, it uses a group of four binary bits, which then helps in easier human interaction and computation with decimal numbers.

### Types of Binary Coded Decimal (BCD)

1. 8421 BCD (Natural BCD): Nonoverlapping; each decimal digit is represented in 4-bit binary. Example: Decimal 7 = 0111
2. Excess-3 BCD: Each decimal digit is incremented by 3 before being converted to binary; it is very commonly used for error detection. Example: Decimal 0 = 0011
3. Packed BCD: Two decimal digits are represented in one byte; that is, 8 bits are used. Example: Decimal 75 = 01110101
4. Unpacked BCD: One decimal digit per byte; the lower nibble represents the digit. For example: Decimal 7 = 00000111
5. Gray Coded BCD: Ensures that only one bit change between two consecutive decimal digits to prevent errors.

## What is Excess-3 Code?

The Excess-3 code, also known as the Stibitz code, it is a binary coded decimal (BCD) code that is utilized to address decimal digits that are arranged in a particular double structure. In this coding plan, each decimal digit is tended to by its relating 4-bit double portrayal with the extension of 3. The essential job of Excess-3 code is to enhance math undertakings in a twofold environment, especially in early figuring systems and smaller than normal PCs.

## Representation of Excess-3 Code

The Excess-3 code for the decimal number is as follows:

| DECIMAL DIGIT | BCD CODE | EXCESS-3 CODE |
| --- | --- | --- |
| 0 | 0000 | 0011 |
| 1 | 0001 | 0100 |
| 2 | 0010 | 0101 |
| 3 | 0011 | 0110 |
| 4 | 0100 | 0111 |
| 5 | 0101 | 1000 |
| 6 | 0110 | 1001 |
| 7 | 0111 | 1010 |
| 8 | 1000 | 1011 |
| 9 | 1001 | 1100 |

DECIMAL DIGIT

BCD CODE

EXCESS-3 CODE

### 0

0000

0011

### 1

0001

0100

### 2

0010

0101

### 3

0011

0110

### 4

0100

0111

### 5

0101

1000

### 6

0110

1001

### 7

0111

1010

### 8

1000

1011

### 9

1001

1100

In excess-3 code, the codes 1111 and 0000 are never used for any decimal digit. Now let's take few examples of Excess-3 code.

## Solved Examples of Excess 3 Code

We have some examples to understand the concept better :

### Example - 1 : Decimal number of 9

Binary Representation of 9 is 1001

Now Add 3 to Each Bit: 1001 + 0011 = 1100

Therefore, 1100 is the Excess - 3 code for the decimal number 9

### Example - 2 : Decimal number of 15

Add 3 to 1 and 5 both separately after converting them into binary(4 bit).

So, 1 = (0001)2 and 5 = (0101)2

Now add 3 to both the digit, 1+3 = 4 = (0100)2 and 5+3 = 8 = (1000)2

Therefore, 0100 1000 is the Excess - 3 code for the decimal number 15

### Example - 3 : Decimal number of 6

Binary Representation of 6 is 0110

Now Add 3 to each Bit: 0110 + 0011 = 1001

Therefore, 1001 is the Excess - 3 code for the decimal number 6

## Why we use Excess-3 ?

There are the following advantages of excess-3 code which make it required to use:

- These codes are generally unweighted binary decimal codes.
- These codes are self-integral.
- These codes utilize biased representation.
- The excess-3 code has no limit, so it significantly works on arithmetic activities.
- This code plays an essential part in arithmetic tasks. It is on the grounds that it settle inadequacies which are experienced when we utilize the 8421 BCD code for adding two decimal digits whose aggregate is more prominent than 9.

## Converting into Binary Coded Decimal (BCD) Codes

Converting Excess 3 code 1010101 into BCD number.

STEP 1 - Group the number in 4-bit format.

1010101 = 0101 0101

STEP 2 - Subtract the formed number with 0011 0011

0101 0101 - 0011 0011 = 0010 0010

So, the BCD number will be 0010 0010.

## Self-Complementary Property

Excess 3 code having the property of self complementary which means they are always complements themselves. If we have 0 then it will complement with 1, or if it will have 1 then it will complements with 1.

Additionally, the XS-3 code is regarded as the Excess-3 code. To address decimal numbers, the excess-3 code is a self-correlative, non-weighted BCD code. The portrayal of this code is biased. This code expects a huge part in calculating undertakings since it settle needs experienced when we use the 8421 BCD code for adding two decimal digits whose total is more unmistakable than 9. As opposed to the typical non-one-sided BCD or the twofold positional number framework, the Overabundance 3 code utilizes an exceptional sort of calculation.

### Example

Excess 3 code for 5 = 1000

1's complement of 1000 = 0111

And 0111 is the excess 3 code for 4

## Advantages of Excess-3 Code

- Simplifies Arithmetic Operations: Excess -3's ability to improve on math tasks like expansion and deduction in a binary-coded decimal (BCD) environment is one of its primary advantages. The extension of 3 to each digit streamlines the convey spread process.
- Decimal to Binary Translation: The clear course of changing over from decimal to Excess -3 makes it more straightforward to make an interpretation of decimal digits into a paired coded structure straightforwardly.
- Compatibility with Binary Systems: Excess -3 is designed to work with paired frameworks, so it's good for applications that need to show and control decimal digits directly in a parallel coded system.
- Convey Proliferation Improvement: The extension of 3 to each cycle in Excess -3 adds to a dealt with convey multiplication framework during number shuffling undertakings, particularly in electronic circuits.
- Unique Representation: Excess -3 gives an original twofold depiction to each decimal digit. This uniqueness deals with botch distinguishing proof and ensures that each digit has an indisputable code.

## Disadvantages of Excess-3 Code

- Limited Applicability in Modern Computing:Excess-3 was for the most part basic, it is less commonly used in current enlisting. More capable coding plans have been made to address express necessities in contemporary structures.
- Representation that Is Invalid: The addition of three to each piece results in a more prominent code than is required for double-coded decimal representation. This ought to be noticeable as a kind of clear redundancy, and more capable coding plans could avoid such excess.
- Historical Context: While Excess-3's verifiable importance is significant, it may not consolidate a portion of the developments and improvements that have been created in later coding plans.
- Reverse conversion complexity: While changing over from Excess-3 to decimal is possible by deducting 3 from each piece, the collaboration may be considered less intuitive appeared differently in relation to other coding plans. This complexity may be a disadvantage in some circumstances.
- Not Appropriate for Non-Decimal Bases:Excess-3 is expressly expected for decimal digits, and its properties may not be directly appropriate to bases other than 10. For non-decimal bases, elective coding plans may be more appropriate.

## Applications of Excess-3 Code

- Electronic Calculators: In the early electronic adding machines, excess-3 was much of the time used to perform decimal number-crunching. Its clever coding plan enhanced the execution of development and derivation errands in these contraptions.
- Computer Decimal Arithmetic:Excess-3 discovered PC decimal math applications at the start of processing. It was essential for particular computations and information handling tasks due to its ability to smooth out activities involving number juggling.
- Error Detection: The excellent depiction of each and every decimal digit in excess-3works with botch acknowledgment. Deviations from expected codes can show botches in calculating exercises or data depiction.
- Digital Communication Systems: In unambiguous high level correspondence systems where decimal data ought to be conveyed or taken care of, excess-3 can be utilized to chip away at decimal calculating undertakings.
- Education and Training:Excess-3 is ordinarily used in educational settings to show equal coded decimal number shuffling and to frame coding plans. It gives a genuine delineation to fathoming how parallel conditions address decimal digits.

## Differences Between BCD, Gray Code and Excess-3 Code

| FEATURE | BCD(Binary Coded Decimal) | Gray Code | Excess-3 |
| --- | --- | --- | --- |
| Decimal Range | It represents decimal digits from 0 to 9 | It represents decimal digits from 0 to 9 | It represents decimal digits from -3 to 6 |
| Arithmetic Operation | It is well- suited for arithmetic operation | It is Not well- suited for arithmetic operation | It is well- suited for arithmetic operation |
| Code Efficiency | Less efficient | More efficient | Less efficient |
| Bit Changes | Multiple bits change | Only one bit changes | Multiple bits changes |
| Error Detection | BCD provides good error detection | It provides good error detection due to single bit changes | It provides good error detection |
| Binary to Decimal Conversion | Straightforward conversion from 4 bit to decimal | More complex conversion due to non linear nature | Subtracting 3 from each 4 bit binary representation |
| Applications | Commonly used in displays and calculators | it is used in rotary [[encoders]] | it is used in BCD adders |

FEATURE

BCD(Binary Coded Decimal)

Gray Code

Excess-3

Decimal Range

It represents decimal digits from 0 to 9

It represents decimal digits from 0 to 9

It represents decimal digits from -3 to 6

Arithmetic Operation

It is well- suited for arithmetic operation

It is Not well- suited for arithmetic operation

It is well- suited for arithmetic operation

Code Efficiency

Less efficient

More efficient

Less efficient

Bit Changes

Multiple bits change

Only one bit changes

Multiple bits changes

Error Detection

BCD provides good error detection

It provides good error detection due to single bit changes

It provides good error detection

Binary to Decimal Conversion

Straightforward conversion from 4 bit to decimal

More complex conversion due to non linear nature

Subtracting 3 from each 4 bit binary representation

Applications

Commonly used in displays and calculators

it is used in rotary [[encoders]]

it is used in BCD adders