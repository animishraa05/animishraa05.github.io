---
title: "Interval Tree"
topic: "programming-data-structures"
scraped_date: 2026-03-29
---

# Interval Tree
You are given a set of intervals, where each interval contains two variables, low and high, that defines the start and end time of the interval. The task is perform the following operations efficiently:

- Add an interval
- Remove an interval
- Given an interval x, find if x overlaps with any of the existing intervals.

Table of Content

- What is an Interval Tree?
- How to find if the given interval overlaps with existing interval ?
- How does the above algorithm work?
- Applications of Interval Tree:
- Interval Tree vs Segment Tree
- Operations can be perform on the interval tree are:
- Algorithmic steps to implement the Tree operations

### What is an Interval Tree?

> The idea is to augment a self-balancing Binary Search Tree (BST) called Interval Tree similar to Red Black Tree, AVL Tree, etc to maintain set of intervals so that all operations can be done in O(log n) time. Every node of Interval Tree stores following information. i: An interval which is represented as a pair [start, end] max: Maximum high value in subtree rooted with this node.The low value of an interval is used as key to maintain order in BST. The insert and delete operations are same as insert and delete in self-balancing BST used.

The idea is to augment a self-balancing Binary Search Tree (BST) called Interval Tree similar to Red Black Tree, AVL Tree, etc to maintain set of intervals so that all operations can be done in O(log n) time. Every node of Interval Tree stores following information.

- i: An interval which is represented as a pair [start, end]
- max: Maximum high value in subtree rooted with this node.

The low value of an interval is used as key to maintain order in BST. The insert and delete operations are same as insert and delete in self-balancing BST used.

![IntervalSearcTree](images_intervalsearctree.png)

### How to find if the given interval overlaps with existing interval ?

> Following is algorithm for searching an overlapping interval x in an Interval tree rooted with root: If x overlaps with root's interval, return the root's interval.If left child of root is not empty and the max in left child is greater than x's low value, recur for left childElse recur for right child.

Following is algorithm for searching an overlapping interval x in an Interval tree rooted with root:

- If x overlaps with root's interval, return the root's interval.
- If left child of root is not empty and the max in left child is greater than x's low value, recur for left child
- Else recur for right child.

### How does the above algorithm work?

> Let the interval to be searched be x. We need to prove this in for following two cases:Case 1: When we go to right subtree, one of the following must be true. There is an overlap in right subtree: This is fine as we need to return one overlapping interval. There is no overlap in either subtree: We go to right subtree only when either left is NULL or maximum value in left is smaller than x.low. So the interval cannot be present in left subtree.Case 2: When we go to left subtree, one of the following must be true. There is an overlap in left subtree: This is fine as we need to return one overlapping interval. There is no overlap in either subtree: This is the most important part. We need to consider following facts:

Let the interval to be searched be x. We need to prove this in for following two cases:

Case 1: When we go to right subtree, one of the following must be true.

- There is an overlap in right subtree: This is fine as we need to return one overlapping interval.
- There is no overlap in either subtree: We go to right subtree only when either left is NULL or maximum value in left is smaller than x.low. So the interval cannot be present in left subtree.

Case 2: When we go to left subtree, one of the following must be true.

- There is an overlap in left subtree: This is fine as we need to return one overlapping interval.
- There is no overlap in either subtree: This is the most important part. We need to consider following facts:

1. We went to left subtree because x.low <= max in left subtree
2. max in left subtree is a high of one of the intervals let us say [a, max] in left subtree.
3. Since x doesn't overlap with any node in left subtree x.high must be smaller than 'a'.
4. All nodes in BST are ordered by low value, so all nodes in right subtree must have low value greater than 'a'.
5. From above two facts, we can say all intervals in right subtree have low value greater than x.high. So x cannot overlap with any interval in right subtree.

### How do Insert and Delete work?

The operations work same as Binary Search Tree (BST) insert and delete operations as a Segment tree is mainly a BST

