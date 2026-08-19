---
title: "Operator Grammar and Precedence Parser"
topic: "theory-of-computation"
scraped_date: [[2026-03-29]]
---

# Operator Grammar and Precedence Parser
Operator grammars are used to represent expressions involving operators while following certain restrictions that allow clear precedence relations. Operator precedence parsing is a bottom-up parsing technique designed to work with such grammars. It determines parsing actions by comparing precedence relations between operators.

## Operator Grammar

A grammar used to define mathematical expressions with operators is called Operator Grammar (Operator Precedence Grammar).

For a grammar to be an Operator Grammar have such restrictions :

1. No ε (null) production on Right hand side.
2. No two adjacent non-terminals on Right hand side.

Examples - This is an example of operator grammar:

```
E->E+E/E*E/id 
```

However, the grammar given below is not an operator grammar because two non-terminals are adjacent to each other:

```
S->SAS/a
A->bSb/b 
```

We can convert it into an operator grammar, though:

```
S->SbSbS/SbS/a
A->bSb/b  
```

### Features:

- Operators with Precedence: An operator grammar includes operators with different levels of precedence and associativity. The grammar specifies the syntactic structure of expressions, which can be used to derive parse trees for expressions.
- Priority and Associativity: Provides a way to define the priority and associativity of operators, which is essential for parsing expressions correctly.
- Easy to Read: Simple and clear grammar for expressions., making it a popular choice for designing the syntax of programming languages.
- Ambiguity Resolution: Helps to reduce ambiguity in expressions by specifying the order in which operators are applied.

## Operator Precedence Parser

Bottom-up parser used to parse operator grammars. It determines the order of operations in expressions using precedence relations between operators. Ambiguous grammars are not allowed in any parser except operator precedence parser.

Methods to Determine Precedence:

1. Use the normal precedence and associativity rules of operators.
2. Create an unambiguous grammar that correctly represents operator precedence and associativity.

### Precedence Relations

Operator precedence parsing uses three relations:

- a ⋖ b → a yields precedence to b
- a ⋗ b → a takes precedence over b
- a ≐ b → a and b have the same precedence

|  | id | + | * | $ |
| --- | --- | --- | --- | --- |
| id |  | ⋗ | ⋗ | ⋗ |
| + | ⋖ | ⋗ | ⋖ | ⋗ |
| * | ⋖ | ⋗ | ⋗ | ⋗ |
| $ | ⋖ | ⋖ | ⋖ |  |

Example - Consider the following grammar:

```
 E -> E + E/E * E/( E )/id   
```

This is the directed graph representing the precedence function: Since there is no cycle in the graph, we can make this function table:

![](Daily/computer-science/theory-of-computation/images/2323.png)

![](Daily/computer-science/theory-of-computation/images/table2-5.png)

```
f(id) → g(*) → f(+) → g(+) → f($)
g(id) → f(*) → g(*) → f(+) → g(+) → f($)
```

Size of the table is 2n.

```
//check whether the given grammar is an Operator Grammar or not.
# include<stdlib.h>  
# include<stdio.h>
# include<string.h>

// function f to exit from the loop
// if given condition is not true
void f()
{
    printf("Not operator grammar");
    exit(0);
}

void main()
{
    char grm[20][20], c;

    // Here using flag variable,
    // considering grammar is not operator grammar
    int i, n, j = 2, flag = 0;

    // taking number of productions from user
    scanf("%d", &n);
    for (i = 0; i < n; i++)
        scanf("%s", grm[i]);

    for (i = 0; i < n; i++) {
        c = grm[i][2];

        while (c != '&#092;&#048;') {

            if (grm[i][3] == '+' || grm[i][3] == '-'
                || grm[i][3] == '*' || grm[i][3] == '/')

                flag = 1;

            else {

                flag = 0;
                f();
            }

            if (c == '$') {
                flag = 0;
                f();
            }

            c = grm[i][++j];
        }
    }

    if (flag == 1)
        printf("Operator grammar");
}

```

```
Input :3
A=A*A
B=AA
A=$

Output : Not operator grammar

Input :2
A=A/A
B=A+A

Output : Operator grammar
```

$ is a null production here which are also not allowed in operator grammars.

### Strengths

- Simple Structure – Parser design is simple and can be built manually.
- Efficient Parsing – Parses expressions quickly without backtracking. Parsing is usually linear time O(n) for operator grammars.
- Error Recovery – Can detect errors and skip invalid parts to continue parsing.
- Flexible – Can be extended to support new operators or precedence levels.

### Limitations

- Operators such as the minus sign (−) are difficult to handle because they may behave as both unary and binary operators.
- The method applies only to a limited class of grammars, mainly operator grammars.