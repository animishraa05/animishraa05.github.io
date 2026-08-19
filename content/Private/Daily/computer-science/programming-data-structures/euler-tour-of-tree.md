---
title: "Euler Tour of Tree"
topic: "programming-data-structures"
scraped_date: 2026-03-29
---

# Euler Tour of Tree
A Tree is a generalization of connected graph where it has N nodes that will have exactly N-1 edges, i.e one edge between every pair of vertices. Find the Euler tour of tree represented by adjacency list.

Examples:

Input :

![](images_ett_eg1.png)

Output : 1 2 3 2 4 2 1

Input :

![](images_ett2_eg2.png)

Output : 1 5 4 2 4 3 4 5 1

Euler tour is defined as a way of traversing tree such that each vertex is added to the tour when we visit it (either moving down from parent vertex or returning from child vertex). We start from root and reach back to root after visiting all vertices.It requires exactly 2*N-1 vertices to store Euler tour.

Approach: We will run DFS(Depth first search) algorithm on Tree as:

![](images_ett-1.png)

1. Visit root node, i.e 1 vis[1]=1, Euler[0]=1 run dfs() for all unvisited adjacent nodes(2)
2. Visit node 2 vis[2]=1, Euler[1]=2 run dfs() for all unvisited adjacent nodes(3, 4)
3. Visit node 3 vis[3]=1, Euler[2]=3 All adjacent nodes are already visited, return to parent node and add parent to Euler tour Euler[3]=2
4. Visit node 4 vis[4]=1, Euler[4]=4 All adjacent nodes are already visited, return to parent node and add parent to Euler tour, Euler[5]=2
5. Visit node 2 All adjacent nodes are already visited, return to parent node and add parent to Euler tour, Euler[6]=1
6. Visit node 1 All adjacent nodes are already visited, and node 1 is root node so, we stop our recursion here.

Similarly, for example 2:

![](images_ett2.png)

Implementation:

```
// C++ program to print Euler tour of a
// tree.
# include <bits/stdc++.h>
using namespace std;

# define MAX 1001

// Adjacency list representation of tree
vector<int> adj[MAX]; 

// Visited array to keep track visited 
// nodes on tour
int vis[MAX]; 

// Array to store Euler Tour
int Euler[2 * MAX]; 

// Function to add edges to tree
void add_edge(int u, int v)
{
    adj[u].push_back(v);
    adj[v].push_back(u);
}

// Function to store Euler Tour of tree
void eulerTree(int u, int &index)
{
    vis[u] = 1;
    Euler[index++] = u;
    for (auto it : adj[u]) {
        if (!vis[it]) {
            eulerTree(it, index);
            Euler[index++] = u;
        }
    }
}

// Function to print Euler Tour of tree
void printEulerTour(int root, int N)
{
    int index = 0;  
    eulerTree(root, index);
    for (int i = 0; i < (2*N-1); i++)
        cout << Euler[i] << " ";
}

// Driver code
int main()
{
    int N = 4;

    add_edge(1, 2);
    add_edge(2, 3);
    add_edge(2, 4);

    // Consider 1 as root and print
    // Euler tour 
    printEulerTour(1, N);

    return 0;
}

```

```
// Java program to print Euler tour of a
// tree.
import java.util.*;

class GFG{

static final int MAX = 1001;
static int index = 0;

// Adjacency list representation of tree
static ArrayList<
       ArrayList<Integer>> adj = new ArrayList<>();

// Visited array to keep track visited
// nodes on tour
static int vis[] = new int[MAX];

// Array to store Euler Tour
static int Euler[] = new int[2 * MAX];

// Function to add edges to tree
static void add_edge(int u, int v)
{
    adj.get(u).add(v);
    adj.get(v).add(u);
}

// Function to store Euler Tour of tree
static void eulerTree(int u)
{
    vis[u] = 1;
    Euler[index++] = u;
    
    for(int it : adj.get(u))
    {
        if (vis[it] == 0) 
        {
            eulerTree(it);
            Euler[index++] = u;
        }
    }
}

// Function to print Euler Tour of tree
static void printEulerTour(int root, int N)
{
    eulerTree(root);
    for(int i = 0; i < (2 * N - 1); i++)
        System.out.print(Euler[i] + " ");
}

// Driver code
public static void main(String[] args)
{
    int N = 4;
    
    for(int i = 0; i <= N; i++)
        adj.add(new ArrayList<>());
        
    add_edge(1, 2);
    add_edge(2, 3);
    add_edge(2, 4);

    // Consider 1 as root and print
    // Euler tour
    printEulerTour(1, N);
}
}

// This code is contributed by jrishabh99

```

