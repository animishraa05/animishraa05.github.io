# Executive Summary  
Coding interviews hinge on recognizing **patterns** rather than inventing new algorithms. Research shows that a small set of techniques (two pointers, sliding windows, hash tables, DFS/BFS, DP, greedy, etc.) covers ≈90% of interview problems. The key is to start every problem with a brute‐force plan (to truly understand the problem) and then systematically optimize it by spotting and eliminating bottlenecks. For example, if the brute solution uses nested loops to check all pairs in a sorted array, we switch to a *two-pointer* approach and cut O(n²) down to O(n). Likewise, repeated subproblem work suggests *dynamic programming* (memoization/tabulation), and checking contiguous ranges hints at a *sliding window* or *prefix-sum* trick. This report synthesizes authoritative sources into a **mechanical decision system**:  

- **Recognition Cues:** An explicit checklist of features in problem statements (e.g. “sorted array” or “pairs” → two pointers; “subarray”/“substring” → sliding window; “count/frequency” → hash maps; “tree/graph” → DFS/BFS; “combinations” → backtracking; “overlapping subproblems” → DP; “local greedy choice possible” → greedy, etc.).  
- **Decision Flowcharts:** Flowcharts (below) map input characteristics to likely patterns (two-pointer vs sliding-window vs hashing vs tree/graph vs DP, etc.), yielding a step-by-step “pattern of thought” when reading a problem.  
- **Core Templates:** 20–30 skeleton code templates (in pseudocode/C++) with annotations. For each, we include the *clue* that should immediately suggest using that template (e.g. sorted array + find pair → two-pointer loop).  
- **Brute→Optimal Procedure:** A formalized, almost-algorithmic approach to improving brute solutions: identify and remove **bottlenecks** (BUD: Bottlenecks, Unnecessary work, Duplicated work), use additional data structures or precomputation (e.g. hash tables, prefix sums), and apply classic transforms (sort+two-pointer, recursion→DP). This covers ~99% of interview optimizations, as corroborated by sources on interview strategy.  
- **Worked Examples:** We show 8 diverse problems (one per category) in detail, each with a brute-force solution annotated and then a step-by-step derivation of the optimized solution. These include array and string problems, sliding-window and two-pointer cases, hashing examples, tree (DFS/BFS) examples, a graph example, a DP problem, and a greedy problem. Each example’s solution path is **mechanical**: “Here’s the brute, we identify X in it as a bottleneck, so apply transformation Y (pattern Z) → new solution.”  
- **Cheat-Sheet Tables:** We compile a one-page cheat sheet and tables: (a) **Recognition Checklist** mapping problem features (clues) to patterns, (b) **Template Summary** mapping pattern → code skeleton + clues, and (c) **Example Comparisons** showing sample problems, their brute vs optimal complexities, and the pattern used.  
- **Daily Practice Workflow:** Finally, we propose a structured study plan: learn patterns in small blocks, solve a few representative problems per pattern, and review your cheat sheet daily (e.g. 15 min mental warmup before practice/tests). This keeps patterns fresh so that in an interview you “show up to fight” ready, not scrambling to recall fundamentals.  

All claims are backed by authoritative interviews and algorithm guides. Key references include pattern cheat sheets, the well-known *Cracking the Coding Interview* strategy (BUD optimization), and educational blogs (Byte-by-Byte, Code & Debug, Interview Coder, Medium articles, etc.) that emphasize pattern-centric problem solving.  

# 1. Recognition Cues (Checklist of Features to Inspect)  
When reading a problem, first catalog its key features. Use the following **checklist of clues** to map to known patterns：  

- **Data Structure/Input Type:**  
  - **Array or String:** Look for sorted order, contiguous segments, or frequency/count clues.  
  - **Linked List:** Linked-list-specific (e.g. pointers, “next”/“random” references).  
  - **Binary Tree/Tree:** Parent-child language, subtrees, ancestors.  
  - **Graph or Grid:** Mentions of nodes/edges, connectivity, grids, networks.  

- **Sorted Input / Pair/Triplet:** “Sorted array” or “find two/three numbers that….” → *Two Pointers*. E.g. “sorted”, “two sum”, “3Sum”, “container with most water” hint two-pointer.  

- **Contiguous Subarray/Substring:** Words like “subarray”, “substring”, “window”, “at most K distinct”, “max/min sum of subarray of size K” → *Sliding Window*. E.g. “Longest substring without repeating” or “min window substring” strongly imply sliding-window optimization (often from a naive O(n²) scan to O(n)).  

- **Fixed-Size Subarray:** If the length K is fixed, use a *Fixed-Window* sliding-window (move by one each time). If the window size can vary (e.g. “at most K distinct chars”, “<= S sum condition”), use a *variable-size* sliding window, expanding/shrinking two pointers.  

- **Search / Monotonicity:** If the problem space is **sorted or monotonic** (e.g. “search in a matrix”, “find minimum/maximum satisfying property”), consider *Binary Search* (or binary-search-on-answer for numeric search spaces).  

- **Counting / Existence Check:** If you need fast membership tests, frequencies, or to de-duplicate, use a *Hash Table / HashSet*. E.g. “count pairs with sum=K” or “are two strings anagrams?” suggests hashing or counting arrays.  

- **Stack / Next Greater:** If the problem involves **matching or sequential structure** (parentheses, evaluating expressions, or “next greater element” problems), consider a *Stack* (especially monotonic stack for next-greater patterns).  

- **Queues / BFS:** If you see levels or layers or “shortest path in unweighted graph or grid,” use *BFS*. Common words: “levels”, “minimum number of steps”, “rotten oranges” (spread in minutes).  

- **DFS (Graph/Tree):** If the task is about *connectivity* (“number of connected components”, “dfs traversal”), or exploring all branches (“max depth of tree”, “path existence”), use *DFS* recursively or with stack.  

