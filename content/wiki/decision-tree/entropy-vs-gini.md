---
title: Entropy vs Gini — Impurity Measures Compared
type: synthesis
tags: [ml, decision-trees]
created: 2026-05-06
updated: 2026-05-06
---

## What's Being Compared

Both Entropy (used in Information Gain) and Gini Index are impurity measures used to decide which attribute to split on at each node of a decision tree. They share the same goal — find the split that creates the purest child nodes — but achieve it through different mathematical formulations. Understanding the difference helps practitioners choose the right criterion for their specific problem and computational constraints.

## The Core Tension

**Information-theoretic rigor vs computational efficiency.** Entropy is grounded in information theory and measures uncertainty in bits, providing a theoretically sound framework. Gini Index uses simple squared probabilities, trading theoretical elegance for speed. In practice, both produce nearly identical trees on most datasets.

## Comparison

| Dimension | [[entropy|Entropy (Information Gain)]] | [[gini-index|Gini Index]] |
|-----------|--------------------------------------|--------------------------|
| Formula | $H(S) = -\sum p_i \log_2(p_i)$ | $Gini = 1 - \sum p_i^2$ |
| Range (binary) | [0, 1] | [0, 0.5] |
| Computation cost | Higher (logarithm) | Lower (squaring) |
| Theoretical basis | Information theory (Shannon) | Probability of misclassification |
| Sensitivity | More sensitive to small probability changes | More sensitive to changes near extremes |
| Split bias | Favors many-valued attributes (ID bias) | Favors equally-sized splits |
| Default in sklearn | Not default | Default (`criterion="gini"`) |
| When to prefer | Theoretical interpretability matters | Performance on large datasets matters |

## When to Choose Entropy

- You need the information-theoretic interpretation (bits of information gained)
- You're building a teaching/explanatory model where the theoretical foundation matters
- Your dataset is small enough that the computational overhead is negligible
- You want to connect to concepts like mutual information, KL divergence, or cross-entropy

## When to Choose Gini

- You're working with large datasets where computation speed matters
- You want the sklearn default (battle-tested in production)
- You're building production models where marginal accuracy differences don't matter
- You prefer simpler mathematics (no logarithms, just squaring and summing)

## The Insight

The choice between entropy and Gini is rarely consequential — both measures are **monotonically correlated**, meaning they generally agree on which splits are good and which are bad. The real-world accuracy difference is typically less than 1%. The practical decision comes down to: (1) computational budget for training, and (2) whether you need the information-theoretic interpretability. This is why sklearn defaults to Gini — it's the "good enough and faster" option — but supports entropy for users who need it.

## Connections

- [[entropy|Entropy]] — left side of this comparison
- [[gini-index|Gini Index]] — right side of this comparison
- [[information-gain|Information Gain]] — entropy's application in decision trees
- [[attribute-selection-measures|Attribute Selection Measures]] — both are selection measures
- [[decision-tree-splitting|Decision Tree Splitting]] — both drive split decisions
- [[entropy-calculation|Entropy Calculation]] — detailed entropy computation
- [[gini-index-properties|Gini Index Properties]] — detailed Gini characteristics
