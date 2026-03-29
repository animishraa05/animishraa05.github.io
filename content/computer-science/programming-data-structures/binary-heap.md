---
title: "Binary Heap"
topic: "programming-data-structures"
scraped_date: 2026-03-29
---

# Binary Heap
A Binary Heap is a special type of complete binary tree, meaning all levels are filled except possibly the last, which is filled from left to right.

- It allows fast access to the minimum or maximum element. There are two types of binary heaps: Min Heap and Max Heap.
- Min Heap: The value of the root node is the smallest, and this property is true for all subtrees.
- Max Heap: The value of the root node is the largest, and this rule also applies to all subtrees.
- Binary heaps are commonly used in priority queues and heap sort algorithms because of their efficient insertion and deletion operations.

### Valid and Invalid examples of heaps

### How is Binary Heap represented?

A Binary Heap is a Complete Binary Tree. A binary heap is typically represented as an array.

- The root element will be at arr[0].
- The below table shows indices of other nodes for the ith node, i.e., arr[i]:

| arr[(i-1)/2] | Returns the parent node |
| --- | --- |
| arr[(2*i)+1] | Returns the left child node |
| arr[(2*i)+2] | Returns the right child node |

The traversal method use to achieve Array representation is Level Order Traversal. Please refer to Array Representation Of Binary Heap for details.

![Representation-of-a-Binary-Heap](images/representation-of-a-binary-heap.webp)

### Operations on Heap

![redirect icon](images/redirect-icon.svg)

```
// A C++ program to demonstrate common Binary Heap Operations
# include <climits>
# include <iostream>
using namespace std;

// Prototype of a utility function to swap two integers
void swap(int *x, int *y);

// A class for Min Heap
class MinHeap
{
    int *harr;     // pointer to array of elements in heap
    int capacity;  // maximum possible size of min heap
    int heap_size; // Current number of elements in min heap
  public:
    // Constructor
    MinHeap(int capacity);

    // to heapify a subtree with the root at given index
    void MinHeapify(int i);

    int parent(int i)
    {
        return (i - 1) / 2;
    }

    // to get index of left child of node at index i
    int left(int i)
    {
        return (2 * i + 1);
    }

    // to get index of right child of node at index i
    int right(int i)
    {
        return (2 * i + 2);
    }

    // to extract the root which is the minimum element
    int extractMin();

    // Decreases key value of key at index i to new_val
    void decreaseKey(int i, int new_val);

    // Returns the minimum key (key at root) from min heap
    int getMin()
    {
        return harr[0];
    }

    // Deletes a key stored at index i
    void deleteKey(int i);

    // Inserts a new key 'k'
    void insertKey(int k);
};

// Constructor: Builds a heap from a given array a[] of given size
MinHeap::MinHeap(int cap)
{
    heap_size = 0;
    capacity = cap;
    harr = new int[cap];
}

// Inserts a new key 'k'
void MinHeap::insertKey(int k)
{
    if (heap_size == capacity)
    {
        cout << "\nOverflow: Could not insertKey\n";
        return;
    }

    // First insert the new key at the end
    heap_size++;
    int i = heap_size - 1;
    harr[i] = k;

    // Fix the min heap property if it is violated
    while (i != 0 && harr[parent(i)] > harr[i])
    {
        swap(&harr[i], &harr[parent(i)]);
        i = parent(i);
    }
}

// Decreases value of key at index 'i' to new_val.  It is assumed that
// new_val is smaller than harr[i].
void MinHeap::decreaseKey(int i, int new_val)
{
    harr[i] = new_val;
    while (i != 0 && harr[parent(i)] > harr[i])
    {
        swap(&harr[i], &harr[parent(i)]);
        i = parent(i);
    }
}

// Method to remove minimum element (or root) from min heap
int MinHeap::extractMin()
{
    if (heap_size <= 0)
        return INT_MAX;
    if (heap_size == 1)
    {
        heap_size--;
        return harr[0];
    }

    // Store the minimum value, and remove it from heap
    int root = harr[0];
    harr[0] = harr[heap_size - 1];
    heap_size--;
    MinHeapify(0);

    return root;
}

// This function deletes key at index i. It first reduced value to minus
// infinite, then calls extractMin()
void MinHeap::deleteKey(int i)
{
    decreaseKey(i, INT_MIN);
    extractMin();
}

// A recursive method to heapify a subtree with the root at given index
// This method assumes that the subtrees are already heapified
void MinHeap::MinHeapify(int i)
{
    int l = left(i);
    int r = right(i);
    int smallest = i;
    if (l < heap_size && harr[l] < harr[i])
        smallest = l;
    if (r < heap_size && harr[r] < harr[smallest])
        smallest = r;
    if (smallest != i)
    {
        swap(&harr[i], &harr[smallest]);
        MinHeapify(smallest);
    }
}

// A utility function to swap two elements
void swap(int *x, int *y)
{
    int temp = *x;
    *x = *y;
    *y = temp;
}

// Driver program to test above functions
int main()
{
    MinHeap h(11);
    h.insertKey(3);
    h.insertKey(2);
    h.deleteKey(1);
    h.insertKey(15);
    h.insertKey(5);
    h.insertKey(4);
    h.insertKey(45);
    cout << h.extractMin() << " ";
    cout << h.getMin() << " ";
    h.decreaseKey(2, 1);
    cout << h.getMin();
    return 0;
}

```

