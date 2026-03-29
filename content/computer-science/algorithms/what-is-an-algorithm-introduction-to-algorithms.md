---
title: "What is an Algorithm | Introduction to Algorithms"
topic: "algorithms"
tags: [algorithms, gate-cse, dsa, algorithms, gate-cse, dsa, algorithms, gate-cse, dsa]
scraped_date: [[2026-03-29]]
---

# What is an Algorithm | Introduction to Algorithms
Algorithm is a set of finite, well-defined steps or instructions designed to solve a problem or perform a computation. It can also be defined as a procedure for solving a mathematical or computational problem in a finite number of steps, often involving repetitive or recursive operations.

Need for Algorithms:

- Solve complex problems efficiently and effectively.
- Automate processes, making them reliable, faster, and easier.
- Enable computers to perform tasks difficult or impossible for humans.
- Widely used in mathematics, computer science, engineering, finance, and data analysis.

## Use of the Algorithms

Algorithms are fundamental in solving problems efficiently across various fields:

- Computer Science: Basis of programming, from simple sorting and searching to AI and machine learning.
- Mathematics: Solve problems like linear equations, shortest paths, and optimization.
- Operations Research: Optimize logistics, transportation, and resource allocation.
- Artificial Intelligence: Power intelligent systems for tasks like image recognition, NLP, and decision-making.
- Data Science: Analyze and extract insights from large datasets in marketing, healthcare, finance, etc.

> Algorithms can be simple or complex, depending on the task. Think of it like following a recipe: step-by-step instructions lead to the desired outcome.

Algorithms can be simple or complex, depending on the task. Think of it like following a recipe: step-by-step instructions lead to the desired outcome.

## Properties of an Algorithm

An algorithm is a precise set of instructions to solve a problem. For a set of instructions to qualify as an algorithm, it must have the following properties:

Clear and Unambiguous:

- Each step should be precise and lead to only one interpretation.

Well-Defined Inputs:

- An algorithm may take zero or more inputs, which must be clearly specified.

Well-Defined Outputs:

- It must produce at least one output, clearly defined.

Finiteness:

- The algorithm must terminate after a finite number of steps.
- Infinite loops or recursion without base conditions violate this property.

Effectiveness:

- Steps should be simple, feasible, and executable with available resources.

Deterministic:

- For the same input, the algorithm should always produce the same output.

Language Independent:

- Algorithms are plain instructions and can be implemented in any programming language, producing the same result.

### How to express an Algorithm?

- Natural Language: Written in plain English. Easy to describe, but can be unclear for complex problems.
- Flowchart: Graphical representation of steps. Easier to visualize than natural language.
- Pseudocode: Text-based, code-like instructions without language syntax.Best way to express an algorithm.Understandable even to beginners with basic knowledge.

- Best way to express an algorithm.
- Understandable even to beginners with basic knowledge.

## Steps to Design an Algorithm

To design an algorithm, the following prerequisites must be considered:

1. Problem Definition: Clearly define the problem to be solved.
2. Constraints: Identify any limitations or rules.
3. Inputs: Determine what data will be provided.
4. Outputs: Specify the expected results.
5. Solution Feasibility: Ensure the solution works within the given constraints.

Example: Consider the example find the Largest of Three Numbers.

### Step 1: Fulfilling Prerequisites

- Problem: Find the largest of three numbers.
- Constraints: Only numeric inputs are allowed.
- Inputs: Three numbers (num1, num2, num3).
- Output: The largest number among the three.
- Solution: Compare the numbers using conditional statements to determine the largest.

### Step 2: Designing the algorithm

Now let's design the algorithm with the help of the above pre-requisites:

> START1. Read three numbers: num1, num2, num32. If num1 > num2 and num1 > num3, then largest = num1 Else if num2 > num3, then largest = num2 Else largest = num33. Print largestEND

START

1. Read three numbers: num1, num2, num3

2. If num1 > num2 and num1 > num3, then

largest = num1

Else if num2 > num3, then

largest = num2

Else

largest = num3

3. Print largest

END

### Step 3: Implementation

Program:

```
# include <iostream>
using namespace std;

int main() {
    int num1, num2, num3, largest;

    cout << "Enter three numbers: ";
    cin >> num1 >> num2 >> num3;

    if (num1 > num2 && num1 > num3)
        largest = num1;
    else if (num2 > num3)
        largest = num2;
    else
        largest = num3;

    cout << "Largest number: " << largest << endl;
    return 0;
}

```

```
import java.util.Scanner;

public class LargestNumber {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter three numbers: ");
        int num1 = sc.nextInt();
        int num2 = sc.nextInt();
        int num3 = sc.nextInt();
        int largest;

        if (num1 > num2 && num1 > num3)
            largest = num1;
        else if (num2 > num3)
            largest = num2;
        else
            largest = num3;

        System.out.println("Largest number: " + largest);
        sc.close();
    }
}

```

`# Example inputs
num1 = 10
num2 = 25
num3 = 15

if num1 > num2 and num1 > num3:
    largest = num1
elif num2 > num3:
    largest = num2
else:
    largest = num3

print("Largest number:", largest)
`

```
# Example inputs
num1 = 10
num2 = 25
num3 = 15

if num1 > num2 and num1 > num3:
    largest = num1
elif num2 > num3:
    largest = num2
else:
    largest = num3

print("Largest number:", largest)

```

Output

```
Largest number: 25
```

Time Complexity: O(1)

- The algorithm performs a fixed number of comparisons, regardless of the input values, so the execution time is constant.

Auxiliary Space: O(1)

- Only a fixed number of variables are used (num1, num2, num3, largest), so memory usage is constant.

`num1`

`num2`

`num3`

`largest`

Note:

- A problem can have multiple algorithmic solutions.
- For example, finding the largest of three numbers can be done using:Nested if-else comparisons (as shown)Python’s max() function (largest = max(num1, num2, num3))Ternary operators or conditional expressionsSorting the numbers and picking the last element

- Nested if-else comparisons (as shown)
- Python’s max() function (largest = max(num1, num2, num3))
- Ternary operators or conditional expressions
- Sorting the numbers and picking the last element

`if-else`

`max()`

`largest = max(num1, num2, num3)`

> The method chosen depends on readability, simplicity, or performance considerations.

The method chosen depends on readability, simplicity, or performance considerations.

## How to Analyze an Algorithm

To determine if an algorithm is efficient, its performance is analyzed in two ways:

1. Priori Analysis (Before Implementation):Evaluates the algorithm theoretically, without running it.Assumes factors like processor speed are constant.Provides an approximate measure of time and space complexity.
2. Posterior Analysis (After Implementation):Evaluates the algorithm practically, by executing it.Measures real performance: correctness, time taken, and memory used.Dependent on hardware and compiler.

- Evaluates the algorithm theoretically, without running it.
- Assumes factors like processor speed are constant.
- Provides an approximate measure of time and space complexity.

- Evaluates the algorithm practically, by executing it.
- Measures real performance: correctness, time taken, and memory used.
- Dependent on hardware and compiler.

> Read Also:Complete Data Structures & Algorithms Tutorial for topic-wise guide, practice problems and interview questions.

Read Also:Complete Data Structures & Algorithms Tutorial for topic-wise guide, practice problems and interview questions.