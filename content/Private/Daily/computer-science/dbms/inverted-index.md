---
title: "Inverted Index"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Inverted Index
An Inverted Index is a data structure used in information retrieval systems to efficiently retrieve documents or web pages containing a specific term or set of terms. In an inverted index, the [[index]] is organized by terms (words), and each term points to a list of documents or web pages that contain that term.

> Note: Inverted indexes are widely used in search engines, database systems, and other applications where efficient text search is required.

Note: Inverted indexes are widely used in search engines, database systems, and other applications where efficient text search is required.

An inverted index is an [[index]] data structure storing a mapping from content, such as words or numbers, to its locations in a document or a set of documents. In simple words, it is a hashmap-like data structure that directs you from a word to a document or a web page. They are especially useful for large collections of documents, where searching through all the documents would be prohibitively slow.

### Example: Consider the following documents.

To create an inverted index for these documents, we first tokenize the documents into terms, as follows.

Document 1: The quick brown fox jumped over the lazy dog.Document 2: The lazy dog slept in the sun.

Next, we create an [[index]] of the terms, where each term points to a list of documents that contain that term, as follows.

> The -> Document 1, Document 2 Quick -> Document 1 Brown -> Document 1 Fox -> Document 1 Jumped -> Document 1 Over -> Document 1 Lazy -> Document 1, Document 2 Dog -> Document 1, Document 2 Slept -> Document 2 In -> Document 2 Sun -> Document 2

The -> Document 1, Document 2 Quick -> Document 1 Brown -> Document 1 Fox -> Document 1 Jumped -> Document 1 Over -> Document 1 Lazy -> Document 1, Document 2 Dog -> Document 1, Document 2 Slept -> Document 2 In -> Document 2 Sun -> Document 2

To search for documents containing a particular term or set of terms, the search engine queries the inverted index for those terms and retrieves the list of documents associated with each term. The search engine can then use this information to rank the documents based on relevance to the query and present them to the user in order of importance.

There are two types of inverted indexes:

- Record-Level Inverted Index: Record Level Inverted Index contains a list of references to documents for each word.
- Word-Level Inverted Index: Word Level Inverted Index additionally contains the positions of each word within a document. The latter form offers more functionality but needs more processing power and space to be created.

Suppose we want to search the texts "hello everyone, " "this article is based on an inverted index, " and "which is hashmap-like data structure". If we [[index]] by (text, word within the text), the [[index]] with a location in the text is:

> hello (1, 1) everyone (1, 2) this (2, 1) article (2, 2) is (2, 3); (3, 2) based (2, 4) on (2, 5) inverted (2, 6) [[index]] (2, 7) which (3, 1) hashmap (3, 3) like (3, 4) data (3, 5) structure (3, 6)

hello (1, 1) everyone (1, 2) this (2, 1) article (2, 2) is (2, 3); (3, 2) based (2, 4) on (2, 5) inverted (2, 6) [[index]] (2, 7) which (3, 1) hashmap (3, 3) like (3, 4) data (3, 5) structure (3, 6)

The word "hello" is in document 1 ("hello everyone") starting at word 1, so has an entry (1, 1), and the word "is" is in documents 2 and 3 at '3rd' and '2nd' positions respectively (here position is based on the word).

> Note: The [[index]] may have weights, frequencies, or other indicators.

Note: The [[index]] may have weights, frequencies, or other indicators.

## Steps to Build an Inverted Index

- Fetch the Document: Removing of Stop Words: Stop words are the most occurring and useless words in documents like "I", "the", "we", "is", and "an".
- Stemming of Root Word: Whenever I want to search for "cat", I want to see a document that has information about it. But the word present in the document is called "cats" or "catty" instead of "cat". To relate both words, I'll chop some part of every word I read so that I could get the "root word". There are standard tools for performing this like "Porter's Stemmer".
- Record Document IDs: If the word is already present add a reference of the document to [[index]] else creates a new entry. Add additional information like the frequency of the word, location of the word, etc.