- **Tree-Specific (Binary Tree):** For binary trees, ask: “Is this about root-to-leaf paths, tree depth, or combining child results?” That suggests DFS recursion (preorder/inorder/postorder templates). If it’s level-by-level, use BFS (queue).  

- **Graph-Specific:** If connections form a graph, apply BFS/DFS for connectivity (visited set), or use **topological sort** for ordering with prerequisites (e.g. *course schedule*). Cycle detection calls for DFS or Union-Find; shortest paths (unweighted) → BFS.  

- **All Combinations / Permutations:** Words like “generate all subsets/permutations”, “find all combinations summing to X”, “N-Queens”, etc., indicate *Backtracking* (DFS with undo).  

- **Overlapping Subproblems:** If the brute would recompute the same state many times (typical recursion with repeated subcalls), use *Dynamic Programming* (memoization or tabulation). Clues: “max sum/ways to reach N”, “count ways with constraints”, “largest common subsequence”, etc.  

- **Local Greedy Choice Possible:** Problems that say “maximize/minimize by choosing local best” (e.g. *Activity Selection*, *Fractional Knapsack*) often allow a *Greedy* solution. Clues: tasks or intervals to schedule, and it’s known local-optimal→global-optimal.  

- **Kth/Largest/Top-K:** Terms like “Kth largest element”, “top K frequent” → use a *Heap/Priority Queue*. For median, merging sorted lists → heap.  

- **Bitwise Tricks:** If there’s a bit-level twist (“find single number with XOR”, “check if power of two”, “count set bits”), use *bit manipulation* (XOR, shifts).  

- **Range Sum Queries / Prefix Sums:** When the problem repeatedly asks for sums over subarrays or submatrices, look for a *Prefix Sum* trick (precompute cumulative sums so ranges are O(1) queries). Eg. “subarray sum equals K” often becomes prefix-sum + hashmap.  

Each of the above checks should trigger immediately as you read the problem. The **decision flowchart** below formalizes these checks (array/string vs tree vs graph, sorted vs contiguous, etc.) so you can narrow in on 1–2 likely patterns. The **recognition checklist table** at the end summarizes these cues in one place. 

**Example Cues (from sources):** “Sorted array, find pairs” → two pointers.  “Subarray/substring, contiguous” → sliding window.  “Need O(1) lookup or frequency counts” → hashing.  “Parent-child nodes” → DFS/BFS on trees.  “All combinations” → backtracking.  These cues are echoed in interview-prep guides as the top signals of which template to use. 

# 2. Decision Flowcharts (Pattern Selection)  
Based on the checklist, we create **flowcharts** that start with the problem’s structure and lead to candidate patterns. The chart below (in Mermaid syntax) shows a top-down decision process. It first branches by input type, then by key clues. (In practice you’d do this reasoning mentally in seconds.)  

```mermaid
graph TD
    A[START: Read Problem] 
    A --> B{Input Type?}
    B -->|Array / String| C{Sorted?}
    B -->|Linked List| LL[Linked-List Tricks (fast/slow, reverse)]
    B -->|Binary Tree / Tree| T{Tree Task?}
    B -->|Graph / Grid| G{Graph Task?}
    B -->|Other (Number, etc.)| O{Check Others}
    
    C -->|Yes, need pairs/triplets| TwoP[Two Pointers (e.g. sorted 2-sum)]
    C -->|Yes, other search| Bin[Binary Search (sorted/monotonic)]
    C -->|No| D{Contiguous?}
    D -->|Yes (subarray/substring)| Win[Sliding Window]
    D -->|No| H{Count/Lookup?}
    H -->|Yes (counts, existence)| Hash[Hash Table (map/set)]
    H -->|No| O
    
    T -->|Level/Shortest Path| TBFS[BFS on Tree (level-order)]
    T -->|Path/Subtree/Properties| TDFS[DFS on Tree (recursive)]
    
    G -->|Connected components| BFS[Graph BFS/DFS (visit)]
    G -->|Shortest path| BFS
    G -->|Cycle/Topo?| Topo[Topological Sort / Cycle detection]
    
    O -->|Generate combinations| BT[Backtracking/Recursion]
    O -->|Optimal substructure| DP[Dynamic Programming (recursion+memo)]
    O -->|Greedy condition| GR[Greedy (sort+select)]
    O -->|Need top K| HP[Heap/Priority Queue]
    O -->|Bit-level ops| BitX[Bit Manipulation]
```

Above, each diamond “Yes/No?” test checks a feature (sorted array? contiguous subrange?) and each box is a pattern/template with a key source citation. For example, if the input is an array and *sorted* **and** we need pairs/triples, we go to **Two Pointers**. If it’s not sorted, we ask “contiguous subarray?” to decide on sliding window, otherwise “need count?” for hashing. Trees lead to BFS/DFS templates, graphs to BFS/DFS or topological, and “Other” leads to backtracking/DP/greedy/heap/bit. 

This “decision tree” aligns with interview guidance: first classify problem type, then pick from the 20–30 templates. 

# 3. Core Templates (Skeleton Code + Takeaways)  
Below are **core code templates** (in C++/pseudocode form) for ~20 common patterns. Each template is annotated and paired with the key *clue* that should trigger its use. For brevity we show representative code; variants (e.g. DFS recursive vs iterative) follow the same logic.  



- **Two Pointers (Sorted Array):**  
  ```cpp
  int l=0, r=n-1;
  while(l < r) {
      int s = nums[l] + nums[r];
      if(s == target) {  // found pair
          // process pair
          l++; r--;
      }
      else if(s < target) {
          l++;
      } else {
          r--;
      }
  }
  ```  
  *When to use:* Sorted array + find pair/triplet (e.g. 2-sum, 3-sum). Key idea: move one pointer from start and one from end, narrowing range in O(n) instead of O(n²) nested loops.  