```
# include <limits.h>
# include <stdio.h>
# include <stdlib.h>

// Prototype of a utility function to swap two integers
void swap(int *x, int *y);

// A structure to represent a Min Heap
struct MinHeap
{
    int *harr;
    int capacity;
    int heap_size;
};

// Function prototypes
struct MinHeap *createMinHeap(int capacity);
void MinHeapify(struct MinHeap *h, int i);
int parent(int i)
{
    return (i - 1) / 2;
}
int left(int i)
{
    return (2 * i + 1);
}
int right(int i)
{
    return (2 * i + 2);
}

int extractMin(struct MinHeap *h);
void decreaseKey(struct MinHeap *h, int i, int new_val);
int getMin(struct MinHeap *h)
{
    return h->harr[0];
}
void deleteKey(struct MinHeap *h, int i);
void insertKey(struct MinHeap *h, int k);

// Constructor: Creates a heap of given capacity
struct MinHeap *createMinHeap(int capacity)
{
    struct MinHeap *h = (struct MinHeap *)malloc(sizeof(struct MinHeap));
    h->heap_size = 0;
    h->capacity = capacity;
    h->harr = (int *)malloc(capacity * sizeof(int));
    return h;
}

// Inserts a new key 'k'
void insertKey(struct MinHeap *h, int k)
{
    if (h->heap_size == h->capacity)
    {
        printf("\nOverflow: Could not insertKey\n");
        return;
    }

    // First insert the new key at the end
    h->heap_size++;
    int i = h->heap_size - 1;
    h->harr[i] = k;

    // Fix the min heap property if it is violated
    while (i != 0 && h->harr[parent(i)] > h->harr[i])
    {
        swap(&h->harr[i], &h->harr[parent(i)]);
        i = parent(i);
    }
}

// Decreases value of key at index 'i' to new_val.
void decreaseKey(struct MinHeap *h, int i, int new_val)
{
    h->harr[i] = new_val;
    while (i != 0 && h->harr[parent(i)] > h->harr[i])
    {
        swap(&h->harr[i], &h->harr[parent(i)]);
        i = parent(i);
    }
}

// Method to remove minimum element (or root) from min heap
int extractMin(struct MinHeap *h)
{
    if (h->heap_size <= 0)
        return INT_MAX;
    if (h->heap_size == 1)
    {
        h->heap_size--;
        return h->harr[0];
    }

    // Store the minimum value, and remove it from heap
    int root = h->harr[0];
    h->harr[0] = h->harr[h->heap_size - 1];
    h->heap_size--;
    MinHeapify(h, 0);

    return root;
}

// This function deletes key at index i.
void deleteKey(struct MinHeap *h, int i)
{
    decreaseKey(h, i, INT_MIN);
    extractMin(h);
}

// A recursive method to heapify a subtree with root at given index
void MinHeapify(struct MinHeap *h, int i)
{
    int l = left(i);
    int r = right(i);
    int smallest = i;

    if (l < h->heap_size && h->harr[l] < h->harr[i])
        smallest = l;
    if (r < h->heap_size && h->harr[r] < h->harr[smallest])
        smallest = r;
    if (smallest != i)
    {
        swap(&h->harr[i], &h->harr[smallest]);
        MinHeapify(h, smallest);
    }
}

// A utility function to swap two elements
void swap(int *x, int *y)
{
    int temp = *x;
    *x = *y;
    *y = temp;
}

// Driver program to test above functions
int main()
{
    struct MinHeap *h = createMinHeap(11);
    insertKey(h, 3);
    insertKey(h, 2);
    deleteKey(h, 1);
    insertKey(h, 15);
    insertKey(h, 5);
    insertKey(h, 4);
    insertKey(h, 45);
    printf("%d ", extractMin(h));
    printf("%d ", getMin(h));
    decreaseKey(h, 2, 1);
    printf("%d", getMin(h));

    // Free allocated memory
    free(h->harr);
    free(h);
    return 0;
}

```