```
// C++ Program to implement Interval Tree
# include <iostream>
using namespace std;

// Structure to represent an interval
struct Interval {
    int low, high;
};

// Structure to represent a node in Interval Search Tree
struct Node {
    Interval *i;  
    int max;
    Node *left, *right;
};

// A utility function to create a new Interval Search Tree Node
Node * newNode(Interval i) {
    Node *temp = new Node;
    temp->i = new Interval(i);
    temp->max = i.high;
    temp->left = temp->right = nullptr;
    return temp;
};

// A utility function to insert a new Interval Search Tree Node
// This is similar to BST Insert.  Here the low value of interval
// is used tomaintain BST property
Node *insert(Node *root, Interval i) {

    // Base case: Tree is empty, new node becomes root
    if (root == nullptr)
        return newNode(i);

    // Get low value of interval at root
    int l = root->i->low;

    // If root's low value is smaller, 
    // then new interval goes to left subtree
    if (i.low < l)
        root->left = insert(root->left, i);

    // Else, new node goes to right subtree.
    else
        root->right = insert(root->right, i);

    // Update the max value of this ancestor if needed
    if (root->max < i.high)
        root->max = i.high;

    return root;
}

// A utility function to check if given two intervals overlap
bool isOverlapping(Interval i1, Interval i2) {
    if (i1.low <= i2.high && i2.low <= i1.high)
        return true;
    return false;
}

// The main function that searches a given 
// interval i in a given Interval Tree.
Interval *overlapSearch(Node *root, Interval i) {

    // Base Case, tree is empty
    if (root == nullptr) return nullptr;

    // If given interval overlaps with root
    if (isOverlapping(*(root->i), i))
        return root->i;

    // If left child of root is present and max of left child is
    // greater than or equal to given interval, then i may
    // overlap with an interval is left subtree
    if (root->left != nullptr && root->left->max >= i.low)
        return overlapSearch(root->left, i);

    // Else interval can only overlap with right subtree
    return overlapSearch(root->right, i);
}

void inorder(Node *root) {
    if (root == nullptr) return;
    inorder(root->left);
    cout << "[" << root->i->low << ", " << root->i->high << "]"
         << " max = " << root->max << endl;
    inorder(root->right);
}

int main() {
    Interval ints[] = {{15, 20}, {10, 30}, {17, 19},
        {5, 20}, {12, 15}, {30, 40}
    };
    int n = sizeof(ints)/sizeof(ints[0]);
    Node *root = nullptr;
    for (int i = 0; i < n; i++)
        root = insert(root, ints[i]);

    cout << "Inorder traversal of constructed Interval Tree is\n";
    inorder(root);

    Interval x = {6, 7};

    cout << "\nSearching for interval [" << x.low << "," << x.high << "]";
    Interval *res = overlapSearch(root, x);
    if (res == nullptr)
        cout << "\nNo Overlapping Interval";
    else
        cout << "\nOverlaps with [" << res->low << ", " << res->high << "]";
    return 0;
}

```

```
// C++ Program to implement Interval Tree
import java.util.*;
class Interval {
    int low, high;
    Interval(int low, int high) {
        this.low = low;
        this.high = high;
    }
}

class Node {
    Interval i;  
    int max;
    Node left, right;
}

class GFG {
    
    // A utility function to create a new Interval Search Tree Node
    static Node newNode(Interval i) {
        Node temp = new Node();
        temp.i = new Interval(i.low, i.high);
        temp.max = i.high;
        temp.left = temp.right = null;
        return temp;
    }
    
    // A utility function to insert a new Interval Search Tree Node
    // This is similar to BST Insert.  Here the low value of interval
    // is used tomaintain BST property
    static Node insert(Node root, Interval i) {
        
        // Base case: Tree is empty, new node becomes root
        if (root == null)
            return newNode(i);
            
        // Get low value of interval at root
        int l = root.i.low;
        
        // If root's low value is smaller, 
        // then new interval goes to left subtree
        if (i.low < l)
            root.left = insert(root.left, i);
            
        // Else, new node goes to right subtree.
        else
            root.right = insert(root.right, i);
            
        // Update the max value of this ancestor if needed
        if (root.max < i.high)
            root.max = i.high;
        return root;
    }
    
    // A utility function to check if given two intervals overlap
    static boolean isOverlapping(Interval i1, Interval i2) {
        if (i1.low <= i2.high && i2.low <= i1.high)
            return true;
        return false;
    }
    
    // The main function that searches a given 
    // interval i in a given Interval Tree.
    static Interval overlapSearch(Node root, Interval i) {
        
        // Base Case, tree is empty
        if (root == null) return null;
        
        // If given interval overlaps with root
        if (isOverlapping(root.i, i))
            return root.i;
            
        // If left child of root is present and max of left child is
        // greater than or equal to given interval, then i may
        // overlap with an interval is left subtree
        if (root.left != null && root.left.max >= i.low)
            return overlapSearch(root.left, i);
            
        // Else interval can only overlap with right subtree
        return overlapSearch(root.right, i);
    }
    
    static void inorder(Node root) {
        if (root == null) return;
        inorder(root.left);
        System.out.println("[" + root.i.low + ", " + root.i.high + "]" + " max = " + root.max);
        inorder(root.right);
    }
    
    public static void main(String[] args) {
        Interval[] ints = { new Interval(15, 20), new Interval(10, 30), new Interval(17, 19),
            new Interval(5, 20), new Interval(12, 15), new Interval(30, 40)
        };
        
        int n = ints.length;
        
        Node root = null;
        for (int i = 0; i < n; i++)
            root = insert(root, ints[i]);
        System.out.println("Inorder traversal of constructed Interval Tree is");
        inorder(root);
        
        Interval x = new Interval(6, 7);
        System.out.print("\nSearching for interval [" + x.low + "," + x.high + "]");
        
        Interval res = overlapSearch(root, x);
        if (res == null)
            System.out.println("\nNo Overlapping Interval");
        else
            System.out.println("\nOverlaps with [" + res.low + ", " + res.high + "]");
    }
}

```

