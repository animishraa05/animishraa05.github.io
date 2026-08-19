---
title: "Merge Sort Tree (Smaller or equal elements in given row range)"
topic: "programming-data-structures"
scraped_date: 2026-03-29
---

# Merge Sort Tree (Smaller or equal elements in given row range)
Given an array where each element is a vector containing integers in sorted order. The task is to answer following queries:

```
count(start, end, k) : Count the numbers smaller than or equal 
                       to k in range from array index 'start'
                       to 'end'.
```

For convenience we consider an n * n 2-D array where each row corresponds to an integer vector. Examples:

```
Input : ar[][] = {{2, 4, 5},
                  {3, 4, 9}, 
                  {6, 8, 10}}

        Queries[] = (0, 1, 5)
                    (1, 2, 1)
                    (0, 2, 6)
Output : 5 
         0
         6
Count of elements (smaller than or equal to 5) from
1st row (index 0) to 2nd row (index 1) is 5.
Count of elements (smaller than or equal to 1) from
2nd row to 3nd row is 0
Count of elements (smaller than or equal to 6) from
1st row to 3nd row is 6.
```

The key idea is to build a Segment Tree with a vector at every node and the vector contains all the elements of the sub-range in a sorted order. And if we observe this segment tree structure this is somewhat similar to the tree formed during the merge sort algorithm(that is why it is called merge sort tree)

```
// C++ program to count number of smaller or
// equal to given number and given row range.
# include <bits/stdc++.h>
using namespace std;

const int MAX = 1000;

// Constructs a segment tree and stores sTree[]
void buildTree(int idx, int ss, int se, vector<int> a[],
               vector<int> sTree[])
{
    /*leaf node*/
    if (ss == se) {
        sTree[idx] = a[ss];
        return;
    }

    int mid = (ss + se) / 2;

    /* building left subtree */
    buildTree(2 * idx + 1, ss, mid, a, sTree);

    /* building right subtree */
    buildTree(2 * idx + 2, mid + 1, se, a, sTree);

    /* merging left and right child in sorted order */
    merge(sTree[2 * idx + 1].begin(),
          sTree[2 * idx + 1].end(),
          sTree[2 * idx + 2].begin(),
          sTree[2 * idx + 2].end(),
          back_inserter(sTree[idx]));
}

// Recursive function to count smaller elements from row
// a[ss] to a[se] and value smaller than or equal to k.
int queryRec(int node, int start, int end, int ss, int se,
             int k, vector<int> a[], vector<int> sTree[])
{
    /* If out of range return 0 */
    if (ss > end || start > se)
        return 0;

    /* if inside the range return count */
    if (ss <= start && se >= end) {
        /* binary search over the sorted vector
        to return count >= X */
        return upper_bound(sTree[node].begin(),
                           sTree[node].end(), k)
               - sTree[node].begin();
    }

    int mid = (start + end) / 2;

    /*searching in left subtree*/
    int p1 = queryRec(2 * node + 1, start, mid, ss, se, k,
                      a, sTree);

    /*searching in right subtree*/
    int p2 = queryRec(2 * node + 2, mid + 1, end, ss, se, k,
                      a, sTree);

    /*adding both the result*/
    return p1 + p2;
}

// A wrapper over query().
int query(int start, int end, int k, vector<int> a[], int n,
          vector<int> sTree[])
{
    return queryRec(0, 0, n - 1, start, end, k, a, sTree);
}

// Driver code
int main()
{
    int n = 3;
    int arr[][3]
        = { { 2, 4, 5 }, { 3, 4, 9 }, { 6, 8, 10 } };

    // build an array of vectors from above input
    vector<int> a[n];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            a[i].push_back(arr[i][j]);

    // Construct segment tree
    vector<int> sTree[MAX];
    buildTree(0, 0, n - 1, a, sTree);

    /* un-comment to print merge sort tree*/
    /*for (int i=0;i<2*n-1;i++)
    {
            cout << i << " ";
            for (int j=0;j<sTree[i].size();j++)
            cout << sTree[i][j]<<" ";
            cout << endl;
    }*/

    // Answer queries
    cout << query(0, 1, 5, a, n, sTree) << endl;
    cout << query(1, 2, 1, a, n, sTree) << endl;
    cout << query(0, 2, 6, a, n, sTree) << endl;

    return 0;
}

```