```
// Java program for the above approach
import java.util.*;

// A class for Min Heap 
class MinHeap {
    
    // To store array of elements in heap
    private int[] heapArray;
    
    // max size of the heap
    private int capacity;
    
    // Current number of elements in the heap
    private int current_heap_size;

    // Constructor 
    public MinHeap(int n) {
        capacity = n;
        heapArray = new int[capacity];
        current_heap_size = 0;
    }
    
    // Swapping using reference 
    private void swap(int[] arr, int a, int b) {
        int temp = arr[a];
        arr[a] = arr[b];
        arr[b] = temp;
    }
    
    
    // Get the Parent index for the given index
    private int parent(int key) {
        return (key - 1) / 2;
    }
    
    // Get the Left Child index for the given index
    private int left(int key) {
        return 2 * key + 1;
    }
    
    // Get the Right Child index for the given index
    private int right(int key) {
        return 2 * key + 2;
    }
    
    
    // Inserts a new key
    public boolean insertKey(int key) {
        if (current_heap_size == capacity) {
            
            // heap is full
            return false;
        }
    
        // First insert the new key at the end 
        int i = current_heap_size;
        heapArray[i] = key;
        current_heap_size++;
        
        // Fix the min heap property if it is violated 
        while (i != 0 && heapArray[i] < heapArray[parent(i)]) {
            swap(heapArray, i, parent(i));
            i = parent(i);
        }
        return true;
    }
    
    // Decreases value of given key to new_val. 
    // It is assumed that new_val is smaller 
    // than heapArray[key]. 
    public void decreaseKey(int key, int new_val) {
        heapArray[key] = new_val;

        while (key != 0 && heapArray[key] < heapArray[parent(key)]) {
            swap(heapArray, key, parent(key));
            key = parent(key);
        }
    }
    
    // Returns the minimum key (key at
    // root) from min heap 
    public int getMin() {
        return heapArray[0];
    }
    
    
    // Method to remove minimum element 
    // (or root) from min heap 
    public int extractMin() {
        if (current_heap_size <= 0) {
            return Integer.MAX_VALUE;
        }

        if (current_heap_size == 1) {
            current_heap_size--;
            return heapArray[0];
        }
        
        // Store the minimum value, 
        // and remove it from heap 
        int root = heapArray[0];

        heapArray[0] = heapArray[current_heap_size - 1];
        current_heap_size--;
        MinHeapify(0);

        return root;
    }
        
    // This function deletes key at the 
    // given index. It first reduced value 
    // to minus infinite, then calls extractMin()
    public void deleteKey(int key) {
        decreaseKey(key, Integer.MIN_VALUE);
        extractMin();
    }
    
    // A recursive method to heapify a subtree 
    // with the root at given index 
    // This method assumes that the subtrees
    // are already heapified
    private void MinHeapify(int key) {
        int l = left(key);
        int r = right(key);

        int smallest = key;
        if (l < current_heap_size && heapArray[l] < heapArray[smallest]) {
            smallest = l;
        }
        if (r < current_heap_size && heapArray[r] < heapArray[smallest]) {
            smallest = r;
        }

        if (smallest != key) {
            swap(heapArray, key, smallest);
            MinHeapify(smallest);
        }
    }
    
    // Increases value of given key to new_val.
    // It is assumed that new_val is greater 
    // than heapArray[key]. 
    // Heapify from the given key
    public void increaseKey(int key, int new_val) {
        heapArray[key] = new_val;
        MinHeapify(key);
    }
    
    // Changes value on a key
    public void changeValueOnAKey(int key, int new_val) {
        if (heapArray[key] == new_val) {
            return;
        }
        if (heapArray[key] < new_val) {
            increaseKey(key, new_val);
        } else {
            decreaseKey(key, new_val);
        }
    }
}

// Driver Code
class MinHeapTest {
    public static void main(String[] args) {
        MinHeap h = new MinHeap(11);
        h.insertKey(3);
        h.insertKey(2);
        h.deleteKey(1);
        h.insertKey(15);
        h.insertKey(5);
        h.insertKey(4);
        h.insertKey(45);
        System.out.print(h.extractMin() + " ");
        System.out.print(h.getMin() + " ");
        
        h.decreaseKey(2, 1);
        System.out.print(h.getMin());
    }
}

// This code is contributed by rishabmalhdijo

```

