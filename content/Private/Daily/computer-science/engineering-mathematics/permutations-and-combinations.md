---
title: "Permutations and Combinations"
topic: "engineering-mathematics"
scraped_date: [[2026-03-29]]
---

# Permutations and Combinations
Permutation and Combination are the most fundamental concepts in mathematics related to picking items from a group or set.

- Permutation is the arrangement of items in which the order of selection matters.
- A combination is selecting items without considering order.

For example, in the diagram below, PQ and QP are different in permutation but the same in combination. Therefore, we have more permutations than combinations.

![Permutation-an-Combination](images_permutation-an-combination.webp)

## Permutation Meaning

Permutation is the way of arranging items where order is important. For example, if we have two components A and B, then they can be arranged in these ways, {AB and BA}.

Permutation is represented as n Pr .

- Where ‘r’ is the permutation size, like how many components you have to choose.
- Whereas ‘n’ is the total number of components present.

> For example, let n = 3 (A, B and C) and r = 2 (All permutations of size 2). Then there are 3P2 such permutations, which is equal to 6. These six permutations are AB, AC, BA, BC, CA and CB. The six permutations of A, B and C taken three at a time are shown in the image added below:

For example, let n = 3 (A, B and C) and r = 2 (All permutations of size 2). Then there are 3P2 such permutations, which is equal to 6. These six permutations are AB, AC, BA, BC, CA and CB. The six permutations of A, B and C taken three at a time are shown in the image added below:

![Permutation of Two elements out of A, B, and C](images_permutation-of-two-elements-out-of-a-b-and-c.webp)

### Permutation Formula

Permutation formula is used to find the number of ways to pick ‘r’ things out of ‘n’ different things in a specific order and replacement is not allowed. The formula is given as follows:

![Permutation Formula](images_permutation-formula.webp)

### Explanation of Permutation Formula

As we know, permutation is an arrangement of r things out of n where the order of arrangement is important( AB and BA are two different permutations).

For example:

> If there are three different numerals 1, 2 and 3 and to permute the numerals Taking r = 2, it gives (1, 2), (1, 3), (2, 1), (2, 3), (3, 1) and (3, 2) - 6 ways Here, (1, 2) and (2, 1) are distinct. Putting the third left numeral to each cases we get (1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2) and (3, 2, 1) - 6 ways

If there are three different numerals 1, 2 and 3 and to permute the numerals Taking r = 2, it gives (1, 2), (1, 3), (2, 1), (2, 3), (3, 1) and (3, 2) - 6 ways Here, (1, 2) and (2, 1) are distinct. Putting the third left numeral to each cases we get (1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2) and (3, 2, 1) - 6 ways

In general, n distinct things can be set taking r (r < n) at a time in n(n - 1)(n - 2)...(n - r - 1) ways. In fact, the first thing can be any of the n things. Now, after choosing the first thing, the second thing will be any of the remaining n - 1 things. Likewise, the third thing can be any of the remaining n - 2 things. Alike, the rth thing can be any of the remaining n - (r - 1) things.

![pnc](images_pnc.webp)

Hence, the entire number of permutations of n distinct things carrying r at a time is n(n - 1)(n - 2)...[n - (r - 1)], which is written as n Pr. Or, in other words,

> \bold{{}^nP_r = \frac{n!}{(n-r)!} }

\bold{{}^nP_r = \frac{n!}{(n-r)!} }

## Combination Meaning

It is the way of arranging given number of components, where order is not given importance. For example, if there are two components A and B, then there is only one way to select two things, i.e. AB and BA represents the same combination.

> For example, let n = 3 (A, B and C) and r = 2 (All combinations of size 2). Then there are 3C2 such combinations, which is equal to 3. These three combinations are AB, AC and BC.Here, the combination of any two letters out of three letters A, B and C is shown below, the order in which A and B are taken is not important as AB and BA represent the same combination.

For example, let n = 3 (A, B and C) and r = 2 (All combinations of size 2). Then there are 3C2 such combinations, which is equal to 3. These three combinations are AB, AC and BC.Here, the combination of any two letters out of three letters A, B and C is shown below, the order in which A and B are taken is not important as AB and BA represent the same combination.

![what is combination](images_what-is-combination.webp)

Note: In the example of selecting 2 items among A and B, we can say that,

- AB and BA are two distinct items i.e., two distinct permutation.
- AB and BA are the same i.e., same combination.

### Combination Formula

Combination Formula is used to choose ‘r’ components out of a total number of ‘n’ components and is given by:

![Combination Formula](images_combination-formula.webp)