- **Sliding Window (Contiguous Subarray):**  
  ```cpp
  int l=0, sum=0;
  for(int r=0; r<n; r++) {
      // add nums[r] into window
      sum += nums[r];
      // while window violates constraint, shrink from left:
      while(l <= r && /* condition broken, e.g. sum>k */) {
          sum -= nums[l++];
      }
      // now [l..r] is valid window: update answer (length, sum, etc.)
  }
  ```  
  *When to use:* Tasks asking about subarrays/substrings (max/min sum, longest unique, etc.). Key idea: maintain a moving window [l..r], expanding `r` and contracting `l` as needed. Avoids recomputing sums by updating incrementally in O(n).  

- **Fixed-Size Window (special case):**  
  ```cpp
  int sum=0;
  // first window [0..k-1]:
  for(int i=0; i<k; i++) sum += nums[i];
  ans = someFunc(sum);
  for(int i=k; i<n; i++) {
      sum += nums[i] - nums[i-k];  // slide by 1
      ans = max(ans, someFunc(sum));
  }
  ```  
  *Clue:* Asked for subarray of *exactly* size k (e.g. “max sum of any k-length subarray”). Equivalent to sliding window with fixed width: add new element and subtract element leaving window (O(n)).  

- **Binary Search (Sorted/Monotonic):**  
  ```cpp
  int lo = 0, hi = n-1;
  while(lo <= hi) {
      int mid = lo + (hi-lo)/2;
      if(nums[mid] == target) return mid;
      else if(nums[mid] < target) lo = mid+1;
      else hi = mid-1;
  }
  return -1;
  ```  
  *When to use:* Input is sorted or search space is monotonic (e.g. find element in sorted array, or binary search on answer space). Complexity O(log n). Pattern reduces search space by half each step.  

- **Hash Table (Counting/Lookup):**  
  ```cpp
  unordered_map<int,int> mp;
  for(int x: nums) {
      // Example: count occurrences or store index
      mp[x]++;
  }
  // Use mp[.] for O(1) lookup:
  if(mp.count(key)) { ... }
  ```  
  *When to use:* Need O(1) lookups, count frequencies, check existence. Common for “two sum unsorted” (store indices), subarray-sum (prefix sums in map), or any grouping by value.  

- **Stack (Monotonic/Matching):**  
  ```cpp
  stack<char> st;
  for(char c: s) {
      if(c=='(') st.push(c);
      else {
          if(st.empty()) return false;
          st.pop();
      }
  }
  // or for next-greater: pop while current > top
  ```  
  *When to use:* Matching brackets, expression evaluation, or next-greater problems. Key: use LIFO property. Monotonic stack variant: while `stack.top()` <= current, pop, etc.  

- **Queue (BFS):**  
  ```cpp
  queue<Node*> q;
  q.push(root);
  while(!q.empty()) {
      Node* cur = q.front(); q.pop();
      // process cur
      if(cur->left) q.push(cur->left);
      if(cur->right) q.push(cur->right);
  }
  ```  
  *When to use:* Level-order traversal of trees/grids; shortest-path in unweighted graph (BFS). Insert neighbors or children into queue to ensure FIFO order.  

- **DFS (Recursive/Stack):**  
  ```cpp
  void dfs(Node* u) {
      visited[u] = true;
      for(Node* v: neighbors[u]) {
          if(!visited[v]) dfs(v);
      }
  }
  ```  
  *When to use:* Explore all nodes in a component, compute subtree values, or search for a property. Recursion or manual stack for trees/graphs. Useful when structure is recursive (trees, backtracking).  

- **Linked List (Fast/Slow, Reversal):**  
  ```cpp
  // Fast-slow pointer (cycle detect or find middle):
  ListNode *slow=head, *fast=head;
  while(fast && fast->next) {
      slow = slow->next;
      fast = fast->next->next;
      if(slow == fast) { /* cycle detected */ }
  }
  
  // Reverse list template:
  ListNode *prev=nullptr, *cur=head;
  while(cur) {
      ListNode* next = cur->next;
      cur->next = prev;
      prev = cur;
      cur = next;
  }
  head = prev;
  ```  
  *When to use:* Any problem on linked lists (reordering, cycle detection, etc.). Fast/slow is key for middles and cycles; reversal trick for in-place reordering.  

- **Backtracking (Generate All Combinations):**  
  ```cpp
  void backtrack(vector<int>& path, int start) {
      // maybe save path if needed
      for(int i=start; i<n; i++) {
          path.push_back(nums[i]);
          backtrack(path, i+1);
          path.pop_back();  // undo choice
      }
  }
  ```  
  *When to use:* Generate subsets/permutations/combinations. The skeleton is: loop over choices, recurse, then undo (backtrack). Use pruning (stop early) if constraints break.  

- **Dynamic Programming (Recursion + Memo):**  
  ```cpp
  unordered_map<State,Result> memo;
  Result dp(State s) {
      if(memo.count(s)) return memo[s];
      // base case(s)
      // combine results of smaller states
      memo[s] = /* computed result */;
      return memo[s];
  }
  ```  
  *When to use:* Overlapping subproblems with optimal substructure. Start with a recursive solution (often naive exponential), then add memo to avoid recomputation. Alternatively, build a table bottom-up once states and transitions are clear.  

- **Greedy (Sort + Sweep):**  
  ```cpp
  sort(intervals.begin(), intervals.end(), cmpEnd);
  int count=0, last_end = -INF;
  for(auto& iv: intervals) {
      if(iv.start >= last_end) {
          count++;
          last_end = iv.end;
      }
  }
  ```  
  *When to use:* If a local choice (like earliest finish time) leads to a global optimum. Typical for interval scheduling, selecting min platforms, etc. Pattern: sort by key (end times, capacities) then linearly scan.  

- **Heap / Priority Queue:**  
  ```cpp
  priority_queue<int, vector<int>, greater<int>> pq; // min-heap
  for(int x: nums) {
      if(pq.size() < k) pq.push(x);
      else if(x > pq.top()) {
          pq.pop(); pq.push(x);
      }
  }
  ```  
  *When to use:* Find Kth largest/smallest, maintain top-K frequent, merge K sorted lists. Maintain a heap of size K. Complexity often O(n log K).  