```
# Enables Python 3 print function behavior in Python 2 environments
from __future__ import print_function
import math

class MinHeap:
    def __init__(self):
        # Initialize the heap as an empty list
        self.arr = []

    # Get the index of the left child
    def left(self, i): return 2 * i + 1

    # Get the index of the right child
    def right(self, i): return 2 * i + 2

    # Get the index of the parent
    def parent(self, i): return (i - 1) // 2
    
    # Return the minimum element without removing it
    def get_min(self):
        return self.arr[0] if self.arr else None
    
    # Insert a new key into the heap
    def insert(self, k):
        self.arr.append(k)
        i = len(self.arr) - 1
        
        # Fix the min heap property by bubbling up
        while i > 0 and self.arr[self.parent(i)] > self.arr[i]:
            p = self.parent(i)
            self.arr[i], self.arr[p] = self.arr[p], self.arr[i]
            i = p

    # Decrease the value of a key at a specific index
    def decrease_key(self, i, new_val):
        self.arr[i] = new_val
        
        # Percolate the new smaller value up to maintain heap property
        while i != 0 and self.arr[self.parent(i)] > self.arr[i]:
            p = self.parent(i)
            self.arr[i], self.arr[p] = self.arr[p], self.arr[i]
            i = p

    # Remove and return the root (minimum) element
    def extract_min(self):
        if len(self.arr) <= 0: return None
        if len(self.arr) == 1: return self.arr.pop()
        
        res = self.arr[0]
        # Replace root with the last element and heapify down
        self.arr[0] = self.arr.pop() 
        self.min_heapify(0)
        return res

    # Delete a key at index i by forcing it to root and extracting
    def delete_key(self, i):
      
        # Use negative infinity to ensure it becomes the new root
        self.decrease_key(i, -float('inf'))
        
        # Remove the forced root
        self.extract_min()

    # Recursive method to fix the heap property downwards
    def min_heapify(self, i):
        l, r, n = self.left(i), self.right(i), len(self.arr)
        smallest = i
        
        # Find the smallest among root, left child, and right child
        if l < n and self.arr[l] < self.arr[smallest]: smallest = l
        if r < n and self.arr[r] < self.arr[smallest]: smallest = r
          
        # If the root is not the smallest, swap and continue heapifying
        if smallest != i:
            self.arr[i], self.arr[smallest] = self.arr[smallest], self.arr[i]
            self.min_heapify(smallest)

# --- Execution ---
h = MinHeap()
h.insert(3)
h.insert(2)
h.delete_key(1)
h.insert(15)
h.insert(5)
h.insert(4)
h.insert(45)

# Prints values on the same line separated by spaces
print(h.extract_min(), end=" ") 
print(h.get_min(), end=" ") 

h.decrease_key(2, 1)
print(h.extract_min())

```