```
# C++ Program to implement Interval Tree
# Structure to represent an interval
class Interval:
    def __init__(self, low, high):
        self.low = low
        self.high = high

# Structure to represent a node in Interval Search Tree
class Node:
    def __init__(self, i):
        self.i = i  
        self.max = i.high
        self.left = None
        self.right = None

# A utility function to create a new Interval Search Tree Node
def newNode(i):
    temp = Node(Interval(i.low, i.high))
    return temp

# A utility function to insert a new Interval Search Tree Node
# This is similar to BST Insert.  Here the low value of interval
# is used tomaintain BST property
def insert(root, i):
    
    # Base case: Tree is empty, new node becomes root
    if root is None:
        return newNode(i)
        
    # Get low value of interval at root
    l = root.i.low
    
    # If root's low value is smaller, 
    # then new interval goes to left subtree
    if i.low < l:
        root.left = insert(root.left, i)
        
    # Else, new node goes to right subtree.
    else:
        root.right = insert(root.right, i)
        
    # Update the max value of this ancestor if needed
    if root.max < i.high:
        root.max = i.high
    return root

# A utility function to check if given two intervals overlap
def isOverlapping(i1, i2):
    if i1.low <= i2.high and i2.low <= i1.high:
        return True
    return False

# The main function that searches a given 
# interval i in a given Interval Tree.
def overlapSearch(root, i):
    
    # Base Case, tree is empty
    if root is None:
        return None
        
    # If given interval overlaps with root
    if isOverlapping(root.i, i):
        return root.i
        
    # If left child of root is present and max of left child is
    # greater than or equal to given interval, then i may
    # overlap with an interval is left subtree
    if root.left is not None and root.left.max >= i.low:
        return overlapSearch(root.left, i)
        
    # Else interval can only overlap with right subtree
    return overlapSearch(root.right, i)

def inorder(root):
    if root is None:
        return
    inorder(root.left)
    print("[" + str(root.i.low) + ", " + str(root.i.high) + "]" + " max = " + str(root.max))
    inorder(root.right)

def main():
    ints = [Interval(15, 20), Interval(10, 30), Interval(17, 19),
            Interval(5, 20), Interval(12, 15), Interval(30, 40)]
            
    n = len(ints)
    root = None
    for i in range(n):
        root = insert(root, ints[i])
        
    print("Inorder traversal of constructed Interval Tree is")
    inorder(root)
    
    x = Interval(6, 7)
    print("\nSearching for interval [" + str(x.low) + "," + str(x.high) + "]", end="")
    
    res = overlapSearch(root, x)
    if res is None:
        print("\nNo Overlapping Interval")
    else:
        print("\nOverlaps with [" + str(res.low) + ", " + str(res.high) + "]")

if __name__ == "__main__":
    main()

```

