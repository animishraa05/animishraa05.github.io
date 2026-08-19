# DSA Revision Cheat Sheet

## 1. Time Complexity

### Common Complexities

|Complexity|Typical Algorithm|
|---|---|
|O(1)|Hash lookup|
|O(log n)|Binary Search|
|O(n)|Single traversal|
|O(n log n)|Sorting, Heap|
|O(n²)|Two nested loops|
|O(n³)|Floyd Warshall|
|O(2ⁿ)|Subset Generation|
|O(n!)|Permutations|

### Input Size Guide

|n|Expected Complexity|
|---|---|
|≤ 10|O(n!)|
|≤ 20|O(2ⁿ)|
|≤ 500|O(n³)|
|≤ 5000|O(n²)|
|≤ 10⁶|O(n log n) / O(n)|

---

## 2. Arrays

### Sliding Window

Use when:

- Subarray
    
- Contiguous segment
    
- Longest/Shortest window
    

Template:

```cpp
int l = 0;
for(int r = 0; r < n; r++) {
    // add nums[r]

    while(condition) {
        // remove nums[l]
        l++;
    }
}
```

### Prefix Sum

```cpp
prefix[i] = prefix[i-1] + arr[i];
sum(l,r) = prefix[r] - prefix[l-1];
```

### Kadane's Algorithm

Maximum Subarray Sum

```cpp
int best = 0;
int cur = 0;

for(int x : arr){
    cur = max(x, cur + x);
    best = max(best, cur);
}
```

Complexity: O(n)

---

## 3. Sorting

```cpp
sort(v.begin(), v.end());
```

Descending:

```cpp
sort(v.rbegin(), v.rend());
```

Custom Comparator:

```cpp
sort(v.begin(), v.end(),
[](auto a, auto b){
    return a.second < b.second;
});
```

Complexity: O(n log n)

---

## 4. Binary Search

### Search Space Pattern

```cpp
while(l <= r){
    int mid = l + (r-l)/2;

    if(condition(mid))
        r = mid - 1;
    else
        l = mid + 1;
}
```

Recognize:

- Minimize maximum
    
- Maximize minimum
    
- Search answer
    

Complexity: O(log n)

---

## 5. Hashing

### Unordered Map

```cpp
unordered_map<int,int> mp;
mp[x]++;
```

### Unordered Set

```cpp
unordered_set<int> st;
```

Average Complexity:

- Insert O(1)
    
- Search O(1)
    

---

## 6. Linked List

Must Know:

### Reverse Linked List

```cpp
ListNode* prev = NULL;

while(head){
    ListNode* nxt = head->next;
    head->next = prev;
    prev = head;
    head = nxt;
}
```

### Fast Slow Pointer

Applications:

- Middle Node
    
- Cycle Detection
    

---

## 7. Stack

Applications:

### Monotonic Stack

Used For:

- Next Greater Element
    
- Largest Rectangle Histogram
    

```cpp
stack<int> st;
```

Complexity: O(n)

---

## 8. Queue / Deque

### BFS

```cpp
queue<int> q;
q.push(src);
```

### Sliding Window Maximum

```cpp
deque<int> dq;
```

Complexity: O(n)

---

## 9. Heap

### Max Heap

```cpp
priority_queue<int> pq;
```

### Min Heap

```cpp
priority_queue<int,
vector<int>,
greater<int>> pq;
```

Applications:

- K Largest
    
- K Smallest
    
- Dijkstra
    

Complexity:

- Push O(log n)
    
- Pop O(log n)
    

---

## 10. Trees

### DFS

```cpp
void dfs(int node){
    for(auto child : adj[node])
        dfs(child);
}
```

### BFS

```cpp
queue<int> q;
```

Must Know:

- Height
    
- Diameter
    
- LCA concept
    
- BST properties
    

---

## 11. Graphs

### Representation

```cpp
vector<int> adj[n];
```

### DFS

```cpp
dfs(node);
```

### BFS

```cpp
queue<int> q;
```

Applications:

- Connected Components
    
- Shortest Path (Unweighted)
    
- Cycle Detection
    

---

## 12. Topological Sort

### Kahn Algorithm

```cpp
queue<int> q;
```

Condition:

- Directed Acyclic Graph
    

Complexity:  
O(V + E)

---

## 13. Union Find (DSU)

```cpp
int find(int x){
    if(parent[x]==x)
        return x;
    return parent[x]=find(parent[x]);
}
```

Operations:

- Find
    
- Union
    

Complexity:  
Almost O(1)

Applications:

- Kruskal
    
- Connected Components
    

---

## 14. Dijkstra

For positive weights

```cpp
priority_queue<
pair<int,int>,
vector<pair<int,int>>,
greater<pair<int,int>>
> pq;
```

Complexity:

O((V+E) log V)

---

## 15. Dynamic Programming

### DP Thinking

1. State
    
2. Transition
    
3. Base Case
    
4. Memoization / Tabulation
    

### Fibonacci

```cpp
dp[i] = dp[i-1] + dp[i-2];
```

### Knapsack

```cpp
dp[i][w]
```

### LIS

O(n log n) preferred

### House Robber

Classic 1D DP

---

## 16. Backtracking

### Template

```cpp
void solve(){
    if(base){
        ans.push_back(path);
        return;
    }

    for(choice){
        choose;
        solve();
        unchoose;
    }
}
```

Applications:

- Subsets
    
- Permutations
    
- Combination Sum
    

---

## 17. Bit Manipulation

### Set Bit

```cpp
n |= (1 << i);
```

### Clear Bit

```cpp
n &= ~(1 << i);
```

### Toggle Bit

```cpp
n ^= (1 << i);
```

### Check Bit

```cpp
(n >> i) & 1
```

### Count Bits

```cpp
__builtin_popcount(n);
```

---

## 18. Math

### GCD

```cpp
gcd(a,b)
```

Complexity:  
O(log n)

### LCM

```cpp
a / gcd(a,b) * b
```

### Fast Power

```cpp
while(n){
    if(n&1) ans*=x;
    x*=x;
    n>>=1;
}
```

Complexity:  
O(log n)

### Modular Arithmetic

```cpp
const int MOD = 1e9+7;
```

Rules:

```cpp
(a+b)%MOD
(a*b)%MOD
(a-b+MOD)%MOD
```

---

## 19. STL You Must Know

```cpp
vector
pair
set
unordered_set
map
unordered_map
stack
queue
deque
priority_queue
sort()
lower_bound()
upper_bound()
```

---

## 20. Placement Checklist

Arrays & Strings ✓  
Binary Search ✓  
Hashing ✓  
Linked List ✓  
Stack ✓  
Queue ✓  
Heap ✓  
Trees ✓  
Graphs BFS/DFS ✓  
Topological Sort ✓  
DSU ✓  
Dijkstra ✓  
Dynamic Programming ✓  
Backtracking ✓  
Bit Manipulation ✓  
Math + GCD ✓

If you can solve medium-level questions from all the above topics, you are ready for most college placement coding rounds.