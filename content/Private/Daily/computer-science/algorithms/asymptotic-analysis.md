---
title: "Asymptotic Analysis"
topic: "algorithms"
tags: [algorithms, gate-cse, dsa, algorithms, gate-cse, dsa, algorithms, gate-cse, dsa]
scraped_date: [[2026-03-29]]
---

# Asymptotic Analysis
Given two algorithms for a task, how do we find out which one is better?

A naive approach is to implement both algorithms and compare their running times on different inputs, but this method has many drawbacks for analyzing algorithms.

- It might be possible that for some inputs, the first algorithm performs better than the second. And for some inputs second performs better.
- It might also be possible that for some inputs, the first algorithm performs better on one machine, and the second works better on another machine for some other inputs.

> Asymptotic analysis evaluates an algorithm’s performance based on input size, ignoring actual running time. It measures the order of growth of time or space; for example, linear search grows linearly, while [[binary-search|binary search]] grows logarithmically.

Asymptotic analysis evaluates an algorithm’s performance based on input size, ignoring actual running time. It measures the order of growth of time or space; for example, linear search grows linearly, while [[binary-search|binary search]] grows logarithmically.

For example: Let us consider the search problem (searching a given item) in a sorted array.

The solution to above search problem includes:

- Linear Search (order of growth is linear)
- [[binary-search|Binary Search]] (order of growth is logarithmic).

To understand how Asymptotic Analysis solves the problems mentioned above in analyzing algorithms,

- Suppose we run Linear Search on computer A (faster) and [[binary-search|Binary Search]] on computer B (slower).
- For small input sizes, Linear Search may take less time because computer A is faster.
- As the input size increases, [[binary-search|Binary Search]] eventually becomes faster, even on the slower computer B.
- This happens because Linear Search grows linearly, while [[binary-search|Binary Search]] grows logarithmically with input size.
- After a certain input size, machine-dependent constants (e.g., A being 5000× faster than B) no longer matter.
- Asymptotic analysis focuses on this growth, allowing us to compare algorithms independent of machine speed for large inputs.

| Input Size | Running time on A | Running time on B |
| --- | --- | --- |
| 10 | 2 sec | ~ 1 h |
| 100 | 20 sec | ~ 1.8 h |
| 10^6 | ~ 55.5 h | ~ 5.5 h |
| 10^9 | ~ 6.3 years | ~ 8.3 h |

Running times for this example:

- Linear Search running time in seconds on A: 0.2 * n
- [[binary-search|Binary Search]] running time in seconds on B: 1000*log(n)

Does Asymptotic Analysis always work?

- Asymptotic analysis is the best general method for analyzing algorithms, even though it is not perfect.
- It ignores constant factors, so two algorithms with the same asymptotic complexity (e.g., 1000n*log ⁡n vs 2n*log⁡ n) cannot be directly compared for practical speed.
- Asymptotic analysis focuses on large input sizes, but in real applications, these inputs may never occur.
- An algorithm that is asymptotically slower can perform better for specific inputs, so practical performance may lead to choosing it over a theoretically faster algorithm.