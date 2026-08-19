---
title: "Candy"
link: "https://leetcode.com/problems/candy/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use a two-pass greedy algorithm. First, give every child 1 candy. Then make a left-to-right pass, giving more candies to a child if their rating is higher than their left neighbor. Then make a right-to-left pass, ensuring a child gets more candies if their rating is higher than their right neighbor (taking the max of current candies and right neighbor's candies + 1).

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: 
// Keep iterating and fixing violations until no violations exist. Time Limit Exceeded on large inputs.

class Solution {
public:
    int candy(vector<int>& ratings) {
        int n = ratings.size();
        vector<int> candies(n, 1);
        bool has_changed = true;
        while (has_changed) {
            has_changed = false;
            for (int i = 0; i < n; i++) {
                if (i > 0 && ratings[i] > ratings[i-1] && candies[i] <= candies[i-1]) {
                    candies[i] = candies[i-1] + 1;
                    has_changed = true;
                }
                if (i < n - 1 && ratings[i] > ratings[i+1] && candies[i] <= candies[i+1]) {
                    candies[i] = candies[i+1] + 1;
                    has_changed = true;
                }
            }
        }
        int total = 0;
        for (int c : candies) total += c;
        return total;
    }
};
```

### Optimal Approach (Two Passes)
```cpp
// Pseudocode: 
// 1. Create a candies array initialized to 1 for all children.
// 2. Left-to-right pass: if ratings[i] > ratings[i-1], candies[i] = candies[i-1] + 1.
// 3. Right-to-left pass: if ratings[i] > ratings[i+1], candies[i] = max(candies[i], candies[i+1] + 1).
// 4. Return sum(candies).

class Solution {
public:
    int candy(vector<int>& ratings) {
        int n = ratings.size();
        vector<int> candies(n, 1);
        
        for (int i = 1; i < n; i++) {
            if (ratings[i] > ratings[i-1]) {
                candies[i] = candies[i-1] + 1;
            }
        }
                
        for (int i = n - 2; i >= 0; i--) {
            if (ratings[i] > ratings[i+1]) {
                candies[i] = max(candies[i], candies[i+1] + 1);
            }
        }
                
        int total = 0;
        for (int c : candies) total += c;
        return total;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(n) because we do two linear passes. Space: O(n) for the candies array.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. All same ratings. Handled correctly, everyone gets 1 candy.
2. Descending sequence. Handled by the right-to-left pass.

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
This pattern of separating constraints into a left-to-right check and a right-to-left check is very common in array problems where elements depend on both neighbors.
