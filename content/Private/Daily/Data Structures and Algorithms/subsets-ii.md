---
title: "Subsets II"
link: "https://leetcode.com/problems/subsets-ii/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This problem is a classic application of the **Backtracking** pattern. We are asked to find all possible subsets (the power set) of an integer array that may contain duplicates. The crucial requirement is that the solution set must not contain duplicate subsets.

**Why Backtracking?**
Backtracking is ideal for generating all combinations, permutations, or subsets. We explore paths by including an element, then backtrack by removing it and exploring other possibilities. 

**Handling Duplicates:**
The core challenge is avoiding duplicate subsets. A simple trick to handle duplicates in combinations/subsets is:
1. **Sort the array:** This brings duplicate elements next to each other, making them easy to identify.
2. **Skip duplicates at the same level of the decision tree:** If we are at a certain position in our subset construction and we encounter an element identical to the previous one (which we just processed as an option for this position), we skip it. We only skip if it's not the first element being considered for the *current* slot.

**Specific questions to practice:**
- Subsets (without duplicates)
- Combination Sum II
- Permutations II

## Code

### Brute-Force Approach
A naive way would be to generate all possible subsets (ignoring the duplicate rule initially) and use a Set data structure to store the subsets. Since subsets like `[1, 2]` and `[2, 1]` are the same, we'd need to sort each subset before adding it to the set, or sort the initial array.
*Pseudocode logic:*
1. Sort `nums`.
2. Generate subsets using standard recursion.
3. Add each generated subset to a `std::set` to automatically filter out duplicates.
4. Convert the `std::set` back to a `std::vector` of vectors.

### Optimal Approach (Backtracking with Duplicate Skipping)
Instead of generating duplicates and filtering them, we avoid generating them entirely.

*Pseudocode logic:*
1. Sort the input array `nums`.
2. Create a `res` vector to store valid subsets.
3. Define a recursive `backtrack` function taking `start_index` and the `current_subset`.
4. Append `current_subset` to `res` at the beginning of the function call (every path is a valid subset).
5. Loop `i` from `start_index` to `nums.size() - 1`:
   - **Skip condition:** If `i > start_index` and `nums[i] == nums[i-1]`, `continue`.
   - Add `nums[i]` to `current_subset`.
   - Recurse with `i + 1`.
   - Backtrack: remove `nums[i]` from `current_subset`.

```cpp
class Solution {
private:
    void backtrack(int startIndex, std::vector<int>& currentSubset, const std::vector<int>& nums, std::vector<std::vector<int>>& res) {
        // Add the current subset to results
        // (In C++, push_back makes a copy of the vector automatically)
        res.push_back(currentSubset);
        
        // Explore further elements
        for (int i = startIndex; i < nums.size(); ++i) {
            // Step 2: Skip duplicates
            // We only skip if it's not the first element of the current recursive level
            if (i > startIndex && nums[i] == nums[i - 1]) {
                continue;
            }
            
            // Step 3: Include the element and move forward
            currentSubset.push_back(nums[i]);
            backtrack(i + 1, currentSubset, nums, res);
            
            // Step 4: Backtrack
            currentSubset.pop_back();
        }
    }

public:
    std::vector<std::vector<int>> subsetsWithDup(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end()); // Step 1: Sort to group duplicates
        std::vector<std::vector<int>> res;
        std::vector<int> currentSubset;
        
        backtrack(0, currentSubset, nums, res);
        
        return res;
    }
};
```

## Complexity
- **Time Complexity:** $O(n \cdot 2^n)$
  - Sorting takes $O(n \log n)$.
  - There are in the worst case (all unique elements) $2^n$ subsets. For each subset, we copy it into the result array. The max length of a subset is $n$, so copying takes $O(n)$. Therefore, the time complexity is bounded by $O(n \cdot 2^n)$.
- **Space Complexity:** $O(n)$
  - The recursion stack can go as deep as $n$. 
  - The `current_subset` vector takes $O(n)$ space.
  - (Excluding the output array which takes $O(n \cdot 2^n)$ space).

## Edge Cases
- **Empty Array:** `nums = []`. The output should be `[[]]`. Handled correctly as the `for` loop won't execute, and the empty `current_subset` is added.
- **All Duplicates:** `nums = [2, 2, 2]`. The output should be `[[], [2], [2,2], [2,2,2]]`. The duplicate skipping logic perfectly trims the tree to only one branch of varying depths.

## Notes
- **Mental Model:** Picture a decision tree. At level 1, you decide the first element of the subset. At level 2, the second element. When deciding the `k`-th element, you loop over available choices. If two choices are identical (e.g., you can pick the first '2' or the second '2'), picking the second '2' will just spawn a subtree identical to the one spawned by the first '2'. Sorting places identical elements adjacent to each other. By simply checking `nums[i] == nums[i-1]`, we prevent expanding redundant subtrees.
- **Recognition:** "All possible combinations/subsets/permutations" + "may contain duplicates" + "must not contain duplicate results" = Backtracking + Sorting + Skip Duplicates (`if (i > start && nums[i] == nums[i-1]) continue;`).