```
import java.util.*;

// JAVA program to count number of smaller or
// equal to given number and given row range.
public class mergeSortTree {

    static void buildTree(int idx, int ss, int se,
                          ArrayList<Integer> a[],
                          ArrayList<Integer> tree[])
    {
        /*leaf node*/
        if (ss == se) {
            tree[idx] = a[ss];
            return;
        }

        int mid = (ss + se) >> 1;

        /* building left subtree recursively*/
        buildTree(2 * idx + 1, ss, mid, a, tree);

        /* building right subtree recursively*/
        buildTree(2 * idx + 2, mid + 1, se, a, tree);

        /* merging left and right child in sorted order */
        tree[idx]
            = merge(tree[2 * idx + 1], tree[2 * idx + 2]);
    }

    static int upbound(ArrayList<Integer> temp, int val)
    {
        int lo = 0;
        int hi = temp.size() - 1;
        
        while (hi >= lo) {
            int mid = (lo + hi) >> 1;
            if (temp.get(mid) <= val) {
               lo = mid + 1;
            }
            else
                hi = mid - 1;
        }
        return lo;
    }

    static int queryRec(int node, int start, int end,
                        int ss, int se, int k,
                        ArrayList<Integer> a[],
                        ArrayList<Integer> tree[])
    {
        /* If out of range return 0 */
        if (ss > end || se < start)
            return 0;

        /* if inside the range return count */
        if (ss <= start && se >= end) {
            /* binary search over the sorted
            ArrayList to return count >= X */
            return upbound(tree[node], k);
        }

        int mid = (start + end) / 2;

        /*searching in left subtree*/
        int q1 = queryRec(2 * node + 1, start, mid, ss, se,
                          k, a, tree);

        /*searching in right subtree*/
        int q2 = queryRec(2 * node + 2, mid + 1, end, ss,
                          se, k, a, tree);

        /*adding both the result*/
        return q1 + q2;
    }

    // A wrapper over query().
    static int query(int start, int end, int k,
                     ArrayList<Integer> a[], int n,
                     ArrayList<Integer> sTree[])
    {
        return queryRec(0, 0, n - 1, start, end, k, a,
                        sTree);
    }

    // merge function
    static ArrayList<Integer> merge(ArrayList<Integer> a,
                                    ArrayList<Integer> b)
    {
        // Initialise Arraylist res with all elements of a
        ArrayList<Integer> res = new ArrayList<>(a);
        // Add all elements of b to res
        res.addAll(b);
        // sort ArrayList res
        Collections.sort(res);
          /*return sorted resultant ArrayList
          created from both ArrayLists a and b*/
        return res;
    }

    // Driver code
    public static void main(String[] args)
    {

        int n = 3;
        int[][] arr
            = { { 2, 4, 5 }, { 3, 4, 9 }, { 6, 8, 10 } };

        // build an array of ArrayLists from above input
        ArrayList<Integer> a[] = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            a[i] = new ArrayList<Integer>();
            for (int j = 0; j < n; j++)
                a[i].add(arr[i][j]);
        }

        // Construct segment tree
        ArrayList<Integer> tree[]
            = new ArrayList[4 * n]; // tree
        buildTree(0, 0, n - 1, a, tree);

        /* un-comment to print merge sort tree*/
        /*for(int i=0;i<4*n;i++)
        {
            System.out.println(tree[i]);
        }*/

        // Answer queries
        System.out.println(query(0, 1, 5, a, n, tree));
        System.out.println(query(1, 2, 1, a, n, tree));
        System.out.println(query(0, 2, 6, a, n, tree));
    }
}

// This code is contributed by sanketgolar51

```