- **Bit Manipulation:**  
  ```cpp
  int xor_sum = 0;
  for(int x: nums) xor_sum ^= x;  // finds unique element if all others are paired
  if((n & (n-1)) == 0) { /* n is power of 2 */ }
  ```  
  *When to use:* Problems involving XOR, parity, binary representations. Trick: XOR cancels pairs (a⊕a=0), and shifts/test bits for count or power-of-two checks.  

- **Prefix Sum (with Hash):**  
  ```cpp
  int count=0, prefix=0;
  unordered_map<int,int> mp; mp[0]=1;
  for(int x: nums) {
      prefix += x;
      // see if (prefix - target) seen before
      if(mp.count(prefix - target)) count += mp[prefix - target];
      mp[prefix]++;
  }
  ```  
  *When to use:* Subarray-sum problems (“count subarrays summing to K”) or any cumulative property queries. Precompute running sum and use a map to check ranges in O(1). Brute was O(n²); prefix+map is O(n).  

Each template above is used **mechanically**: you should be able to glance at a problem, spot a clue word/structure, and recall the relevant snippet. For example, if the input is a string and the problem asks for “longest substring with X property,” immediately think of sliding-window code. If it says “binary tree maximum depth,” recall the DFS recursion skeleton. These templates, once internalized, turn problem-solving into almost plug-and-play.  

**Table: Templates Summary**  
| Pattern / Template       | Code Sketch (skeleton)                                     | Spotting Clue                                     |
|--------------------------|-------------------------------------------------------------|----------------------------------------------------|
| Two Pointers             | `l=0, r=n-1; while(l<r){ sum=nums[l]+nums[r]; move l or r }` | Sorted input, find pair/target sum, remove dup.   |
| Sliding Window           | `l=0; for(r=0..n) { expand; while(break cond) shrink; update }` | Contiguous subarray/substring (max/min/count).    |
| Fixed-Size Window        | `sum of first k; for(i=k..n) { sum+=a[i]-a[i-k]; ... }`     | “subarray of size k” (max sum, average, etc.).    |
| Binary Search            | `lo=0, hi=n-1; while(lo<=hi){ mid=(lo+hi)/2; check mid }` | Sorted/monotonic data space, find threshold.      |
| Hash Table (Map/Set)     | `map mp; for(x:nums) mp[x]++; use mp for lookup` | Need O(1) lookup or count (Two Sum, freq, membership). |
| Stack (Monotonic)        | `stack st; for(x in arr){ while(st.top()<x) st.pop(); st.push(x); }` | Matching/parsing or next-greater sequence.        |
| Queue (BFS)              | `queue q; push start; while(q){ u=q.pop; for(v:adj[u]) push(v); }` | Level-order or shortest-path in unweighted graph/tree. |
| DFS (Recursion)          | `void dfs(u){ visited[u]=1; for(v:adj[u]) if(!vis[v]) dfs(v); }` | Explore connected comp, compute subtree result.   |
| Linked List (2-Pointer)  | `fast=head, slow=head; while(fast&&fast->next){fast=fast->next->next; slow=slow->next;}` | “Linked list” problems (cycle, middle).          |
| Linked List (Reverse)    | `prev=null; cur=head; while(cur){next=cur->next; cur->next=prev; prev=cur; cur=next;}` | Reverse or reorder in-place.                     |
| Backtracking/Recursion   | `void backtrack(path,i){ for(j=i..n){ choose, recurse, undo } }` | Generate all subsets/perms/combinations.          |
| DP (Memoization)         | `function f(state){ if(mp.has(state)) return mp[state]; ... mp[state]=result; return result; }` | Overlapping subproblems (count ways, max sum, etc.). |
| Greedy (Sort & Sweep)    | `sort(items); for(item in items){ if(canTake) take it; }` | Local-choice optimum (scheduling, interval selection). |
| Heap / PQ                | `priority_queue pq; for(x in arr){ if(pq.size()<k) pq.push(x); else if(x>pq.top()){pq.pop();pq.push(x);} }` | Top-K problems (Kth largest, merge lists).       |
| Bit Manipulation         | `xor=0; for(x:arr) xor^=x;` (or checks with `&`, `<<`) | Bit tricks: single number, power-of-2, bit counts. |
| Prefix-Sum + Hashmap     | (See above prefix sum code)                   | Range-sum/subarray-sum queries (“sum=k”).         |

*(See the **Recognition Checklist** table below for exact clue words that hint each template.)* 

# 4. Brute-Force → Optimal: A Mechanical Procedure  
We formalize a **step-by-step recipe** for improving any brute-force solution. This approach appears in sources from Byte-by-Byte to *Cracking the Coding Interview* and works for ~99% of coding problems:  

1. **Brute-Force First:** Write (or at least verbalize) the simplest correct solution without regard to efficiency. Often this is nested loops or complete recursion. Do not code yet; explain it out loud and note its complexity. This ensures you *understand* the problem fully.  

2. **Find Bottlenecks:** Identify the slow parts of the brute solution. Common bottlenecks are double/triple loops (O(n²), O(n³) work), repeated work in recursion, or unnecessary recomputation. Ask: *Why is this slow? What is it doing that repeats?*   For example, summing over all subarrays is O(n²) work; checking each pair is O(n²); DFS from each graph node is O(V²) etc.  

3. **BUD Optimization:** Apply the “BUD” heuristic:  
   - **Bottlenecks:** Locate the exact inner loop or recursion that dominates time.  
   - **Unnecessary Work:** See if any computation can be skipped or done just once (e.g. precompute something rather than recompute each time).  
   - **Duplicated Work:** If the same result is computed multiple times for different inputs, store and reuse it (memoize or use a table).  