Using the above formula for r and (n-r), we get the same result. Thus,

> \bold{{}^nC_r = {}^nC_{(n-r)}}

\bold{{}^nC_r = {}^nC_{(n-r)}}

### Explanation of Combination Formula

> Combination, on the further hand, is a type of pack. Again, out of those three numbers 1, 2 and 3 if sets are created with two numbers, then the combinations are (1, 2), (1, 3) and (2, 3). Here, (1, 2) and (2, 1) are identical, unlike permutations where they are distinct. This is written as 3C2. In general, the number of combinations of n distinct things taken r at a time is, \bold{{}^nC_r = \frac{n!}{r!\times(n-r)!} = \frac{{}^nP_r}{r!}}

Combination, on the further hand, is a type of pack. Again, out of those three numbers 1, 2 and 3 if sets are created with two numbers, then the combinations are (1, 2), (1, 3) and (2, 3).

Here, (1, 2) and (2, 1) are identical, unlike permutations where they are distinct. This is written as 3C2. In general, the number of combinations of n distinct things taken r at a time is,

\bold{{}^nC_r = \frac{n!}{r!\times(n-r)!} = \frac{{}^nP_r}{r!}}

## Derivation of Permutation and Combination Formulas

We can derive these Permutation and Combination formulas using the basic counting methods, as these formulas represent the same thing. Derivation of these formulas is as follows:

### Derivation of Permutations Formula

Permutation is selecting r distinct objects from n objects without replacement and where the order of selection is important. By the fundamental theorem of counting and the definition of permutation, we get

> P (n, r) = n . (n-1) . (n-2) . (n-3). . . . .(n-(r+1))

P (n, r) = n . (n-1) . (n-2) . (n-3). . . . .(n-(r+1))

By multiplying and dividing above with (n-r)! = (n-r).(n-r-1).(n-r-2). . . . .3. 2. 1, we get