```
# Python program to print Euler tour of a tree.
from collections import defaultdict

# Adjacency list representation of tree
adj = defaultdict(list)

# Visited dictionary to keep track of visited nodes on our tour
vis = defaultdict(bool)

# defaultdict to store Euler Tour
MAX = 1001
Euler = [0]*(2*MAX)

# Function to add edges to tree
def add_edge(u, v):
  adj[u].append(v)
  adj[v].append(u)
  
# Function to store Euler Tour of Tree
def eulerTree(u, index):
  vis[u] = True
  Euler[index] = u
  index += 1
  for nbr in adj[u]:
    if not vis[nbr]:
      index = eulerTree(nbr, index)
      Euler[index] = u
      index += 1
  return index
      
# Function to print Euler Tour of Tree
def printEulerTour(root, N):
  index = 0
  eulerTree(root, index)
  for i in range(2*N-1):
    print(Euler[i], end=" ")
    
# Driver Code
N = 4
add_edge(1, 2)
add_edge(2, 3)
add_edge(2, 4)

printEulerTour(1, N)

```

```
// C# code for the above approach
using System;
using System.Collections.Generic;

class GFG
{
    const int MAX = 1001;
    static int index = 0;

    // Adjacency list representation of tree
    static List<List<int>> adj = new List<List<int>>();

    // Visited array to keep track visited
    // nodes on tour
    static int[] vis = new int[MAX];

    // Array to store Euler Tour
    static int[] Euler = new int[2 * MAX];

    // Function to add edges to tree
    static void add_edge(int u, int v)
    {
        adj[u].Add(v);
        adj[v].Add(u);
    }

    // Function to store Euler Tour of tree
    static void eulerTree(int u)
    {
        vis[u] = 1;
        Euler[index++] = u;

        foreach (int it in adj[u])
        {
            if (vis[it] == 0)
            {
                eulerTree(it);
                Euler[index++] = u;
            }
        }
    }

    // Function to print Euler Tour of tree
    static void printEulerTour(int root, int N)
    {
        eulerTree(root);
        for (int i = 0; i < (2 * N - 1); i++)
            Console.Write(Euler[i] + " ");
    }

    // Driver code
    public static void Main(string[] args)
    {
        int N = 4;

        for (int i = 0; i <= N; i++)
            adj.Add(new List<int>());

        add_edge(1, 2);
        add_edge(2, 3);
        add_edge(2, 4);

        // Consider 1 as root and print
        // Euler tour
        printEulerTour(1, N);
    }
}

// This code is contributed by lokeshpotta20.

```

```
<script>

// Javascript program to print Euler tour of a
// tree.
var MAX = 1001;

// Adjacency list representation of tree
var adj = Array.from(Array(MAX), () => Array()); 

// Visited array to keep track visited 
// nodes on tour
var vis = Array(MAX);

// Array to store Euler Tour
var Euler = Array(2 * MAX);

// Function to add edges to tree
function add_edge(u, v)
{
    adj[u].push(v);
    adj[v].push(u);
}

// Function to store Euler Tour of tree
function eulerTree(u, index)
{
    vis[u] = 1;
    Euler[index++] = u;
    
    for(var it of adj[u])
    {
        if (!vis[it]) 
        {
            index = eulerTree(it, index);
            Euler[index++] = u;
        }
    }
    return index;
}

// Function to print Euler Tour of tree
function printEulerTour(root, N)
{
    var index = 0;  
    index = eulerTree(root, index);
    for(var i = 0; i < (2 * N - 1); i++)
        document.write(Euler[i] + " ");
}

// Driver code
var N = 4;
add_edge(1, 2);
add_edge(2, 3);
add_edge(2, 4);

// Consider 1 as root and print
// Euler tour 
printEulerTour(1, N);

// This code is contributed by rrrtnx

</script>

```

```
1 2 3 2 4 2 1 
```

Complexity Analysis:

- Auxiliary Space: O(N)
- Time Complexity: O(N)