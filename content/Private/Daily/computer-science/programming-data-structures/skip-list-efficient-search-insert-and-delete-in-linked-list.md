---
title: "Skip List - Efficient Search, Insert and Delete in Linked List"
topic: "programming-data-structures"
scraped_date: 2026-03-29
---

# Skip List - Efficient Search, Insert and Delete in Linked List
A skip list is a data structure that allows for efficient search, insertion and deletion of elements in a sorted list. It is a probabilistic data structure, meaning that its average time complexity is determined through a probabilistic analysis.

In a skip list, elements are organized in layers, with each layer having a smaller number of elements than the one below it. The bottom layer is a regular linked list, while the layers above it contain "skipping" links that allow for fast navigation to elements that are far apart in the bottom layer. The idea behind this is to allow for quick traversal to the desired element, reducing the average number of steps needed to reach it.

Skip lists are implemented using a technique called "coin flipping." In this technique, a random number is generated for each insertion to determine the number of layers the new element will occupy. This means that, on average, each element will be in log(n) layers, where n is the number of elements in the bottom layer.

Skip lists have an average time complexity of O(log n) for search, insertion and deletion, which is similar to that of balanced trees, such as AVL trees and red-black trees, but with the advantage of simpler implementation and lower overhead.

In summary, skip lists provide a simple and efficient alternative to balanced trees for certain use cases, particularly when the average number of elements in the list is large.

Can we search in a sorted linked list better than O(n) time? The worst-case search time for a sorted linked list is O(n) as we can only linearly traverse the list and cannot skip nodes while searching. For a Balanced Binary Search Tree, we skip almost half of the nodes after one comparison with the root. For a sorted array, we have random access and we can apply Binary Search on arrays. Can we augment sorted linked lists to search faster? The answer is Skip List. The idea is simple, we create multiple layers so that we can skip some nodes. See the following example list with 16 nodes and two layers. The upper layer works as an "express lane" that connects only the main outer stations, and the lower layer works as a "normal lane" that connects every station. Suppose we want to search for 50, we start from the first node of the "express lane" and keep moving on the "express lane" till we find a node whose next is greater than 50. Once we find such a node (30 is the node in the following example) on "express lane", we move to "normal lane" using a pointer from this node, and linearly search for 50 on "normal lane". In the following example, we start from 30 on the "normal lane" and with linear search, we find 50. What is the time complexity with two layers? worst-case time complexity is several nodes on the "express lane" plus several nodes in a segment (A segment is several "normal lane" nodes between two "express lane" nodes) of the "normal lane". So if we have n nodes on "normal lane", ?n (square root of n) nodes on "express lane" and we equally divide the "normal lane", then there will be ?n nodes in every segment of "normal lane". ?n is an optimal division with two layers. With this arrangement, the number of nodes traversed for a search will be O(?n). Therefore, with O(?n) extra space, we can reduce the time complexity to O(?n).

![](images_skiplist1-1024x146.png)

Advantages of Skip List:

- The skip list is solid and trustworthy.
- To add a new node to it, it will be inserted extremely quickly.
- Easy to implement compared to the hash table and binary search tree
- The number of nodes in the skip list increases, and the possibility of the worst-case decreases
- Requires only ?(logn) time in the average case for all operations.
- Finding a node in the list is relatively straightforward.

Disadvantages of Skip List:

- It needs a greater amount of memory than the balanced tree.
- Reverse search is not permitted.
- Searching is slower than a linked list
- Skip lists are not cache-friendly because they don't optimize the locality of reference

Can we do better? The time complexity of skip lists can be reduced further by adding more layers. The time complexity of the search, the insert, and delete can become O(Logn) in an average cases with O(n) extra space. We will soon be publishing more posts on Skip Lists. References MIT Video Lecture on Skip Lists https://en.wikipedia.org/wiki/Skip_list

### Some related subtopics with details:

1. Coin flipping technique: The coin flipping technique is used to randomly determine the number of layers an element will occupy in a skip list. When a new element is inserted, a random number is generated and compared to a predetermined threshold. If the random number is less than the threshold, the element is inserted into the next layer. This process is repeated until the random number is greater than the threshold, at which point the element is inserted into the bottom layer. The coin flipping technique is what gives skip lists their probabilistic nature and allows for their efficient average time complexity.
2. Search operation: The search operation in a skip list involves traversing the layers from the top to bottom, skipping over elements that are not of interest, until the desired element is found or it is determined that it does not exist in the list. The skipping links in each layer allow for quick navigation to the desired element, reducing the average number of steps needed to reach it. The average time complexity of search in a skip list is O(log n), where n is the number of elements in the bottom layer.
3. Insertion operation: The insertion operation in a skip list involves generating a random number to determine the number of layers the new element will occupy, as described in the coin flipping technique, and then inserting the element into the appropriate layers. The insertion operation preserves the sorted order of the elements in the list. The average time complexity of insertion in a skip list is O(log n), where n is the number of elements in the bottom layer.
4. Deletion operation: The deletion operation in a skip list involves finding the element to be deleted and then removing it from all layers in which it appears. The deletion operation preserves the sorted order of the elements in the list. The average time complexity of deletion in a skip list is O(log n), where n is the number of elements in the bottom layer.
5. Complexity analysis: The average time complexity of search, insertion, and deletion in a skip list is O(log n), where n is the number of elements in the bottom layer. This is due to the use of the coin flipping technique, which allows for quick navigation to the desired element, and the probabilistic nature of skip lists, which ensures that the average number of steps needed to reach an element is logarithmic in the number of elements in the bottom layer. However, the worst-case time complexity of these operations can be O(n), which occurs in the rare case where all elements are inserted into only the bottom layer.