```
// C# program to demonstrate common 
// Binary Heap Operations - Min Heap
using System;

// A class for Min Heap 
class MinHeap{
    
// To store array of elements in heap
public int[] heapArray{ get; set; }

// max size of the heap
public int capacity{ get; set; }

// Current number of elements in the heap
public int current_heap_size{ get; set; }

// Constructor 
public MinHeap(int n)
{
    capacity = n;
    heapArray = new int[capacity];
    current_heap_size = 0;
}

// Swapping using reference 
public static void Swap<T>(ref T lhs, ref T rhs)
{
    T temp = lhs;
    lhs = rhs;
    rhs = temp;
}

// Get the Parent index for the given index
public int Parent(int key) 
{
    return (key - 1) / 2;
}

// Get the Left Child index for the given index
public int Left(int key)
{
    return 2 * key + 1;
}

// Get the Right Child index for the given index
public int Right(int key)
{
    return 2 * key + 2;
}

// Inserts a new key
public bool insertKey(int key)
{
    if (current_heap_size == capacity)
    {
        
        // heap is full
        return false;
    }

    // First insert the new key at the end 
    int i = current_heap_size;
    heapArray[i] = key;
    current_heap_size++;

    // Fix the min heap property if it is violated 
    while (i != 0 && heapArray[i] < 
                     heapArray[Parent(i)])
    {
        Swap(ref heapArray[i],
             ref heapArray[Parent(i)]);
        i = Parent(i);
    }
    return true;
}

// Decreases value of given key to new_val. 
// It is assumed that new_val is smaller 
// than heapArray[key]. 
public void decreaseKey(int key, int new_val)
{
    heapArray[key] = new_val;

    while (key != 0 && heapArray[key] < 
                       heapArray[Parent(key)])
    {
        Swap(ref heapArray[key], 
             ref heapArray[Parent(key)]);
        key = Parent(key);
    }
}

// Returns the minimum key (key at
// root) from min heap 
public int getMin()
{
    return heapArray[0];
}

// Method to remove minimum element 
// (or root) from min heap 
public int extractMin()
{
    if (current_heap_size <= 0)
    {
        return int.MaxValue;
    }

    if (current_heap_size == 1)
    {
        current_heap_size--;
        return heapArray[0];
    }

    // Store the minimum value, 
    // and remove it from heap 
    int root = heapArray[0];

    heapArray[0] = heapArray[current_heap_size - 1];
    current_heap_size--;
    MinHeapify(0);

    return root;
}

// This function deletes key at the 
// given index. It first reduced value 
// to minus infinite, then calls extractMin()
public void deleteKey(int key)
{
    decreaseKey(key, int.MinValue);
    extractMin();
}

// A recursive method to heapify a subtree 
// with the root at given index 
// This method assumes that the subtrees
// are already heapified
public void MinHeapify(int key)
{
    int l = Left(key);
    int r = Right(key);

    int smallest = key;
    if (l < current_heap_size && 
        heapArray[l] < heapArray[smallest])
    {
        smallest = l;
    }
    if (r < current_heap_size && 
        heapArray[r] < heapArray[smallest])
    {
        smallest = r;
    }
    
    if (smallest != key)
    {
        Swap(ref heapArray[key], 
             ref heapArray[smallest]);
        MinHeapify(smallest);
    }
}

// Increases value of given key to new_val.
// It is assumed that new_val is greater 
// than heapArray[key]. 
// Heapify from the given key
public void increaseKey(int key, int new_val)
{
    heapArray[key] = new_val;
    MinHeapify(key);
}

// Changes value on a key
public void changeValueOnAKey(int key, int new_val)
{
    if (heapArray[key] == new_val)
    {
        return;
    }
    if (heapArray[key] < new_val)
    {
        increaseKey(key, new_val);
    } else
    {
        decreaseKey(key, new_val);
    }
}
}

static class MinHeapTest{
    
// Driver code
public static void Main(string[] args)
{
    MinHeap h = new MinHeap(11);
    h.insertKey(3);
    h.insertKey(2);
    h.deleteKey(1);
    h.insertKey(15);
    h.insertKey(5);
    h.insertKey(4);
    h.insertKey(45);
    
    Console.Write(h.extractMin() + " ");
    Console.Write(h.getMin() + " ");
    
    h.decreaseKey(2, 1);
    Console.Write(h.getMin());
}
}

// This code is contributed by 
// Dinesh Clinton Albert(dineshclinton)

```

