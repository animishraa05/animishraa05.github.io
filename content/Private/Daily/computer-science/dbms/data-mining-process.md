---
title: "Data Mining Process"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Data Mining Process
Data mining is the process of extracting useful and previously unknown patterns from large datasets. It combines methods from artificial intelligence, machine learning, statistics, and database systems to discover hidden insights that can support better decision making. Although the term suggests just extracting data, the real focus is on uncovering valuable knowledge making "knowledge mining" a more accurate name.

The main goal is to transform raw data into meaningful and understandable information that can be used by organizations to gain insights, improve strategies, and make informed decisions.

### Data Mining and Business Intelligence: Key properties of Data Mining:

![](images_auto2.png)

- Automatic discovery of patterns
- Prediction of likely outcomes
- Creation of actionable information
- Focus on large datasets and databases

## Data Mining: Confluence of Multiple DisciplinesData Mining Process

![](images_auto2.png)

Data Mining is a process of discovering various models, summaries, and derived values from a given collection of data.

![Data_mining_workflow](images_data_mining_workflow.webp)

Let's discuss each layer of data procesing in detail:

### 1. State the problem

In this step, the modeler defines key variables and forms initial hypotheses about their relationships. It requires close collaboration between domain experts and data mining professionals. This teamwork starts early and continues throughout the entire data mining process to ensure meaningful results.

### 2. Collect the data

This step focuses on how data is collected. There are two main approaches

- Designed Experiment: The modeler controls data generation.
- Observational Approach: Data is collected passively without control (most common in data mining).

It's important to understand how data was collected, as this affects its distribution and the accuracy of the model. Also, the data used for training and testing must come from the same distribution-otherwise, the model may not work well in real-world applications.

### 3. Perform Preprocessing

In the observational setting, data is usually "collected" from prevailing databases, data warehouses, and [[data-marts|data marts]]. Data preprocessing usually includes a minimum of two common tasks :

(i) Outlier Detection: Outliers are unusual data values that are not according to most observations. There are two strategies for handling outliers:

- Detect and eventually remove outliers as a neighbourhood of preprocessing phase.
- Develop robust modeling methods that are insensitive to outliers.

(ii) Scaling, encoding, and selecting features: Data preprocessing involves steps like scaling and encoding variables. For example, if one feature ranges from 0–1 and another from 100–1000, they can unfairly influence results. Scaling adjusts them to the same range so all features contribute equally. Encoding methods also help reduce data size by transforming features into a smaller set of meaningful variables for better modeling.

### 4. Estimate/Build the Model

Apply and [[test]] different data mining techniques. It often requires trying multiple models and comparing results to choose the best fit.

### 5. Interpret model and draw conclusions

The final model should support decision-making and be interpretable. Simpler models are easier to explain but may lack accuracy, while complex models need special methods for interpretation.

Classification of Data Mining Systems :

- Database Technology
- Statistics
- Machine Learning
- Information Science
- Visualization

## Major issues in Data Mining

- Different Knowledge Needs: Users may require different types of insights, so mining must support a wide range of tasks.
- Use of Background Knowledge: Prior knowledge helps guide discovery and express patterns at various abstraction levels.
- Query Languages for Mining: Data mining query languages should support flexible, ad-hoc tasks and integrate with data warehouses.
- Result Presentation & Visualization: Discovered patterns must be shown in easy-to-understand formats like charts or summaries.
- Handling Noisy/Incomplete Data: Cleaning methods are essential to deal with missing or incorrect data to maintain accuracy.
- Pattern Evaluation: Only patterns that are useful, novel, or non-obvious should be considered interesting.
- Efficiency & Scalability: Algorithms must handle large datasets efficiently without compromising performance.
- Parallel, Distributed, and Incremental Mining: For large or scattered data, mining should be parallelized or updated incrementally without reprocessing all data.

### Alternative names for Data Mining:

- Knowledge discovery (mining) in databases (KDD)
- Knowledge extraction
- Data/pattern analysis
- Data archaeology
- Data dredging
- Information harvesting
- Business intelligence