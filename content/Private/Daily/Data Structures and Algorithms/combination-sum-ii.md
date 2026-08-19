---
title: "Combination Sum II"
link: "https://leetcode.com/problems/combination-sum-ii/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This problem asks us to find all unique combinations in `candidates` that sum up to `target`. 
Crucially:
1. Each number in `candidates` may only be used **once** in the combination.
2. The solution set must not contain **duplicate combinations**.

This implies a **Backtracking / Depth First Search (DFS)** pattern. Because we cannot have duplicate combinations (e.g., if `candidates = [1, 1, 2]`, `target = 3`, the combination `[1, 2]` using the first '1' is the same as `[1, 2]` using the second '1'), we must sort the array first. 

Sorting does two massive things for us:
1. It puts duplicate numbers next to each other, allowing us to easily skip them and avoid duplicate subsets.
2. It allows us to early-terminate (prune) our search tree if the current number exceeds the remaining target.

**The Skipping Logic:**
Inside our backtrack loop, we iterate through the choices. If `i > current_index` (meaning it's not the first element being picked at this level of the recursion tree) AND `candidates[i] == candidates[i-1]`, we `continue` and skip it. This prevents branching off a duplicate sibling in the recursion tree.

## Code

### Backtracking (Optimal)
**Pseudocode:**
```text
Sort(candidates)
res = []

function backtrack(start_index, current_target, path):
    if current_target == 0:
        res.append(path)
        return
        
    for i from start_index to len(candidates) - 1:
        if i > start_index and candidates[i] == candidates[i-1]:
            continue # Skip duplicates
            
        if candidates[i] > current_target:
            break # Pruning: array is sorted, so subsequent numbers will also be too large
            
        path.append(candidates[i])
        backtrack(i + 1, current_target - candidates[i], path)
        path.pop() # Backtrack

backtrack(0, target, [])
return res
```

**C++ Code:**
```cpp
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> combinationSum2(std::vector<int>& candidates, int target) {
        std::sort(candidates.begin(), candidates.end());
        std::vector<std::vector<int>> res;
        std::vector<int> path;
        
        backtrack(candidates, target, 0, path, res);
        return res;
    }
    
private:
    void backtrack(const std::vector<int>& candidates, int target, int start, std::vector<int>& path, std::vector<std::vector<int>>& res) {
        if (target == 0) {
            res.push_back(path);
            return;
        }
        
        for (int i = start; i < candidates.size(); ++i) {
            if (i > start && candidates[i] == candidates[i - 1]) continue;
            if (candidates[i] > target) break;
            
            path.push_back(candidates[i]);
            backtrack(candidates, target - candidates[i], i + 1, path, res);
            path.pop_back();
        }
    }
};
```

## Complexity
- **Time Complexity:** $O(2^N)$ in the absolute worst-case where all numbers are distinct and every subset is valid. However, sorting takes $O(N \log N)$, and our duplicate-skipping and early-pruning drastically reduce the actual number of nodes visited.
- **Space Complexity:** $O(N)$ for the recursion call stack and the `path` array. The output array `res` is not typically counted in auxiliary space complexity. 

## Edge Cases
1. **Target is smaller than the smallest element:** Because of the sort and the `candidates[i] > target` check, the loop breaks instantly. Returns `[]`.
2. **All Duplicates (`[2, 2, 2, 2]`, target=4):** The tree correctly explores using the first two 2s to get `[2, 2]`. When trying to use the second 2 as the *first* element of a new combination, the `i > start and ...` check skips it, perfectly preventing duplicate `[2, 2]` lists.

## Notes
- **Thought Process & Recognition:** Whenever a problem asks for "all possible combinations/subsets/permutations", it's Backtracking. 
- **Combination Sum I vs II:**
  - In *Combination Sum I*, we can reuse numbers. Thus, we recurse with `backtrack(i, ...)` (passing `i` instead of `i+1`).
  - In *Combination Sum II*, we cannot reuse the element itself, so we recurse with `backtrack(i+1, ...)`.
  - In *Combination Sum I*, the array has distinct integers. In *Combination Sum II*, the array has duplicates, necessitating the `candidates.sort()` and `continue` skipping logic.
- **Copying the Path:** In C++, pushing a `std::vector` into another vector automatically makes a copy, which avoids mutating the stored paths when you backtrack. In other languages (like Python with `path[:]` or Java with `new ArrayList<>(path)`), you might need to explicitly duplicate it.