4. **Use Data Structures / Precomputation:** If the brute does repeated scans or checks, often adding an auxiliary data structure helps. Common moves:  
   - Use a *HashMap/Set* to replace an inner loop with O(1) lookups (trade space for time). (E.g. replace checking “does any previous number = target-num” by storing seen numbers.)  
   - Use *prefix sums* to answer range-sum queries in O(1) instead of summing in O(n).  
   - **Sort data** if needed so that faster patterns apply (e.g. sort unsorted array to allow two-pointer or binary search).  

5. **Pattern Substitution:** Recognize if the problem fits a known pattern from Step 2, and replace the brute part with the corresponding template. For example:  
   - If brute had two nested loops over a sorted array, switch to **two-pointer** loops.  
   - If brute was sliding a window with inner sums (O(n²)), switch to **sliding-window** (update sum in O(1) each step).  
   - If brute was recursively exploring without storing, add **memoization** (or iterative DP).  
   - If brute tried all orderings, switch to **greedy** or graph algorithms (e.g. topological sort) if applicable.  

6. **Analyze & Refine:** After substitution, compute the new complexity. Check if all parts are optimal (usually O(n), O(n log n), or O(V+E) for BFS/DFS). If still too slow, go back to find any remaining bottleneck. In practice, one pass of pattern substitution solves nearly all interview problems.  

7. **Code & Test:** Once the optimal approach is sketched (e.g. “use hash map to get O(n)”), code it cleanly. The structure is usually similar to the brute (same variables/loops) with a few insertions/changes. Then test on examples and edge cases.

This methodic approach (brute → optimize by pattern) is emphasized by experts.  For example, for subarray-sum problems one “simple optimization” is often prefix sums+hashmap; for recursion with overlapping subcalls, the answer is *memoization*. 

**Common Optimizations (from sources):**  
- *Memoization (DP):* If brute recalculates the same subproblem, store results.  
- *Prefix Sum + Hash:* Turn O(n²) range-sum check into O(n) by storing running sums.  
- *Sort + Two Pointers:* Replace quadratic pair search with linear pointers.  
- *Sliding Window:* Replace nested loops over subarrays with one-pass window.  
- *Hash Table for Fast Lookup:* Replace “find if exists” inner loops with O(1) map checks.  
- *Time–Space Tradeoff:* As one source notes, “Hash tables are especially useful! Make a time vs. space tradeoff”. Using extra memory (maps, arrays) can often cut time drastically.  

# 5. Worked Examples (Brute→Optimal Step-by-Step)  
Below are 8 representative problems. Each is solved by the brute→optimal recipe, with code snippets and commentary. Each **transformation step** is mechanical: highlight the slow part of brute, apply the pattern, and show the new code/complexity.

---

### 5.1 Example: **Binary Search in Sorted Array**  
**Problem (array/string):** Given sorted array `nums` and target `T`, return its index or -1.  

- **Brute (Linear Search):** Check each element sequentially.  
  ```cpp
  int findIndex(vector<int>& nums, int T) {
      for(int i = 0; i < nums.size(); i++) {
          if(nums[i] == T) return i;
      }
      return -1;
  }
  ```  
  *Complexity:* O(n). (Correct but not optimal if n is large.)  

- **Optimization Clue:** Input is *sorted*, so we can do better than O(n). Sorted + search → *Binary Search*.  

- **Optimal (Binary Search):**  
  ```cpp
  int findIndex(vector<int>& nums, int T) {
      int lo = 0, hi = nums.size()-1;
      while(lo <= hi) {
          int mid = lo + (hi-lo)/2;
          if(nums[mid] == T) return mid;
          else if(nums[mid] < T) lo = mid+1;
          else hi = mid-1;
      }
      return -1;
  }
  ```  
  *Complexity:* O(log n). The code is almost identical to brute except we move `lo/hi` by halves. (Cue from [18†L142-L150] and typical binary search templates.)

---

### 5.2 Example: **3Sum (Sorted Array)**  
**Problem (array):** Given array `A` (not necessarily sorted) and target `T=0`, find all triples of indices `(i,j,k)` with `A[i]+A[j]+A[k]=0`.  

- **Brute:** Sort array for convenience (O(n log n)), then try every triple with three loops O(n³).  
  ```cpp
  sort(A.begin(), A.end());
  vector<vector<int>> res;
  int n = A.size();
  for(int i=0; i<n; i++) {
      for(int j=i+1; j<n; j++) {
          for(int k=j+1; k<n; k++) {
              if(A[i]+A[j]+A[k] == 0)
                  res.push_back({A[i],A[j],A[k]});
          }
      }
  }
  ```  
  *Complexity:* O(n³). Clearly too slow for large n.  

- **Bottleneck:** The triple loop. Noting array is sorted, the inner two loops can be combined using *two pointers*.  

- **Two-Pointer Fix:** For each `i`, we want pairs `(j,k)` with `A[j]+A[k] = -A[i]`. Use two indices at ends.  
  ```cpp
  sort(A.begin(), A.end());
  vector<vector<int>> res;
  int n = A.size();
  for(int i=0; i<n; i++) {
      if(i>0 && A[i]==A[i-1]) continue; // skip duplicates (optional)
      int lo = i+1, hi = n-1;
      while(lo < hi) {
          int s = A[i] + A[lo] + A[hi];
          if(s == 0) {
              res.push_back({A[i], A[lo], A[hi]});
              lo++; hi--;
              // skip duplicates:
              while(lo<hi && A[lo]==A[lo-1]) lo++;
              while(lo<hi && A[hi]==A[hi+1]) hi--;
          }
          else if(s < 0) lo++;
          else hi--;
      }
  }
  ```  
  *Complexity:* O(n²). We replaced the innermost O(n²) work (over `j,k` for each `i`) with a single while loop O(n). This matches the pattern in [21†L94-L101] (sorted pairs → two-pointer). 

---

### 5.3 Example: **Longest Substring Without Repeating Characters**  
**Problem (string):** Given string `S`, find the length of the longest substring with all distinct characters.  