```
import bisect

# Constructs a segment tree and stores sTree[]
def buildTree(idx, ss, se, a, sTree):
    # leaf node
    if ss == se:
        sTree[idx] = a[ss]
        return

    mid = (ss + se) // 2

    # building left subtree
    buildTree(2 * idx + 1, ss, mid, a, sTree)

    # building right subtree
    buildTree(2 * idx + 2, mid + 1, se, a, sTree)

    # merging left and right child in sorted order
    sTree[idx] = sorted(sTree[2 * idx + 1] + sTree[2 * idx + 2])

# Recursive function to count smaller elements from row
# a[ss] to a[se] and value smaller than or equal to k.
def queryRec(node, start, end, ss, se, k, a, sTree):
    # If out of range return 0
    if ss > end or start > se:
        return 0

    # if inside the range return count
    if ss <= start and se >= end:
        # binary search over the sorted list to return count >= k
        return bisect.bisect_right(sTree[node], k) - start

    mid = (start + end) // 2

    # searching in left subtree
    p1 = queryRec(2 * node + 1, start, mid, ss, se, k, a, sTree)

    # searching in right subtree
    p2 = queryRec(2 * node + 2, mid + 1, end, ss, se, k, a, sTree)
    if p1 + p2 <0:
       return 0 
       

    # adding both the result
   
    return p1 + p2

# A wrapper over query().
def query(start, end, k, a, n, sTree):
    return queryRec(0, 0, n - 1, start, end, k, a, sTree)

# Driver code
if __name__ == '__main__':
    n = 3
    arr = [[2, 4, 5], [3, 4, 9], [6, 8, 10]]

    # build an array of lists from above input
    a = [[] for _ in range(n)]
    for i in range(n):
        for j in range(n):
            a[i].append(arr[i][j])

    # Construct segment tree
    sTree = [[] for _ in range(4 * n)]
    buildTree(0, 0, n - 1, a, sTree)

    # Answer queries
    print(query(0, 1, 5, a, n, sTree))
    print(query(1, 2, 1, a, n, sTree))
    print(query(0, 2, 6, a, n, sTree))

```

```
// C# program to count number of smaller or equal to given
// number and given row range.
using System;
using System.Collections.Generic;

public class GFG {

  static void BuildTree(int idx, int ss, int se,
                        List<int>[] a, List<int>[] tree)
  {
    /*leaf node*/
    if (ss == se) {
      tree[idx] = a[ss];
      return;
    }

    int mid = (ss + se) / 2;

    /* building left subtree recursively*/
    BuildTree(2 * idx + 1, ss, mid, a, tree);

    /* building right subtree recursively*/
    BuildTree(2 * idx + 2, mid + 1, se, a, tree);

    /* merging left and right child in sorted order */
    tree[idx]
      = Merge(tree[2 * idx + 1], tree[2 * idx + 2]);
  }

  static int Upbound(List<int> temp, int val)
  {
    int lo = 0;
    int hi = temp.Count - 1;

    while (hi >= lo) {
      int mid = (lo + hi) / 2;
      if (temp[mid] <= val) {
        lo = mid + 1;
      }
      else
        hi = mid - 1;
    }
    return lo;
  }

  static int QueryRec(int node, int start, int end,
                      int ss, int se, int k,
                      List<int>[] a, List<int>[] tree)
  {
    /* If out of range return 0 */
    if (ss > end || se < start)
      return 0;

    /* if inside the range return count */
    if (ss <= start && se >= end) {
      /* binary search over the sorted
            ArrayList to return count >= X */
      return Upbound(tree[node], k);
    }

    int mid = (start + end) / 2;

    /*searching in left subtree*/
    int q1 = QueryRec(2 * node + 1, start, mid, ss, se,
                      k, a, tree);

    /*searching in right subtree*/
    int q2 = QueryRec(2 * node + 2, mid + 1, end, ss,
                      se, k, a, tree);

    /*adding both the result*/
    return q1 + q2;
  }

  // A wrapper over query().
  static int Query(int start, int end, int k,
                   List<int>[] a, int n,
                   List<int>[] sTree)
  {
    return QueryRec(0, 0, n - 1, start, end, k, a,
                    sTree);
  }

  // merge function
  static List<int> Merge(List<int> a, List<int> b)
  {
    // Initialize List res with all elements of a
    List<int> res = new List<int>(a);
    // Add all elements of b to res
    res.AddRange(b);
    // sort List res
    res.Sort();
    /*return sorted resultant List
        created from both Lists a and b*/
    return res;
  }

  static public void Main()
  {

    // Code
    int n = 3;
    int[, ] arr = new int[, ] { { 2, 4, 5 },
                               { 3, 4, 9 },
                               { 6, 8, 10 } };

    // build an array of lists from the above input.
    List<int>[] a = new List<int>[ n ];
    for (int i = 0; i < n; i++) {
      a[i] = new List<int>();
      for (int j = 0; j < n; j++)
        a[i].Add(arr[i, j]);
    }

    List<int>[] tree = new List<int>[ 4 * n ];
    BuildTree(0, 0, n - 1, a, tree);

    Console.WriteLine(Query(0, 1, 5, a, n, tree));
    Console.WriteLine(Query(1, 2, 1, a, n, tree));
    Console.WriteLine(Query(0, 2, 6, a, n, tree));
  }
}

// This code is contributed by karthik.

```