```
// C++ Program to implement Interval Tree
using System;
class Interval {
    public int low, high;
    public Interval(int low, int high) {
        this.low = low;
        this.high = high;
    }
}

class Node {
    public Interval i;  
    public int max;
    public Node left, right;
}
class GFG {
    
    // A utility function to create a new Interval Search Tree Node
    static Node newNode(Interval i) {
        Node temp = new Node();
        temp.i = new Interval(i.low, i.high);
        temp.max = i.high;
        temp.left = temp.right = null;
        return temp;
    }
    
    // A utility function to insert a new Interval Search Tree Node
    // This is similar to BST Insert.  Here the low value of interval
    // is used tomaintain BST property
    static Node insert(Node root, Interval i) {
        
        // Base case: Tree is empty, new node becomes root
        if (root == null)
            return newNode(i);
            
        // Get low value of interval at root
        int l = root.i.low;
        
        // If root's low value is smaller, 
        // then new interval goes to left subtree
        if (i.low < l)
            root.left = insert(root.left, i);
            
        // Else, new node goes to right subtree.
        else
            root.right = insert(root.right, i);
            
        // Update the max value of this ancestor if needed
        if (root.max < i.high)
            root.max = i.high;
        return root;
    }
    
    // A utility function to check if given two intervals overlap
    static bool isOverlapping(Interval i1, Interval i2) {
        if (i1.low <= i2.high && i2.low <= i1.high)
            return true;
        return false;
    }
    
    // The main function that searches a given 
    // interval i in a given Interval Tree.
    static Interval overlapSearch(Node root, Interval i) {
        
        // Base Case, tree is empty
        if (root == null) return null;
        
        // If given interval overlaps with root
        if (isOverlapping(root.i, i))
            return root.i;
            
        // If left child of root is present and max of left child is
        // greater than or equal to given interval, then i may
        // overlap with an interval is left subtree
        if (root.left != null && root.left.max >= i.low)
            return overlapSearch(root.left, i);
            
        // Else interval can only overlap with right subtree
        return overlapSearch(root.right, i);
    }
    
    static void inorder(Node root) {
        if (root == null) return;
        inorder(root.left);
        Console.WriteLine("[" + root.i.low + ", " + root.i.high + "]" + " max = " + root.max);
        inorder(root.right);
    }
    
    static void Main() {
        Interval[] ints = new Interval[] { new Interval(15, 20), new Interval(10, 30), new Interval(17, 19),
            new Interval(5, 20), new Interval(12, 15), new Interval(30, 40)
        };
        
        int n = ints.Length;
        Node root = null;
        for (int i = 0; i < n; i++)
            root = insert(root, ints[i]);
            
        Console.WriteLine("Inorder traversal of constructed Interval Tree is");
        inorder(root);
        
        Interval x = new Interval(6, 7);
        Console.Write("\nSearching for interval [" + x.low + "," + x.high + "]");
        
        Interval res = overlapSearch(root, x);
        if (res == null)
            Console.WriteLine("\nNo Overlapping Interval");
        else
            Console.WriteLine("\nOverlaps with [" + res.low + ", " + res.high + "]");
    }
}

```

