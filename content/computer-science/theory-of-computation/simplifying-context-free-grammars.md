---
title: "Simplifying Context Free Grammars"
topic: "theory-of-computation"
scraped_date: [[2026-03-29]]
---

# Simplifying Context Free Grammars
A Context-Free Grammar (CFG) is a formal grammar that consists of a set of production rules used to generate strings in a language. However, many grammars contain redundant rules, unreachable symbols, or unnecessary complexities. Simplifying a CFG helps in reducing its size while preserving the generated language, making parsing more efficient.

## Need for CFG simplification

- Efficient Parsing: Smaller grammars require fewer computations.
- Better Understanding: Removing redundant parts makes it easier to analyze.
- Optimization: Improved computational efficiency in compilers and language processing.

## Types of Redundant Productions and Their Removal

Types of redundant productions and the procedure of removing them are mentioned below:

### 1. Useless productions

The productions that can never take part in derivation of any string , are called useless productions. Similarly , a variable that can never take part in derivation of any string is called a useless variable. For eg.

> S -> abS | abA | abBA -> cdB -> aBC -> dc

S -> abS | abA | abBA -> cdB -> aBC -> dc

In the above example, production ‘C -> dc’ is useless because the variable ‘C’ will never occur in derivation of any string. The other productions are written in such a way that variable ‘C’ can never reached from the starting variable ‘S’. Production ‘B -> aB’ is also useless because there is no way it will ever terminate . If it never terminates , then it can never produce a string. Hence the production can never take part in any derivation. To remove useless productions , we first find all the variables which will never lead to a terminal string such as variable ‘B’. We then remove all the productions in which variable ‘B’ occurs. So the modified grammar becomes -

> S -> abS | abAA -> cdC -> dc

S -> abS | abAA -> cdC -> dc

We then try to identify all the variables that can never be reached from the starting variable such as variable ‘C’. We then remove all the productions in which variable ‘C’ occurs. The grammar below is now free of useless productions -

> S -> abS | abAA -> cd

S -> abS | abAA -> cd

### 2. Null (λ) productions

The productions of type ‘A -> ?’ are called ? productions ( also called lambda productions and null productions) . These productions can only be removed from those grammars that do not generate ? (an empty string). It is possible for a grammar to contain null productions and yet not produce an empty string. To remove null productions , we first have to find all the nullable variables. A variable ‘A’ is called nullable if ? can be derived from ‘A’. For all the productions of type ‘A -> ?’ , ‘A’ is a nullable variable. For all the productions of type ‘B -> A1A2...An ‘ , where all ’Ai’s are nullable variables , ‘B’ is also a nullable variable. After finding all the nullable variables, we can now start to construct the null production free grammar. For all the productions in the original grammar , we add the original production as well as all the combinations of the production that can be formed by replacing the nullable variables in the production by ?. If all the variables on the RHS of the production are nullable , then we do not add ‘A -> ?’ to the new grammar. An example will make the point clear. Consider the grammar -

> S -> ABCd (1)A -> BC (2)B -> bB | ? (3) C -> cC | ? (4)

S -> ABCd (1)A -> BC (2)B -> bB | ? (3) C -> cC | ? (4)

Lets first find all the nullable variables. Variables ‘B’ and ‘C’ are clearly nullable because they contain ‘?’ on the RHS of their production. Variable ‘A’ is also nullable because in (2) , both variables on the RHS are also nullable. So variables ‘A’ , ‘B’ and ‘C’ are nullable variables. Lets create the new grammar. We start with the first production. Add the first production as it is. Then we create all the possible combinations that can be formed by replacing the nullable variables with ?. Therefore line (1) now becomes ‘S -> ABCd | ABd | ACd | BCd | Ad | Bd |Cd | d ’.We apply the same rule to line (2) but we do not add ‘A -> ?’ even though it is a possible combination. We remove all the productions of type ‘V -> ?’. The new grammar now becomes -

> S -> ABCd | ABd | ACd | BCd | Ad | Bd |Cd | dA -> BC | B | CB -> bB | bC -> cC | c

S -> ABCd | ABd | ACd | BCd | Ad | Bd |Cd | dA -> BC | B | CB -> bB | bC -> cC | c

### 3. Unit productions

The productions of type ‘A -> B’ are called unit productions. To create a unit production free grammar ‘Guf’ from the original grammar ‘G’ , we follow the procedure mentioned below. First add all the non-unit productions of ‘G’ in ‘Guf’. Then for each variable ‘A’ in grammar ‘G’ , find all the variables ‘B’ such that ‘A *=> B’. Now , for all variables like ‘A ’ and ‘B’, add ‘A -> x1 | x2 | ...xn’ to ‘Guf’ where ‘B -> x1 | x2 | ...xn ‘ is in ‘Guf’ . None of the x1 , x2 … xn are single variables because we only added non-unit productions in ‘Guf’. Hence the resultant grammar is unit production free. For eg.

> S -> Aa | BA -> b | BB -> A | a

S -> Aa | BA -> b | BB -> A | a

Lets add all the non-unit productions of ‘G’ in ‘Guf’. ‘Guf’ now becomes -

> S -> AaA -> bB -> a

S -> AaA -> bB -> a

Now we find all the variables that satisfy ‘X *=> Z’. These are ‘S*=>B’, ‘A *=> B’ and ‘B *=> A’. For ‘A *=> B’ , we add ‘A -> a’ because ‘B ->a’ exists in ‘Guf’. ‘Guf’ now becomes

> S -> AaA -> b | aB -> a

S -> AaA -> b | aB -> a

For ‘B *=> A’ , we add ‘B -> b’ because ‘A -> b’ exists in ‘Guf’. The new grammar now becomes

> S -> AaA -> b | aB -> a | b

S -> AaA -> b | aB -> a | b

We follow the same step for ‘S*=>B’ and finally get the following grammar -

> S -> Aa | b | aA -> b | aB -> a | b

S -> Aa | b | aA -> b | aB -> a | b

Now remove B -> a|b , since it doesnt occur in the production 'S', then the following grammar becomes,

> S->Aa|b|aA->b|a

S->Aa|b|aA->b|a

Note: To remove all kinds of productions mentioned above, first remove the null productions, then the unit productions and finally , remove the useless productions. Following this order is very important to get the correct result.