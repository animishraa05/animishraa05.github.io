---
title: "Gas Station"
link: "https://leetcode.com/problems/gas-station/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
<!-- Strategy. What pattern/technique applies and why? Deeply break down the underlying pattern or logic. Explain the "why" behind every choice made in the pattern so I can easily recognize and reproduce it in newer problems. Suggest specific questions to practice and strengthen this exact pattern. -->
We can use a greedy approach. If the total gas available is less than total cost, it's impossible, return -1. Otherwise, a valid starting station must exist. We can track the current gas as we iterate. If it drops below 0, it means the current starting point is invalid, and no station before the current station can be a valid starting point either. We reset our starting point to the next station and reset current gas to 0.

## Code
<!-- Your solution. Language of choice (C++ preferred).
Always explain the brute-force approach first, followed by the optimal approach. For both, write out the step-by-step pseudocode logic before the actual code.
-->
### Brute Force
```cpp
// Pseudocode: Try starting from every single station.
// 1. Loop i from 0 to n-1.
// 2. Simulate the journey. If we complete the circle, return i.
// 3. Return -1.

class Solution {
public:
    int canCompleteCircuit(vector<int>& gas, vector<int>& cost) {
        int n = gas.size();
        for (int i = 0; i < n; i++) {
            int total = 0;
            bool possible = true;
            for (int j = 0; j < n; j++) {
                int idx = (i + j) % n;
                total += gas[idx] - cost[idx];
                if (total < 0) {
                    possible = false;
                    break;
                }
            }
            if (possible) {
                return i;
            }
        }
        return -1;
    }
};
```

### Optimal Approach
```cpp
// Pseudocode: 
// 1. If sum(gas) < sum(cost), return -1.
// 2. Init total = 0, start = 0.
// 3. Loop i from 0 to n-1:
// 4.   total += gas[i] - cost[i]
// 5.   if total < 0:
// 6.     total = 0
// 7.     start = i + 1
// 8. Return start.

class Solution {
public:
    int canCompleteCircuit(vector<int>& gas, vector<int>& cost) {
        int totalGas = 0, totalCost = 0;
        for(int g : gas) totalGas += g;
        for(int c : cost) totalCost += c;
        if (totalGas < totalCost) return -1;
        
        int total = 0;
        int start = 0;
        for (int i = 0; i < gas.size(); i++) {
            total += gas[i] - cost[i];
            if (total < 0) {
                total = 0;
                start = i + 1;
            }
        }
        return start;
    }
};
```

## Complexity
<!-- Time: O(...) Space: O(...) and justification. Thoroughly analyze the time and space complexity for all approaches using simple, easy-to-understand language. -->
Time: O(n) for a single pass (sum also takes O(n)). Space: O(1).

## Edge Cases
<!-- Inputs that break the naive solution. Talk extensively about edge cases—what they are, why they break the naive solution, and how the optimal code handles them. -->
1. Disconnected valid sequences. The logic holds because we check the global sum first. If the global sum is >= 0, the last chosen start will successfully complete the loop.

## Notes
<!-- Thought Process & Recognition: Explain the exact train of thought and mental model required while solving it. How do I recognize this specific tag/logic when I see it? Frame it in general terms so the entire topic becomes easier for me. Provide a lot of concrete examples for easier explanation. If helpful, fetch and embed relevant images or diagrams from the web that relate to the solution. -->
The key insight is that if you can't reach station B from station A, you also can't reach station B from any station between A and B. Thus, the next valid start point to try is B+1.