Example:

> Words Document ant doc1 demo doc2 world doc1, doc2

Words Document ant doc1 demo doc2 world doc1, doc2

## Implementing Inverted Index

```
# Define the documents
document1 = "The quick brown fox jumped over the lazy dog."
document2 = "The lazy dog slept in the sun."

# Step 1: Tokenize the documents
# Convert each document to lowercase and split it into words
tokens1 = document1.lower().split()
tokens2 = document2.lower().split()

# Combine the tokens into a list of unique terms
terms = list(set(tokens1 + tokens2))

# Step 2: Build the inverted index
# Create an empty dictionary to store the inverted index
inverted_index = {}

# For each term, find the documents that contain it
for term in terms:
    documents = []
    if term in tokens1:
        documents.append("Document 1")
    if term in tokens2:
        documents.append("Document 2")
    inverted_index[term] = documents

# Step 3: Print the inverted index
for term, documents in inverted_index.items():
    print(term, "->", ", ".join(documents))

```

## Explanation of the Above Code

The first two lines define two sample documents to be used as input to the algorithm.

Step 1: Tokenize the input documents by converting them to lowercase and splitting them into individual words. Then combine the resulting tokens from both documents into a single list of unique terms.

Step 2: Create an empty dictionary to store the inverted index, and then iterate through each term in the list of unique terms. For each term, create an empty list of documents, and then check if the term appears in each input document.

> Note: If the term appears in a document, add the document to the list for that term. Finally, add an entry to the inverted index dictionary for the current term, with the list of documents that contain that term as its value.

Note: If the term appears in a document, add the document to the list for that term. Finally, add an entry to the inverted index dictionary for the current term, with the list of documents that contain that term as its value.

Step 3: Iterate through the entries in the inverted index dictionary and print out each term along with the list of documents that contain it.

```
jumped -> Document 1
fox -> Document 1
lazy -> Document 1, Document 2
the -> Document 1, Document 2
in -> Document 2
dog. -> Document 1
quick -> Document 1
dog -> Document 2
slept -> Document 2
sun. -> Document 2
brown -> Document 1
over -> Document 1
```

## Advantages of Inverted Index

- The inverted index is to allow fast full-text searches, at a cost of increased processing when a document is added to the database.
- It is easy to develop.
- It is the most popular data structure used in document retrieval systems, used on a large scale for example in search engines.

## Disadvantages of Inverted Index

- Large storage overhead and high maintenance costs on updating, deleting, and inserting.
- Instead of retrieving the data in decreasing order of expected usefulness, the records are retrieved in the order in which they occur in the inverted lists.

## Features of Inverted Indexes

- Efficient search: Inverted indexes allow for efficient searching of large volumes of text-based data. By indexing every term in every document, the [[index]] can quickly identify all documents that contain a given search term or phrase, significantly reducing search time.
- Fast updates: Inverted indexes can be updated quickly and efficiently as new content is added to the system. This allows for near-real-time indexing and searching for new content.
- Flexibility: Inverted indexes can be customized to suit the needs of different types of information retrieval systems. For example, they can be configured to handle different types of queries, such as Boolean queries or proximity queries.
- Compression: Inverted indexes can be compressed to reduce storage requirements. Various techniques such as delta encoding, gamma encoding, variable byte encoding, etc. can be used to compress the posting list efficiently.
- Support for stemming and synonym expansion: Inverted indexes can be configured to support stemming and synonym expansion, which can improve the accuracy and relevance of search results. Stemming is the process of reducing words to their base or root form, while synonym expansion involves mapping different words that have similar meanings to a common term.
- Support for multiple languages: Inverted indexes can support multiple languages, allowing users to search for content in different languages using the same system.

> Read related article - Difference b/w Inverted and Forward [[index|Index]]

Read related article - Difference b/w Inverted and Forward [[index|Index]]