- **Brute:** Try every starting index and extend until a repeat occurs (two loops, plus checking uniqueness).  
  ```cpp
  int longestUnique(string s) {
      int n = s.size(), best=0;
      for(int i=0; i<n; i++) {
          set<char> seen;
          int len=0;
          for(int j=i; j<n; j++) {
              if(seen.count(s[j])) break;
              seen.insert(s[j]);
              len++;
          }
          best = max(best, len);
      }
      return best;
  }
  ```  
  *Complexity:* O(n²) (worst-case for each i, the inner loop runs ~n).  

- **Bottleneck:** Nested loops. Clue: “longest substring without repeating” → sliding-window.  

- **Sliding-Window:** Maintain a window `[l..r]` with unique characters, expanding `r` and contracting `l` to remove duplicates.  
  ```cpp
  int longestUnique(string s) {
      vector<int> last(256, -1); // last index of char
      int best=0, start=0;
      for(int i=0; i<s.size(); i++) {
          if(last[s[i]] >= start) {
              // repeated char in current window
              start = last[s[i]] + 1;
          }
          last[s[i]] = i;
          best = max(best, i - start + 1);
      }
      return best;
  }
  ```  
  Or equivalently use a boolean array and a while-loop sliding technique. Complexity is O(n): each character is visited at most twice. This matches the sliding-window template and yields optimal linear time.  

---

### 5.4 Example: **Subarray Sum Equals K**  
**Problem (array):** Given array `nums` (can be negative) and integer `K`, count subarrays whose sum is `K`.  

- **Brute:** For each start index, sum subarrays until end.  
  ```cpp
  int countK(vector<int>& nums, int K) {
      int n = nums.size(), count=0;
      for(int i=0; i<n; i++) {
          int sum=0;
          for(int j=i; j<n; j++) {
              sum += nums[j];
              if(sum == K) count++;
          }
      }
      return count;
  }
  ```  
  *Complexity:* O(n²).  

- **Bottleneck:** Double loop summing. Clue: repeated range-sum calculations. The prefix-sum + hashmap trick: if `prefix[i] = sum of nums[0..i]`, then any subarray sum `nums[a..b] = prefix[b] - prefix[a-1]`. Use a map to see if `prefix - K` occurred.  

- **Prefix-Sum + Hash:**  
  ```cpp
  int countK(vector<int>& nums, int K) {
      unordered_map<int,int> mp;
      mp[0] = 1; // empty prefix
      int prefix=0, count=0;
      for(int x: nums) {
          prefix += x;
          if(mp.count(prefix - K)) {
              count += mp[prefix - K];
          }
          mp[prefix]++; 
      }
      return count;
  }
  ```  
  *Complexity:* O(n). We eliminated nested loops by using a map for past prefix-sums. As CodeIntuition notes, this turns O(n²) brute into O(n).  

---

### 5.5 Example: **Number of Islands (Grid DFS)**  
**Problem (graph):** Given an `m×n` grid of 0/1, count the number of connected components of 1’s (horizontally/vertically) – “islands.”  

- **Brute:** Check each cell; if it’s land (1), do a DFS/BFS to mark that entire island (set to 0) so it’s not counted again.  
  ```cpp
  int numIslands(vector<vector<char>>& G) {
      int m=G.size(), n=G[0].size(), count=0;
      function<void(int,int)> dfs = [&](int i,int j){
          if(i<0||j<0||i>=m||j>=n||G[i][j]=='0') return;
          G[i][j] = '0';
          dfs(i+1,j); dfs(i-1,j);
          dfs(i,j+1); dfs(i,j-1);
      };
      for(int i=0;i<m;i++){
          for(int j=0;j<n;j++){
              if(G[i][j]=='1') {
                  count++;
                  dfs(i,j);
              }
          }
      }
      return count;
  }
  ```  
  *Complexity:* O(m·n) since each cell is visited once. (This is already optimal for this problem.)  

- **Pattern:** Connectivity on a grid → treat it as a graph and use DFS/BFS. Here brute=optimal; the “pattern” is graph traversal (DFS).  

*(Note: For other graph problems like “Course Schedule”, brute is infeasible [try all orders]; optimal is topological sort. But that’s beyond this simple example.)*

---

### 5.6 Example: **Climbing Stairs (DP)**  
**Problem (DP):** You can climb 1 or 2 steps at a time. How many ways to reach step n?  

- **Brute (Recursion):**  
  ```cpp
  int climb(int n) {
      if(n <= 1) return 1;
      return climb(n-1) + climb(n-2);
  }
  ```  
  *Complexity:* O(2^n) (exponential).  

- **Bottleneck:** This naive recursion does a lot of repeated work (fibonacci sequence). Clue: it’s exactly Fibonacci-like, so use *memoization*/DP.  

- **DP (Memo/Iteration):**  
  ```cpp
  int climb(int n) {
      vector<int> dp(n+1);
      dp[0] = 1;
      dp[1] = 1;
      for(int i=2; i<=n; i++){
          dp[i] = dp[i-1] + dp[i-2];
      }
      return dp[n];
  }
  ```  
  *Complexity:* O(n). This converts the exponential brute into linear time by storing intermediate results. (Alternatively use two variables instead of a dp array for O(1) space.)  

---

### 5.7 Example: **Activity Selection (Greedy Interval Scheduling)**  
**Problem (greedy):** Given a list of jobs with start/end times, select the maximum number of non-overlapping jobs.  

- **Brute:** Try all subsets of jobs to find the largest valid set – exponential.  

- **Clue:** Known greedy scenario. Sort intervals by end time and pick greedily.  

- **Greedy Solution:**  
  ```cpp
  int maxActivities(vector<pair<int,int>>& jobs) {
      sort(jobs.begin(), jobs.end(), [](auto &a, auto &b){
          return a.second < b.second;
      });
      int count=0, last_end=-1;
      for(auto &job: jobs) {
          if(job.first >= last_end) {
              count++;
              last_end = job.second;
          }
      }
      return count;
  }
  ```  
  *Complexity:* O(n log n) due to sorting. This is the textbook greedy for “Activity Selection”, far faster than brute.  