```
// C++ Program to implement Interval Tree
// Structure to represent an interval
class Interval {
    constructor(low, high) {
        this.low = low;
        this.high = high;
    }
}

// Structure to represent a node in Interval Search Tree
class Node {
    constructor(i) {
        this.i = i;  
        this.max = i.high;
        this.left = null;
        this.right = null;
    }
}
// A utility function to create a new Interval Search Tree Node
function newNode(i) {
    let temp = new Node(new Interval(i.low, i.high));
    return temp;
}

// A utility function to insert a new Interval Search Tree Node
// This is similar to BST Insert.  Here the low value of interval
// is used tomaintain BST property
function insert(root, i) {
    
    // Base case: Tree is empty, new node becomes root
    if (root === null)
        return newNode(i);
        
    // Get low value of interval at root
    let l = root.i.low;
    
    // If root's low value is smaller, 
    // then new interval goes to left subtree
    if (i.low < l)
        root.left = insert(root.left, i);
        
    // Else, new node goes to right subtree.
    else
        root.right = insert(root.right, i);
        
    // Update the max value of this ancestor if needed
    if (root.max < i.high)
        root.max = i.high;
    return root;
}

// A utility function to check if given two intervals overlap
function isOverlapping(i1, i2) {
    if (i1.low <= i2.high && i2.low <= i1.high)
        return true;
    return false;
}

// The main function that searches a given 
// interval i in a given Interval Tree.
function overlapSearch(root, i) {
    
    // Base Case, tree is empty
    if (root === null) return null;
    
    // If given interval overlaps with root
    if (isOverlapping(root.i, i))
        return root.i;
        
    // If left child of root is present and max of left child is
    // greater than or equal to given interval, then i may
    // overlap with an interval is left subtree
    if (root.left !== null && root.left.max >= i.low)
        return overlapSearch(root.left, i);
        
    // Else interval can only overlap with right subtree
    return overlapSearch(root.right, i);
}

function inorder(root) {
    if (root === null) return;
    inorder(root.left);
    console.log("[" + root.i.low + ", " + root.i.high + "]" + " max = " + root.max);
    inorder(root.right);
}

function main() {
    let ints = [new Interval(15, 20), new Interval(10, 30), new Interval(17, 19),
        new Interval(5, 20), new Interval(12, 15), new Interval(30, 40)
    ];
    
    let n = ints.length;
    let root = null;
    for (let i = 0; i < n; i++)
        root = insert(root, ints[i]);
        
    console.log("Inorder traversal of constructed Interval Tree is");
    inorder(root);
    
    let x = new Interval(6, 7);
    
    console.log("\nSearching for interval [" + x.low + "," + x.high + "]");
    let res = overlapSearch(root, x);
    
    if (res === null)
        console.log("\nNo Overlapping Interval");
    else
        console.log("\nOverlaps with [" + res.low + ", " + res.high + "]");
}
main();

```

```
Inorder traversal of constructed Interval Tree is
[5, 20] max = 20
[10, 30] max = 30
[12, 15] max = 15
[15, 20] max = 40
[17, 19] max = 40
[30, 40] max = 40

Searching for interval [6,7]
Overlaps with [5, 20]
```

Time Complexity: O(n*h), where n is the number of intervals, and h is the height of Interval Tree. In average cases, h = log (n) and the time complexity will be O(n * log(n)). In the worst case, the tree will be skewed and the height will be n, thus the time complexity will be O(n ^ 2). If Interval Tree is made self-balancing like AVL Tree, then time complexity reduces to O(n * log n).Space Complexity: O(n + h), to store the n intervals, and considering the recursive call stack which can be O(h).

### Applications of Interval Tree:

> Interval tree is mainly a geometric data structure and often used for windowing queries, for instance, to find all roads on a computerized map inside a rectangular viewport, or to find all visible elements inside a three-dimensional scene

Interval tree is mainly a geometric data structure and often used for windowing queries, for instance, to find all roads on a computerized map inside a rectangular viewport, or to find all visible elements inside a three-dimensional scene

### Interval Tree vs Segment Tree

> Both segment and interval trees store intervals. Segment tree is mainly optimized for queries for a given point, and interval trees are mainly optimized for overlapping queries for a given interval.

Both segment and interval trees store intervals. Segment tree is mainly optimized for queries for a given point, and interval trees are mainly optimized for overlapping queries for a given interval.

### Operations can be perform on the interval tree are:

> Interval trees are a type of data structure used for organizing and searching intervals (i.e., ranges of values). The following are some of the operations that can be performed on an interval tree:

Interval trees are a type of data structure used for organizing and searching intervals (i.e., ranges of values). The following are some of the operations that can be performed on an interval tree:

- Insertion: Add a new interval to the tree.
- Deletion: Remove an interval from the tree.
- Search: Find all intervals that overlap with a given interval.
- Query: Find the interval in the tree that contains a given point.
- Range query: Find all intervals that overlap with a given range.
- Merge: Combine two or more interval trees into a single tree.
- Split: Divide a tree into two or more smaller trees based on a given interval.
- Balancing: Maintain the balance of the tree to ensure its performance is optimized.
- Traversal: Visit all intervals in the tree in a specific order, such as in-order, pre-order, or post-order.

In addition to these basic operations, interval trees can be extended to support more advanced operations, such as searching for intervals with a specific length, finding the closest intervals to a given point, and more. The choice of operations depends on the specific use case and requirements of the application.