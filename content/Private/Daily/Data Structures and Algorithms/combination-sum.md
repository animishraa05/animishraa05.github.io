---
title: "Combination Sum"
link: "https://leetcode.com/problems/combination-sum/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This problem asks us to find all unique combinations in `candidates` where the candidate numbers sum to `target`. 
Crucially:
1. The same number may be chosen from `candidates` an **unlimited number of times**.
2. All numbers are **distinct** positive integers.

This implies a **Backtracking / Depth First Search (DFS)** pattern. Since we can reuse numbers, at any point in our decision tree, we have two primary choices for the current candidate element:
1. Include the current element in our path, subtract it from the target, and stay at the *same* index (to potentially reuse it).
2. Do not include the current element, and move on to the *next* index.

Alternatively, we can use a standard `for` loop starting from the `current_index` to iterate through candidates. Because we can reuse the same element, the recursive call will pass `i` instead of `i + 1`.

## Code

### Optimal Approach (Backtracking)
**Pseudocode:**
```text
res = []
function backtrack(start_index, current_target, path):
    if current_target == 0:
        res.push_back(path)
        return
    if current_target < 0:
        return
        
    for i from start_index to len(candidates) - 1:
        path.append(candidates[i])
        # Pass 'i' instead of 'i+1' to allow reusing candidates[i]
        backtrack(i, current_target - candidates[i], path)
        path.pop()

backtrack(0, target, [])
return res
```

**C++ Code:**
```cpp
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> combinationSum(std::vector<int>& candidates, int target) {
        std::vector<std::vector<int>> res;
        std::vector<int> path;
        std::sort(candidates.begin(), candidates.end());
        
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
            if (candidates[i] > target) break;
            
            path.push_back(candidates[i]);
            backtrack(candidates, target - candidates[i], i, path, res);
            path.pop_back();
        }
    }
};
```

## Complexity
- **Time Complexity:** $O(2^T)$, where $T$ is the target value. The time complexity of backtracking problems with unlimited repetition is notoriously difficult to bound exactly. In the worst case, if the minimum element is 1, the maximum depth of the tree is $T$. Every node can branch out. 
- **Space Complexity:** $O(T)$ in the worst case for the recursion call stack (again, if the smallest candidate is 1 and the target is $T$, the depth of the recursion tree is $T$). The auxiliary space for `path` is also $O(T)$.

## Edge Cases
1. **Target is smaller than the minimum element:** Backtracking instantly terminates since `current_target < 0` (or the pruning break triggers). Returns `[]`.
2. **Only 1 element that divides target (`[2]`, target=4):** Perfectly handles this by reusing `2` twice. `path` goes `[2] -> [2, 2] -> target hits 0`.

## Notes
- **Thought Process & Recognition:** Just like *Combination Sum II*, finding all unique combinations screams Backtracking. 
- **The Core Difference:** The ability to reuse numbers dictates how we traverse the decision tree. If we can reuse, we pass `i` to the recursive function. If we can't reuse, we pass `i + 1`. 
- **To Sort or Not To Sort?** You don't *have* to sort for this specific problem to be correct. However, sorting allows for the `if candidates[i] > current_target: break` early stopping optimization. If you don't sort, you must use `continue` instead of `break`, or a base case `if current_target < 0: return` at the top of the function. Sorting often makes your backtracking solutions run dramatically faster in practice.
