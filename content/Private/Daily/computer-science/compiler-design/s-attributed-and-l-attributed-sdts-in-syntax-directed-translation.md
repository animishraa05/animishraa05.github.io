---
title: "S - Attributed and L - Attributed SDTs in Syntax Directed Translation"
topic: "compiler-design"
scraped_date: [[2026-03-29]]
---

# S - Attributed and L - Attributed SDTs in Syntax Directed Translation
In Syntax-Directed Translation (SDT), semantic actions are attached to grammar productions to pass semantic information (attributes) between nodes of the parse tree during parsing.These actions perform tasks such as type checking, intermediate code generation, symbol table management, and other semantic processing.Based on the way attributes are evaluated and passed in the parse tree, SDTs are classified into S-Attributed SDT and L-Attributed SDT.

### Importance of SDTs

- Clearly defines how attributes are evaluated in a compiler.
- Helps build efficient and well-structured compilers.
- Controls attribute flow to ensure correct semantic analysis during parsing.

## S-attributed SDT

An S-attributed SDT (Synthesized Attributed SDT) is one of the Syntax-Directed Translation schemes in which all attributes are synthesized.Typically, these values are generated at the leaf nodes and then propagated upward to the root of the parse tree during evaluation.

### Key Features:

- Bottom-Up Evaluation: Synthesized attributes are evaluated using a bottom-up approach in the parse tree.
- Suitable for Bottom-Up Parsing: S-attributed SDTs work well with bottom-up parsing methods such as shift-reduce parsers.
- Simple and Efficient: Since all attributes are synthesized and no inherited attributes are used, the implementation becomes simpler and more efficient.

### Example:

Let us consider a production role such that.

```
E → E1 + T
```

Hence, the synthesized attribute E.val can be calculated as:

```
E.val = E1.val + T.val
```

## L-attributed SDT

An L-Attributed SDT (Left-Attributed SDT) allows both synthesized attributes and inherited attributes. Inherited attributes obtain their values from the parent or left sibling nodes, while synthesized attributes are computed from the child nodes, similar to S-attributed SDTs. Inherited attributes can only depend on the parent and symbols to the left of the current symbol in a production rule.

### Key Features:

- Top-Down Evaluation: Inherited attributes are evaluated top-down, while synthesized attributes are evaluated bottom-up.
- Suitable for Top-Down Parsing: Commonly used with top-down parsing methods such as recursive descent parsing.
- Supports Complex Dependencies: Since it allows both inherited and synthesized attributes, it can represent more complex semantic rules.

### Example:

Consider a production rule.

```
S → A B
```

Now, the inherited attribute A.inh can be calculated as.

```
A.inh = f(S.inh)
```

likewise, B can also have synthesized attributes based on A :

```
B.synth = g(A.synth)
```