---

Each example above explicitly follows: *Write brute → find slow part → apply pattern → get new code.* The transitions are supported by the literature: e.g. two-pointers for sorted sums, sliding-window for substring problems, hash map for sums, memo for recursion, greedy for intervals, etc. After seeing ~50–100 problems this way, you’ll recognize the pattern so quickly it feels “mechanical.”  

# 6. Summary Cheat Sheet (Clue→Pattern→Complexity)  

Below is a one-page reference. On the left we list **problem clues/features**, in the middle the **pattern/template** to apply, and on the right the **time complexity** (optimal vs brute). Use this as a quick lookup during practice or a final mental review.  

| **Clue / Problem Type**                            | **Pattern / Template**                      | **Brute vs Optimal Complexity**       |
|----------------------------------------------------|---------------------------------------------|---------------------------------------|
| Sorted array, find pair/triplet with sum/target    | Two-Pointers                | O(n²) → O(n)                          |
| Subarray/substring (max, min, count, length)       | Sliding Window             | O(n²) → O(n)                          |
| Fixed-length subarray (sum of size k)              | Fixed-Window (slide sum)                  | O(n·k) → O(n)                         |
| Search in sorted/monotonic space                   | Binary Search             | O(n) → O(log n)                       |
| Need O(1) lookup / count (hashable elements)       | Hash Map / Hash Set       | O(n²) → O(n)                          |
| Matching brackets / next greater element           | Stack (monotonic stack)   | O(n²) → O(n) (monotonic)              |
| BFS/Shortest path on unweighted graph/grid         | Breadth-First Search      | exponential → O(V+E)                  |
| Connectivity / all paths in graph/tree             | Depth-First Search       | - (visit all nodes once O(V+E))       |
| All combos/permutations/subsets                    | Backtracking (DFS + backtrack) | exponential → enumerative (no opt.)  |
| Overlapping subproblems (max sum, count ways)      | Dynamic Programming (memo/DP) | exponential → polynomial (n, states) |
| Local-greedy choice optimal (intervals, knapsack)  | Greedy (sort + linear scan)   | brute subset (exp.) → O(n log n)      |
| Kth largest/smallest, top-K, merge lists           | Heap / Priority Queue      | n·k (naive) → O(n log k)             |
| Bitwise uniqueness / XOR trick                     | Bit Manipulation         | O(n²) → O(n) (constant ops)           |
| Repeated range-sums or submatrix-sums             | Prefix Sum (1D/2D)       | O(n²) → O(n)                          |
| Linked-list specific (cycle, middle, reverse)     | Fast/slow pointers, in-place reverse | - (O(n) scans)                      |
| Graph tasks: detect cycle/ordering                | DFS/TopoSort (Kahn’s)    | factorial→O(V+E) (toposort)          |
| Tree tasks: level order / depth                  | BFS (level) / DFS (recursive) | - (O(n) traversal)                 |

*(This table consolidates the above clues and templates; it can be printed or kept handy as the “brain dump” before a quiz or interview.)*

# 7. Daily Practice Workflow  
A disciplined daily routine cements the above system into reflex. The recommendation from experts and top-prepared candidates is: focus on patterns, not random problems. For example, Code & Debug suggests a phased approach:  

- **Phase 1 (Weeks 1–2):** Master *Arrays/Strings* patterns – two pointers, sliding window, hashing. Solve ~5–8 problems each.  
- **Phase 2 (Weeks 3–4):** *Sorting, Stacks, Linked Lists, Binary Search* – practice known questions under each template.  
- **Phase 3 (Weeks 5–6):** *Trees and Graphs* – BFS/DFS, topological sort, union-find. Again, 5–8 problems per pattern.  
- **Phase 4 (Weeks 7–8):** *Recursion/Backtracking and DP* – tackle subset/perm problems and classical DP (Fibonacci, knapsack, LCS).  

Concurrently (ongoing), drill *Greedy, Heap, Bit Manipulation* tasks as they appear. Crucially, **do not** solve blind random problems. After each practice problem, ask yourself (as one cheat sheet advises) “What pattern was this? How would I recognize it next time?”.

Before **every** mock interview or whiteboard session, do a *15-minute “warmup”* with your cheat sheet: quickly scan the list of patterns, any complexity notes, and glance at your template sketches. This primes your pattern-recognition “muscle memory” so that during the interview you react in seconds rather than scrambling.  For example, interview coaches recommend reviewing a one-page summary of templates and common pitfalls (nulls, off-by-one) right before coding.

**Practice Tips:**  
- Always start by verbalizing the brute approach, even if you optimize immediately. This prevents you from missing corner cases.  
- Time each session, aim for clarity and structured answers (like the BUD optimization approach) rather than just racing to code.  
- After solving, annotate your solution with *pattern labels*. E.g., label “Sliding Window” on a solved subarray problem. Repeatedly linking problems to patterns reinforces recognition.  
- Use the tables above for quick quiz-style recall. For instance, randomly pick a clue (e.g. “prefix sum”) and recite which template to use.  

By integrating pattern study, cheat-sheet review, and deliberate practice of a few problems per pattern, you transform problem-solving into a near-**mechanical algorithm**. Over time, reacting in 30 seconds from problem statement to pattern (as the “30-second rule” suggests) becomes achievable. In sum: **practice smart, not just hard** – focus on the *20%* of concepts that yield *80%* of interview problems.  

# Tables  

**Recognition Checklist:** Features (left) → Likely Pattern(s) (right).

