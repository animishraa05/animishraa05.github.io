---
title: "Subsets"
link: "https://leetcode.com/problems/subsets/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The task is to find the power set (all possible subsets) of an array of **unique** integers. 

**Why Backtracking?**
Generating subsets requires exploring all possible combinations of elements. For each element in the array, we face a binary choice: **include** the element in the current subset, or **exclude** it. Backtracking allows us to elegantly traverse this decision tree, exploring a path (inclusion) and then backtracking to explore the alternative (exclusion).

**Alternative approach:**
This problem can also be solved using Cascading (iteratively adding new elements to existing subsets) or Bit Manipulation (using the binary representation of numbers from $0$ to $2^n-1$ as inclusion/exclusion masks). Backtracking is generally the most intuitive for interviewing.

**Specific questions to practice:**
- Subsets II (handling duplicates)
- Combinations
- Letter Combinations of a Phone Number

## Code

### Brute-Force / Iterative Cascading
*Pseudocode logic:*
1. Start with an empty subset: `res = [[]]`.
2. For each number `num` in `nums`:
   - Take all existing subsets in `res`.
   - Append `num` to each of them to create new subsets.
   - Add these new subsets back into `res`.
*(This is functionally optimal in time, but backtracking is a better pattern to master).*

### Optimal Approach (Backtracking / DFS)
We build subsets incrementally.
*Pseudocode logic:*
1. Create a `res` vector of vectors.
2. Define a `backtrack` function taking the `start_index` and the `path` (current subset).
3. At every call, append `path` to `res` (every node in our decision tree is a valid subset).
4. Iterate `i` from `start_index` to `nums.size() - 1`:
   - Append `nums[i]` to `path`.
   - Recursively call `backtrack(i + 1, path)`.
   - Backtrack by popping `nums[i]` from `path`.

```cpp
class Solution {
private:
    void backtrack(int startIndex, std::vector<int>& path, const std::vector<int>& nums, std::vector<std::vector<int>>& res) {
        // Every time the function is called, the current path is a valid subset
        res.push_back(path);
        
        // Iterate through remaining elements to generate longer subsets
        for (int i = startIndex; i < nums.size(); ++i) {
            // Choose the element
            path.push_back(nums[i]);
            
            // Explore further (move to the next index)
            backtrack(i + 1, path, nums, res);
            
            // Undo the choice (backtrack)
            path.pop_back();
        }
    }

public:
    std::vector<std::vector<int>> subsets(std::vector<int>& nums) {
        std::vector<std::vector<int>> res;
        std::vector<int> path;
        
        // Start backtracking from index 0 with an empty path
        backtrack(0, path, nums, res);
        
        return res;
    }
};
```

## Complexity
- **Time Complexity:** $O(n \cdot 2^n)$
  - An array of size $n$ has exactly $2^n$ subsets. For each subset, we append it to our result list, which takes $O(n)$ time to copy the array. Thus, time is dominated by this subset generation and copying.
- **Space Complexity:** $O(n)$
  - The recursion stack can grow up to $n$ frames deep. The `path` vector also takes $O(n)$ space. (We do not count the output list `res` in space complexity, which would be $O(n \cdot 2^n)$).

## Edge Cases
- **Empty Array:** `nums = []`. The loop won't execute, and the empty subset is added. Output: `[[]]`. Correct.
- **Single Element:** `nums = [1]`. The tree goes one level deep. Output: `[[], [1]]`. Correct.

## Notes
- **Mental Model:** Think of the decision tree. At the root is `[]`. The branches represent choosing the next element. 
  - Root: `[]`
  - Choose 1: `[1]`
    - Choose 2: `[1, 2]`
      - Choose 3: `[1, 2, 3]`
    - Choose 3: `[1, 3]`
  - Choose 2: `[2]`
    - Choose 3: `[2, 3]`
  - Choose 3: `[3]`
Notice how we only ever choose elements that come *after* the current element in the original array (`i + 1`). This prevents generating permutations (like `[2, 1]`) and only generates combinations/subsets.
- **Recognition:** "Find all possible..." implies DFS/Backtracking. The specific structure of appending to `res` blindly (without checking a base case length) is unique to Subsets, because *every* node in the tree is a valid answer, not just the leaf nodes.
