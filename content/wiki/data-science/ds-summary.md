---
source: Data Science Book Summary
source_path: sources/ds.md
content_hash: 3bb8173ada3f2daf61aae9016d31eb3bfc72a2b7c1b9f5d0084af5833ac97ca2
ingested: 2026-04-30
concepts_count: 16
tags: [ml, data-science]
---

## What was extracted

**16 concept pages created in `wiki/ds/`:**

1. [[data-science|Data Science]] — interdisciplinary field combining stats, programming, domain expertise
2. [[data-wrangling|Data Wrangling]] — cleaning, structuring, enriching raw data
3. [[data-cleaning|Data Cleaning]] — fixing errors, missing values, duplicates
4. [[data-transformation|Data Transformation]] — reshaping, scaling, encoding data
5. [[exploratory-data-analysis|Exploratory Data Analysis]] — iterative exploration and hypothesis generation
6. [[data-visualization|Data Visualization]] — graphical representation of data patterns
7. [[feature-engineering|Feature Engineering]] — creating model-ready input variables
8. [[data-modeling|Data Modeling]] — selecting, training, evaluating ML algorithms
9. [[supervised-learning|Supervised Learning]] — learning X→y mapping from labeled data
10. [[unsupervised-learning|Unsupervised Learning]] — discovering patterns in unlabeled data
11. [[train-test-split|Train-Test Split]] — separating data for training and evaluation
12. [[overfitting|Overfitting]] — model memorizes noise, fails on new data
13. [[underfitting|Underfitting]] — model too simple to capture patterns
14. [[cross-validation|Cross-Validation]] — robust k-fold performance estimation
15. [[regression|Regression]] — predicting continuous numeric outputs
16. [[classification|Classification]] — predicting categorical labels

## Key Takeaways

- Data science is end-to-end: collection → wrangling → EDA → modeling → deployment
- Wrangling is 60-80% of the work — cleaning, structuring, enriching data
- EDA is hypothesis-generating, not hypothesis-testing — visual-first exploration
- Feature engineering often matters more than algorithm choice
- Supervised (labeled) vs Unsupervised (unlabeled) learning are the two main paradigms
- Train-test split and cross-validation are essential for detecting overfitting
- Overfitting (too complex) and underfitting (too simple) are symmetric failure modes
- Regression (continuous) and classification (categorical) are the two main supervised tasks

## Novelty

This source introduces the **Data Science (ml)** domain to the wiki:
- First coverage of the full data science pipeline (wrangling → modeling)
- Establishes ML fundamentals: supervised/unsupervised, regression/classification
- Introduces evaluation concepts: train-test split, cross-validation, over/under-fitting
- All concepts include DOT diagrams and 4+ bidirectional connections

## Open Questions

- What specific algorithms are covered under "modeling" (linear models, trees, neural nets)?
- How does the source define "data wrangling" vs "data cleaning" boundaries?
- What visualization libraries or tools are recommended?
- How is feature engineering different from data transformation in this source?

## Connections

- [[data-science|Data Science]] — overarching domain introduced
- [[data-wrangling|Data Wrangling]] — pipeline step 1
- [[data-modeling|Data Modeling]] — pipeline step 4
- [[supervised-learning|Supervised Learning]] — ML paradigm covered
- [[overfitting|Overfitting]] — evaluation concept covered
- [[cross-validation|Cross-Validation]] — robust evaluation technique
- [[feature-engineering|Feature Engineering]] — model input preparation
- [[regression|Regression]] — supervised task type