> P (n, r) = [n.(n−1).(n−2)….(nr+1)[(n−r)(n−r−1)(n-r)!] / (n-r)!⇒ P (n, r) = n!/(n−r)!

P (n, r) = [n.(n−1).(n−2)….(nr+1)[(n−r)(n−r−1)(n-r)!] / (n-r)!

⇒ P (n, r) = n!/(n−r)!

Thus, the formula for P (n, r) is derived.

### Derivation of Combinations Formula

Combination is choosing r items out of n items when the order of selection is of no importance. Its formula is calculated as,

> C(n, r) = Total Number of Permutations /Number of ways to arrange r different objects. [Since by the fundamental theorem of counting, we know that number of ways to arrange r different objects in r ways = r!]C(n,r) = P (n, r)/ r!⇒ C(n,r) = n!/(n−r)!r!

C(n, r) = Total Number of Permutations /Number of ways to arrange r different objects. [Since by the fundamental theorem of counting, we know that number of ways to arrange r different objects in r ways = r!]

C(n,r) = P (n, r)/ r!

⇒ C(n,r) = n!/(n−r)!r!

Thus, the formula for Combination i.e., C(n, r) is derived.

## Permutation vs Combination

Differences between permutation and combination can be understood by the following table:

| Permutation | Combination |
| --- | --- |
| In Permutation order of arrangement is important.For example, AB and BA are different combinations. | In Combination order of arrangement is not important.For example, AB and BA are the same combinations. |
| A permutation is used when different kinds of things are to be sorted or arranged. | Combinations are used when the same kind of things are tobe sorted. |
| Permutation of two things out of three given things a, b, c is ab, ba, bc, cb, ac, ca. | The combination of two things from the three given thingsa, b, c is ab, bc, ca. |
| Formula for permuation is: n Pr = n!/(n - r)! | The formula for Combination is: n Cr = n! /{r! × (n - r)!} |

Permutation

Combination

### Related Article

- Binomial Theorem
- Binomial Expansion
- Binomial Random Variables
- Fundamental Theorem of Counting

## Solved Examples on Permutation and Combination

Example 1: Find the number of permutations and combinations of n = 9 and r = 3.

Solution:

> Given, n = 9, r = 3Using the formula given above:For Permutation:nPr = (n!) / (n - r)! ⇒ nPr = (9!) / (9 - 3)! ⇒ nPr = 9! / 6! = (9 × 8 × 7 × 6! )/ 6! ⇒ nPr = 504For Combination:nCr = n!/r!(n − r)!⇒ nCr = 9!/3!(9 − 3)!⇒ nCr = 9!/3!(6)!⇒ nCr = 9 × 8 × 7 × 6!/3!(6)!⇒ nCr = 84

Given, n = 9, r = 3

Using the formula given above:

For Permutation:

nPr = (n!) / (n - r)! ⇒ nPr = (9!) / (9 - 3)! ⇒ nPr = 9! / 6! = (9 × 8 × 7 × 6! )/ 6! ⇒ nPr = 504

For Combination:

nCr = n!/r!(n − r)!⇒ nCr = 9!/3!(9 − 3)!⇒ nCr = 9!/3!(6)!⇒ nCr = 9 × 8 × 7 × 6!/3!(6)!

⇒ nCr = 84

Example 2: In how many ways can a committee consisting of 4 men and 2 women can be chosen from 6 men and 5 women?

Solution:

> Choose 4 men out of 6 men = 6C4 ways = 15 waysChoose 2 women out of 5 women = 5C2 ways = 10 waysThe committee can be chosen in 6C4 × 5C2 = 150 ways.

- Choose 4 men out of 6 men = 6C4 ways = 15 ways
- Choose 2 women out of 5 women = 5C2 ways = 10 ways

The committee can be chosen in 6C4 × 5C2 = 150 ways.

Example 3: In how many ways can 5 different books be arranged on a shelf?

Solution:

> This is a permutation problem because the order of the books matters. Using the permutation formula, we get:5P5 = 5! / (5 - 5)! = 5! / 0! = 5 x 4 x 3 x 2 x 1 = 120Therefore, there are 120 ways to arrange 5 different books on a shelf.

This is a permutation problem because the order of the books matters.

Using the permutation formula, we get:5P5 = 5! / (5 - 5)! = 5! / 0! = 5 x 4 x 3 x 2 x 1 = 120

Therefore, there are 120 ways to arrange 5 different books on a shelf.

Example 4: How many 3-letter words can be formed using the letters from the word "FABLE"?

Solution:

> This is a permutation problem because the order of the letters matters. Using the permutation formula, we get:5P3 = 5! / (5 - 3)! = 5! / 2! = 5 x 4 x 3 = 60Therefore, there are 60 3-letter words that can be formed using the letters from the word "FABLE".

This is a permutation problem because the order of the letters matters.

Using the permutation formula, we get:5P3 = 5! / (5 - 3)! = 5! / 2! = 5 x 4 x 3 = 60

Therefore, there are 60 3-letter words that can be formed using the letters from the word "FABLE".

Example 5: A committee of 5 members is to be formed from a group of 10 people. In how many ways can this be done?

Solution:

> This is a combination problem because the order of the members doesn't matter. Using the combination formula, we get:10C5 = 10! / (5! x (10 - 5)!) = 10! / (5! x 5!) ⇒10C5= (10 x 9 x 8 x 7 x 6) / (5 x 4 x 3 x 2 x 1) = 252Therefore, there are 252 ways to form a committee of 5 members from a group of 10 people.

This is a combination problem because the order of the members doesn't matter.

Using the combination formula, we get:

10C5 = 10! / (5! x (10 - 5)!) = 10! / (5! x 5!) ⇒10C5= (10 x 9 x 8 x 7 x 6) / (5 x 4 x 3 x 2 x 1) = 252

Therefore, there are 252 ways to form a committee of 5 members from a group of 10 people.

Example 6: A pizza restaurant offers 4 different toppings for their pizzas. If a customer wants to order a pizza with exactly 2 toppings, in how many ways can this be done?

Solution:

> This is a combination problem because the order of the toppings doesn't matter. Using the combination formula, we get:4C2 = 4! / (2! x (4 - 2)!) = 4! / (2! x 2!) = (4 x 3) / (2 x 1) = 6Therefore, there are 6 ways to order a pizza with exactly 2 toppings from 4 different toppings.

This is a combination problem because the order of the toppings doesn't matter.

Using the combination formula, we get:4C2 = 4! / (2! x (4 - 2)!) = 4! / (2! x 2!) = (4 x 3) / (2 x 1) = 6

Therefore, there are 6 ways to order a pizza with exactly 2 toppings from 4 different toppings.

Example 7: How many considerable words can be created by using 2 letters from the term“LOVE”?

Solution:

> The term “LOVE” has 4 distinct letters.Therefore, required number of words = 4P2 = 4! / (4 – 2)!Required number of words = 4! / 2! = 24 / 2⇒ Required number of words = 12

The term “LOVE” has 4 distinct letters.

Therefore, required number of words = 4P2 = 4! / (4 – 2)!

Required number of words = 4! / 2! = 24 / 2

⇒ Required number of words = 12

Example 8: Out of 5 consonants and 3 vowels, how many words of 3 consonants and 2 vowels can be formed?

Solution:

> Number of ways of choosing 3 consonants from 5 = 5C3Number of ways of choosing 2 vowels from 3 = 3C2Number of ways of choosing 3 consonants from 2 and 2 vowels from 3 = 5C3 × 3C2⇒ Required number = 10 × 3= 30It means we can have 30 groups where each group contains a total of 5 letters (3 consonants and 2 vowels).Number of ways of arranging 5 letters among themselves= 5! = 5 × 4 × 3 × 2 × 1 = 120Hence, the required number of ways = 30 × 120⇒ Required number of ways = 3600

Number of ways of choosing 3 consonants from 5 = 5C3Number of ways of choosing 2 vowels from 3 = 3C2Number of ways of choosing 3 consonants from 2 and 2 vowels from 3 = 5C3 × 3C2

⇒ Required number = 10 × 3= 30

It means we can have 30 groups where each group contains a total of 5 letters (3 consonants and 2 vowels).

Number of ways of arranging 5 letters among themselves= 5! = 5 × 4 × 3 × 2 × 1 = 120

Hence, the required number of ways = 30 × 120

⇒ Required number of ways = 3600

Example 9: How many different combinations do you get if you have 5 items and choose 4?

Solution:

> Insert the given numbers into the combinations equation and solve. “n” is the number of items that are in the set (5 in this example); “r” is the number of items you’re choosing (4 in this example):C(n, r) = n! / r! (n – r)! ⇒ nCr = 5! / 4! (5 – 4)!⇒ nCr = (5 × 4 × 3 × 2 × 1) / (4 × 3 × 2 × 1 × 1)⇒ nCr = 120/24 ⇒ nCr = 5The solution is 5.

Insert the given numbers into the combinations equation and solve. “n” is the number of items that are in the set (5 in this example); “r” is the number of items you’re choosing (4 in this example):

C(n, r) = n! / r! (n – r)! ⇒ nCr = 5! / 4! (5 – 4)!⇒ nCr = (5 × 4 × 3 × 2 × 1) / (4 × 3 × 2 × 1 × 1)⇒ nCr = 120/24 ⇒ nCr = 5

The solution is 5.

Example 10: Out of 6 consonants and 3 vowels, how many expressions of 2 consonants and 1 vowel can be created?

Solution:

> Number of ways of selecting 2 consonants from 6 = 6C2Number of ways of selecting 1 vowels from 3 = 3C1Number of ways of selecting 3 consonants from 7 and 2 vowels from 4.⇒ Required ways = 6C2 × 3C1⇒ Required ways = 15 × 3⇒ Required ways= 45It means we can have 45 groups where each group contains a total of 3 letters (2 consonants and 1 vowels).Number of ways of arranging 3 letters among themselves = 3! = 3 × 2 × 1⇒ Required ways to arrange three letters = 6Hence, the required number of ways = 45 × 6⇒ Required ways = 270

Number of ways of selecting 2 consonants from 6 = 6C2Number of ways of selecting 1 vowels from 3 = 3C1Number of ways of selecting 3 consonants from 7 and 2 vowels from 4.⇒ Required ways = 6C2 × 3C1⇒ Required ways = 15 × 3⇒ Required ways= 45

It means we can have 45 groups where each group contains a total of 3 letters (2 consonants and 1 vowels).

Number of ways of arranging 3 letters among themselves = 3! = 3 × 2 × 1⇒ Required ways to arrange three letters = 6

Hence, the required number of ways = 45 × 6

⇒ Required ways = 270

## Practice Questions - Permutations and Combinations

Question 1: How many ways can 5 books be arranged on a shelf?

Question 2: In how many ways can a committee of 3 be chosen from a group of 10 people?

Question 3: How many 4-digit PIN codes can be created using the digits 0-9 if repetition is allowed?

Question 4: A pizza shop offers 8 toppings. How many different 3-topping pizzas can be made?

Question 5: In how many ways can 6 people be seated at a round table?

Question 6: How many ways are there to select 2 boys and 3 girls from a class of 5 boys and 6 girls?

Question 7: How many different 5-card hands can be dealt from a standard 52-card deck?

Question 8: In how many ways can the letters of the word "MATHEMATICS" be arranged?

Question 9: A bag contains 5 red marbles, 3 blue marbles and 2 green marbles. How many ways are there to select 4 marbles?

Question 10: How many ways are there to arrange the letters in the word "MISSISSIPPI"?