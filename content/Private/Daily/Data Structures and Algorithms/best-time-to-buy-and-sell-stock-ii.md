---
title: "Best Time to Buy and Sell Stock II"
link: "https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use a Greedy algorithm. Since we can make as many transactions as we want (but only hold one stock at a time), we can just capture every single upward price movement. If the price tomorrow is higher than today, we 'buy' today and 'sell' tomorrow.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: Use recursion/DFS to try all possible buy/sell combinations.
// Too slow, O(2^n).
```

### Optimal Approach (Greedy)
```cpp
// Pseudocode: 
// 1. Init profit = 0.
// 2. Loop i from 1 to prices.size() - 1:
// 3.   If prices[i] > prices[i-1]:
// 4.     profit += prices[i] - prices[i-1]
// 5. Return profit.

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int profit = 0;
        for (int i = 1; i < prices.size(); i++) {
            if (prices[i] > prices[i-1]) {
                profit += prices[i] - prices[i-1];
            }
        }
        return profit;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(n) for a single pass. Space: O(1) since we only use a single variable.

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. Prices are strictly decreasing. We never add to profit, returns 0.
2. Prices are strictly increasing. We capture the difference at every step, which equals `last_price - first_price`.

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
The realization here is that multiple overlapping transactions on a continuous upward trend sum up to the total difference between the start and end of that trend. A very simple greedy strategy solves this perfectly.
