---
title: "Web Information Retrieval | Vector Space Model"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Web Information Retrieval | Vector Space Model
Web Information Retrieval (WIR) refers to the process of finding and extracting relevant information from the vast content available on the World Wide Web in response to a user's query. It combines principles from information retrieval, machine learning, and natural language processing to help users quickly locate useful documents, websites, or data.

The goal of WIR is to rank and retrieve the most relevant results based on user intent, considering factors like keyword matching, link structure, content relevance, and user behaviour.

### Preprocessing in WIR

Steps involve in preprocessing WIR are:

1. Tokenization: Split text into words/tokens.
2. Stop-word Removal: Eliminate common words like “the,” “is,” etc.
3. Stemming/Lemmatization: Reduce words to base/root form.
4. Term-Document Matrix Construction: Rows = terms, Columns = documents, Values = TF-IDF scores.

A query is treated similarly and matched against the documents using cosine similarity.

## Vector Space Model in Information Retrieval

In the realm of Web Information Retrieval (WIR), search engines typically return a ranked list of documents in response to a user query. One foundational approach to achieve this is the Vector Space Model (VSM), where both documents and queries are represented as vectors in a high-dimensional space. Each dimension corresponds to a unique term from the entire document collection.

### Document and Query Representation

In the VSM:

- Each document/query becomes an N-dimensional vector, where N is the number of unique terms in the corpus.
- Each component of the vector represents the importance (weight) of a specific term in that document or query.

### TF-IDF Scoring

The weight of each term in a document is typically computed using the TF-IDF (Term Frequency-Inverse Document Frequency) formula:

Term Frequency (TF): Measures how often a term appears in a document:

tf_{i,j} = \frac{n_{i,j}}{\sum_k n_{k,j}}

Most vectors are sparse (many zeros), so efficient storage using sparse matrix representations is common.

### Measuring Relevance: Cosine Similarity

To compute the similarity between a query vector and a document vector, the cosine similarity is used:

\cos(a, b) = \frac{\sum_{i=1}^{n} a_i b_i}{\sqrt{\sum_{i=1}^{n} a_i^2} \cdot \sqrt{\sum_{i=1}^{n} b_i^2}}

- Values range from 0 to 1.
- A value close to 1 indicates high similarity.
- This method compares the angle between two vectors, not their magnitude.

Normalized vectors allow cosine similarity to behave similarly to Euclidean distance.

### Pivoted Normalization

A known issue in VSM is favoring shorter documents, as normalization can give undue weight to focused, short texts.

Pivoted document length normalization adjusts for this by:

- Penalizing short documents
- Boosting longer documents that cover more topics

This improves fairness in ranking diverse document lengths.

### Limitations of VSM

- Bag-of-Words Model: Ignores word order and syntax.
- No Semantic Understanding: Synonyms or semantically related terms are not recognized (e.g., “car” vs “automobile”).
- Term Sparsity: Many terms occur in only a few documents.

### Enhancements to VSM

To address VSM limitations, the Generalized Vector Space Model (GVSM) was introduced:

- Captures semantic similarity between terms using term correlations or external knowledge bases (e.g., WordNet).
- Improves retrieval accuracy when synonyms or related concepts are involved.[[quine-mccluskey-method]]

### Advantages of WIR and VSM

- Simple and Effective: Easy to implement and scale.
- Fast Results: Real-time retrieval is feasible with vectorized models.
- Customizable: Filters, rankings, and advanced options enhance results.
- Handles Large Volumes: Suitable for web-scale document collections.