```
// JavaScript function to count number of smaller or
// equal to given number and given row range.
const mergeSortTree = {
  buildTree(idx, ss, se, a, tree) {
    /*leaf node*/
    if (ss === se) {
      tree[idx] = a[ss];
      return;
    }

    let mid = Math.floor((ss + se) / 2);

    /* building left subtree recursively*/
    this.buildTree(2 * idx + 1, ss, mid, a, tree);

    /* building right subtree recursively*/
    this.buildTree(2 * idx + 2, mid + 1, se, a, tree);

    /* merging left and right child in sorted order */
    tree[idx] = this.merge(tree[2 * idx + 1], tree[2 * idx + 2]);
  },

  upbound(temp, val) {
    let lo = 0;
    let hi = temp.length - 1;

    while (hi >= lo) {
      let mid = Math.floor((lo + hi) / 2);
      if (temp[mid] <= val) {
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }
    return lo;
  },

  queryRec(node, start, end, ss, se, k, a, tree) {
    /* If out of range return 0 */
    if (ss > end || se < start) return 0;

    /* if inside the range return count */
    if (ss <= start && se >= end) {
      /* binary search over the sorted
      ArrayList to return count >= X */
      return this.upbound(tree[node], k);
    }

    let mid = Math.floor((start + end) / 2);

    /*searching in left subtree*/
    let q1 = this.queryRec(2 * node + 1, start, mid, ss, se, k, a, tree);

    /*searching in right subtree*/
    let q2 = this.queryRec(2 * node + 2, mid + 1, end, ss, se, k, a, tree);

    /*adding both the result*/
    return q1 + q2;
  },

  // A wrapper over query().
  query(start, end, k, a, n, sTree) {
    return this.queryRec(0, 0, n - 1, start, end, k, a, sTree);
  },

  // merge function
  merge(a, b) {
    // Initialise Arraylist res with all elements of a
    let res = [...a];
    // Add all elements of b to res
    res = res.concat(b);
    // sort ArrayList res
    res.sort((a, b) => a - b);
    /*return sorted resultant ArrayList
    created from both ArrayLists a and b*/
    return res;
  },

  // Driver code
  main() {
    let n = 3;
    let arr = [[2, 4, 5], [3, 4, 9], [6, 8, 10]];

    // build an array of ArrayLists from above input
    let a = [];
    for (let i = 0; i < n; i++) {
      a[i] = [];
      for (let j = 0; j < n; j++) {
        a[i].push(arr[i][j]);
      }
    }

    // Construct segment tree
    let tree = [];
    this.buildTree(0, 0, n - 1, a, tree);

    /* un-comment to print merge sort tree*/
    /*for(let i=0;i<4*n;i++)
    {
      console.log(tree[i]);
    }*/

    // Answer queries
    console.log(this.query(0, 1, 5, a, n, tree));
    console.log(this.query(1, 2, 1, a, n, tree));
    console.log(this.query(0, 2, 6, a, n, tree));
  }
};

mergeSortTree.main();

// This code is contributed by lokesh.

```

```
5
0
6
```

buildTree() analysis : Build a merge sort tree takes O(N log N) time which is same as Merge Sort Algorithm. It also takes O(n log n) extra space. query() analysis : A range 'start' to 'end' can divided into at most Log(n) parts, where we will perform binary search on each part . Binary search requires O(Log n). Therefore total complexity O(Log n * Log n).

The space complexity of the program is O(n log n) since the segment tree is constructed using an array of vectors with a maximum size of n log n.