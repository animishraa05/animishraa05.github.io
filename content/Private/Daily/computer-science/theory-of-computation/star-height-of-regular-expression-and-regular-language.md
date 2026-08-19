---
title: "Star Height of Regular Expression and Regular Language"
topic: "theory-of-computation"
scraped_date: [[2026-03-29]]
---

# Star Height of Regular Expression and Regular Language
The star height relates to the field of theoretical computation (TOC). It is used to indicate the structural complexity of regular expressions and regular languages. In this context, complexity refers to the maximum nesting depth of Kleene stars present in a regular expression. A regular language may be represented by multiple equivalent regular expressions, each having different star heights based on their structure.

- Concept in TOC: Star height is a concept studied in theoretical computation to analyze regular languages.
- Measure of structure: It measures how complex a regular expression is based on how deeply the Kleene star (*) is nested.
- Expression-dependent: Different regular expressions for the same language can have different star heights.
- Language-dependent: Each regular language has a single, well-defined star height.
- Minimum complexity: The star height of a language is the smallest nesting depth required to describe it using any regular expression.

`*`

![star_height_0](images_star_height_0.webp)

## Generalized Star Height

The generalized star height defines the minimum nesting depth of Kleene stars required to describe the language using a generalized regular expression.

For example, consider the language “aba” over the alphabet set {a,b}:

> (a + b)^* → Star height = 1 (a^* b^*)^* → Star height = 2

1. (a + b)^* → Star height = 1
2. (a^* b^*)^* → Star height = 2

Since we consider the least star height, the star height of the regular language “aba” is 1.

### Recursive rules for Star Height

The star height of a regular expression is formally defined as:

- h(\phi) = 0 , where 𝜙 represents the empty set.
- h(\epsilon) = 0 , where 𝜀 represents the empty string.
- h(t) = 0 , where t is any terminal symbol of an alphabet set.
- h(EF) = \max(h(E), h(F)) , where E and F are regular expressions.
- h(E^*) = h(E) + 1.

### Examples of Star Height

> h(a^*(ba^*)^*) = 2 h((a b^*) + ((a^* a b^*)^* b)^*) = 3 h(a) = 0

- h(a^*(ba^*)^*) = 2
- h((a b^*) + ((a^* a b^*)^* b)^*) = 3
- h(a) = 0

## Advantages of Considering Star Height

1. Complexity Analysis

- Provides a measure of repetition complexity in regular expressions or languages.
- Helps in evaluating the efficiency of pattern matching, parsing, and automaton construction.
- Aids in analyzing algorithm feasibility and implementation efficiency.

2. Expressive Power Assessment

- Higher star height indicates a greater nesting of repetition.
- Helps in understanding the expressiveness of a regular expression.
- Useful in comparing different language structures.

3. Design Considerations

- Impacts the design of algorithms and data structures for regular expressions.
- Automata with low star height may use finite automata, while higher star heights may require pushdown automata.

## Disadvantages of Considering Star Height

1. Limited to Regular Languages

- Only applicable to regular expressions and regular languages.
- Cannot be directly used for context-free or context-sensitive languages.

2. Overemphasis on Repetition

- Focuses only on repetition complexity, missing nested structures (e.g., balancing rules, context-sensitivity).
- May provide an incomplete understanding of language complexity.

3. Computational Limitations

- Determining star height is undecidable in general.
- Computational cost can be high for large or complex regular expressions.

4. Star Height May Not Correlate with Real-World Applications

- Theoretical complexity does not always match practical performance.
- Algorithm optimizations, input data, and domain-specific factors can influence efficiency beyond just star height.