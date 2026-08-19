---
title: "Pascal's Triangle"
link: "https://leetcode.com/problems/pascals-triangle/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can generate row by row iteratively. Each row starts and ends with 1. Every interior element at index `j` in row `i` is the sum of elements at index `j-1` and `j` from row `i-1`.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force / Optimal (They are the same)
```cpp
// Pseudocode: 
// 1. If numRows == 0, return [].
// 2. Init res = [[1]].
// 3. Loop for i from 1 to numRows - 1:
// 4.   Create a new row initialized with 1s of size i+1.
// 5.   Loop for j from 1 to length of new row - 1:
// 6.     row[j] = res.back()[j-1] + res.back()[j]
// 7.   Append row to res.
// 8. Return res.

class Solution {
public:
    vector<vector<int>> generate(int numRows) {
        if (numRows == 0) return {};
        vector<vector<int>> res;
        res.push_back({1});
        for (int i = 1; i < numRows; i++) {
            vector<int> prev_row = res.back();
            vector<int> new_row(i + 1, 1);
            for (int j = 1; j < i; j++) {
                new_row[j] = prev_row[j-1] + prev_row[j];
            }
            res.push_back(new_row);
        }
        return res;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(numRows^2) to generate all numbers. Space: O(numRows^2) to store the result.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. numRows = 1. Returns [[1]].

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
A simple DP or simulation problem. The key is correctly mapping the indices from the previous row to the current row. `current[j] = prev[j-1] + prev[j]`.
