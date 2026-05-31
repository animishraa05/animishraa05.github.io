---
source: Decision Tree in Machine Learning
source_path: sources/dtree.md
content_hash: pending
ingested: 2026-05-06
concepts_count: 18
---

## What This Source Is

A GeeksforGeeks article providing a comprehensive introduction to Decision Trees in Machine Learning. It covers the tree structure (root, internal, leaf nodes), how trees make predictions, the two primary attribute selection measures (Information Gain and Gini Index), and walks through concrete examples including a customer purchase prediction scenario and a worked calculation with a 3-feature dataset.

## Concepts Extracted

**Created:**

- [[decision-tree-structure|Decision Tree Structure]] — overall tree anatomy: root, internal nodes, branches, leaves
- [[root-node|Root Node]] — the first and most impactful split point
- [[internal-node|Internal Node]] — intermediate attribute tests that guide data flow
- [[leaf-node|Leaf Node]] — terminal nodes holding final predictions
- [[decision-tree-splitting|Decision Tree Splitting]] — how nodes partition data into child subsets
- [[entropy|Entropy]] — measure of uncertainty/impurity in a dataset
- [[entropy-calculation|Entropy Calculation]] — step-by-step entropy computation with worked example
- [[information-gain|Information Gain]] — reduction in uncertainty from a split
- [[information-gain-calculation|Information Gain Calculation]] — IG formula with worked 3-feature example
- [[gini-index|Gini Index]] — impurity measure based on squared class probabilities
- [[gini-index-properties|Gini Index Properties]] — six specific characteristics of the Gini measure
- [[attribute-selection-measures|Attribute Selection Measures]] — framework for evaluating candidate splits
- [[recursive-tree-building|Recursive Tree Building]] — top-down algorithm for constructing the tree
- [[node-purity|Node Purity]] — how homogeneous a subset is with respect to class labels
- [[decision-tree-prediction|Decision Tree Prediction]] — traversing root-to-leaf to classify new instances
- [[decision-tree-stopping-conditions|Decision Tree Stopping Conditions]] — when to stop growing the tree
- [[decision-tree-interpretability|Decision Tree Interpretability]] — why trees are inherently explainable
- [[decision-tree-preprocessing|Decision Tree Preprocessing]] — why trees need minimal data preparation
- [[decision-tree-flexibility|Decision Tree Flexibility]] — how trees handle both classification and regression
- [[id3-algorithm|ID3 Algorithm]] — the foundational decision tree construction algorithm

**Synthesis created:**

- [[entropy-vs-gini|Entropy vs Gini — Impurity Measures Compared]] — comparison of both impurity measures across formula, cost, sensitivity, and use cases

**Updated:**

- [[supervised-learning|Supervised Learning]] — added decision trees as a key model family with dtree source reference
- [[classification|Classification]] — added decision trees as a classifier option with dtree source reference
- [[regression|Regression]] — added decision trees as a regressor option with dtree source reference

## Key Takeaways

- Decision trees work like flowcharts: root → internal nodes (attribute tests) → branches (outcomes) → leaves (predictions)
- Information Gain = Entropy(parent) - weighted average of Entropy(children); chooses the split that reduces uncertainty most
- Gini Index = 1 - Σpᵢ²; measures probability of misclassifying a random element; faster to compute than entropy
- Three stopping conditions: pure class (leaf with that class), no attributes (leaf with majority vote), no instances (leaf with parent's majority vote)
- Trees are interpretable because every prediction is a traceable if-then rule path
- Trees require minimal preprocessing — no scaling, no encoding, handles mixed types natively
- The worked example with features X, Y, Z showed that splitting on Y produced perfectly pure children, so no further splits were needed
- In practice, entropy and Gini produce nearly identical trees; the choice is mostly about computational speed

## Open Questions

- How does the tree handle continuous attributes with many unique values (threshold selection strategy)?
- What happens when multiple attributes tie for maximum Information Gain?
- How do ensemble methods (Random Forest, Gradient Boosting) address the limitations of single decision trees?
- What is the computational complexity of building a decision tree on n samples with d features?