```
// A class for Min Heap
class MinHeap
{
    // Constructor: Builds a heap from a given array a[] of given size
    constructor()
    {
        this.arr = [];
    }

    left(i) {
        return 2*i + 1;
    }

    right(i) {
        return 2*i + 2;
    }

    parent(i){
        return Math.floor((i - 1)/2)
    }
    
    getMin()
    {
        return this.arr[0]
    }
    
    insert(k)
    {
        let arr = this.arr;
        arr.push(k);
    
        // Fix the min heap property if it is violated
        let i = arr.length - 1;
        while (i > 0 && arr[this.parent(i)] > arr[i])
        {
            let p = this.parent(i);
            [arr[i], arr[p]] = [arr[p], arr[i]];
            i = p;
        }
    }

    // Decreases value of key at index 'i' to new_val. 
    // It is assumed that new_val is smaller than arr[i].
    decreaseKey(i, new_val)
    {
        let arr = this.arr;
        arr[i] = new_val;
        
        while (i !== 0 && arr[this.parent(i)] > arr[i])
        {
           let p = this.parent(i);
           [arr[i], arr[p]] = [arr[p], arr[i]];
           i = p;
        }
    }

    // Method to remove minimum element (or root) from min heap
    extractMin()
    {
        let arr = this.arr;
        if (arr.length == 1) {
            return arr.pop();
        }
        
        // Store the minimum value, and remove it from heap
        let res = arr[0];
        arr[0] = arr[arr.length-1];
        arr.pop();
        this.MinHeapify(0);
        return res;
    }


    // This function deletes key at index i. It first reduced value to minus
    // infinite, then calls extractMin()
    deleteKey(i)
    {
        this.decreaseKey(i, this.arr[0] - 1);
        this.extractMin();
    }

    // A recursive method to heapify a subtree with the root at given index
    // This method assumes that the subtrees are already heapified
    MinHeapify(i)
    {
        let arr = this.arr;
        let n = arr.length;
        if (n === 1) {
            return;
        }
        let l = this.left(i);
        let r = this.right(i);
        let smallest = i;
        if (l < n && arr[l] < arr[i])
            smallest = l;
        if (r < n && arr[r] < arr[smallest])
            smallest = r;
        if (smallest !== i)
        {
            [arr[i], arr[smallest]] = [arr[smallest], arr[i]]
            this.MinHeapify(smallest);
        }
    }
}

let h = new MinHeap();
    h.insert(3); 
    h.insert(2);
    h.deleteKey(1);
    h.insert(15);
    h.insert(5);
    h.insert(4);
    h.insert(45);
    
    console.log(h.extractMin() + " ");
    console.log(h.getMin() + " ");
    
    h.decreaseKey(2, 1); 
    console.log(h.extractMin());

```

```
2 4 1

```

### Applications of Heaps

- Heap Sort: Heap Sort uses Binary Heap to sort an array in O(nLogn) time.
- Priority Queue: Priority queues are efficiently implemented using Binary Heaps, which allow operations like insert, delete, extractMax, and decreaseKey in O(log N) time. Binomial and Fibonacci Heaps are advanced types that also support fast union operations.
- Graph Algorithms: The priority queues are especially used in Graph Algorithms like Dijkstra's Shortest Path and Prim's Minimum Spanning Tree.
- Many problems can be efficiently solved using Heaps. See following for example. a) K'th Largest Element in an array. b) Sort an almost sorted array/ c) Merge K Sorted Arrays.

Related Links:

- Coding Practice on Heap
- All Articles on Heap
- Quiz on Heap