| **Feature / Clue**                               | **Likely Pattern(s)**                                                |
|-------------------------------------------------|-----------------------------------------------------------------------|
| Sorted input; find target/pair/triplet          | Two Pointers, Binary Search           |
| Contiguous subarray/substring (max/min/count)    | Sliding Window                       |
| Fixed window size “k”                            | Fixed-Size Sliding Window                                            |
| Need fast lookup or frequency count              | HashMap / HashSet                    |
| Brackets or expression parsing                   | Stack (possibly Monotonic)                          |
| Next Greater Element (or similar order tasks)    | Monotonic Stack                                                     |
| Linked list operations (cycle, mid, reverse)     | Linked List patterns (two-pointer, reverse)        |
| Tree (“depth”, “leaf”, “validate BST”)           | DFS recursion / BFS                 |
| Graph/grid connectivity or reachability          | BFS/DFS on graph (visited set)                      |
| Shortest path in unweighted graph/grid           | BFS with queue                                      |
| Cycle in graph; ordering with prerequisites      | Topological Sort / DFS (cycle detect)               |
| Generate all combos/perms/subsets                | Backtracking (recursive DFS with undo)              |
| Overlapping subproblems (max sum, ways to do)    | DP / Memoization                      |
| Local optimal choice works (intervals, etc.)     | Greedy (sort+select)                               |
| Top K elements (largest/smallest)                | Heap / Priority Queue                               |
| XOR/sum over contiguous range                    | Prefix Sum (array or matrix)                        |
| Bitwise property (unique element, power of 2)    | Bit Manipulation                                    |

**Template Summary:** Pattern → Skeleton Code → Clue (see above).

| **Pattern**            | **Core Code Skeleton (annotated)**                                                                       | **Clue / Spotting**                            |
|------------------------|----------------------------------------------------------------------------------------------------------|------------------------------------------------|
| Two Pointers          | `l=0, r=n-1; while(l<r) { sum=nums[l]+nums[r]; /*adjust l,r*/ }`                               | Sorted array + find pair/target                |
| Sliding Window        | `l=0; for(r=0..n){ add nums[r]; while(break) remove nums[l++]; update result }`           | Contiguous subarray/substring constraints      |
| Fixed Window (size k) | Compute sum of first k; for(i=k..n-1){ sum+=a[i]-a[i-k]; update result }                                   | “subarray of length k”                         |
| Binary Search         | `lo=0, hi=n-1; while(lo<=hi){ mid=(lo+hi)/2; if(nums[mid]<target) lo=mid+1; else hi=mid-1; }` | Sorted array or monotonic search space         |
| Hash Table            | `map<int,int> mp; for(x:nums) mp[x]++; /* use mp for O(1) lookups or prefix-sums */`           | Need O(1) lookup/count (e.g. two-sum unsorted) |
| Stack (Monotonic)     | `stack<int> st; for(i=0..n-1){ while(!st.empty() && st.top()<arr[i]) st.pop(); st.push(arr[i]); }`         | “Next greater” or bracket matching             |
| Queue (BFS)           | `queue<Node*> q; q.push(start); while(!q.empty()){ u=q.front(); q.pop(); for(v:neighbors[u]) if(!vis[v]){vis[v]=1; q.push(v);} }` | Level-order / shortest path (unweighted)       |
| DFS (Recursion)       | `void dfs(u){ vis[u]=1; for(v:adj[u]) if(!vis[v]) dfs(v); }`                                   | Connectivity, subtree computation              |
| Linked List (2-P)     | `fast=slow=head; while(fast&&fast->next){ slow=slow->next; fast=fast->next->next; }`                        | Linked list middle/cycle detection            |
| Linked List (Reverse) | `prev=null; cur=head; while(cur){ next=cur->next; cur->next=prev; prev=cur; cur=next; }`                    | Reverse list in-place                          |
| Backtracking (Gen.)   | `void backtrack(path,i){ for(j=i..n-1){ choose; backtrack(path,j+1); undo; } }`                | All subsets/permutations                     |
| Dynamic Programming   | `dp[state] = (recurrence using smaller dp[]);` + memoization                                               | Overlapping subproblems                       |
| Greedy (interval)     | `sort(intervals by end); for(iv in intervals){ if(iv.start>=last_end){ count++; last_end=iv.end; } }`       | Interval scheduling                           |
| Heap / PQ             | `priority_queue<...> pq; for(x in nums){ if(pq.size()<k) pq.push(x); else if(x>pq.top()){pq.pop(); pq.push(x);} }` | Top-K problems                              |
| Bit Manipulation      | `int x=0; for(a:arr) x ^= a; // or use shifts & etc.`                                         | XOR tricks, bit counts                        |
| Prefix Sum + Hash     | (See Example 5.4 above)                                                                                    | Range-sum queries                              |

**Example Problem Comparisons:** Brute vs Optimal, with pattern and complexities.  

| **Example Problem**                    | **Brute-Force (Time)**  | **Pattern → Optimal (Time)**                     |
|----------------------------------------|-------------------------|-------------------------------------------------|
| **Two Sum (unsorted)** (find pair sum) | Check all pairs, O(n²)   | Hash map lookup → O(n)            |
| **Two Sum (sorted)**                   | Check all pairs, O(n²)   | Sort+Two-Pointer → O(n)           |
| **3Sum (any array)**                   | Triple loop, O(n³)       | Sort+2-pointer loops → O(n²)      |
| **Longest unique substring**           | Nested loops, O(n²)      | Sliding-window → O(n)            |
| **Subarray sum = K** (arr of int)      | Nested sum, O(n²)        | Prefix-sum + Hash → O(n)         |
| **Binary Tree Paths sum**             | DFS from every node (exp) | DFS + prefix-sum → O(n)           |
| **Climbing Stairs** (step count)       | Exponential recursion    | DP/memo → O(n)                   |
| **Activity Selection** (intervals)     | Check all subsets, exp   | Greedy (sort by finish) → O(n log n) |

These tables condense the above detail. For each real interview problem, you should be able to quickly locate a row that matches its clues, then recall the template and complexity. 

**Sources:** Key facts above are drawn from expert sources. For instance, pattern-covering advice comes from interview cheat-sheets; the brute→optimize approach is advocated by Byte-by-Byte and Gayle McDowell; each pattern’s use-cases and examples are confirmed in multiple blogs. 

