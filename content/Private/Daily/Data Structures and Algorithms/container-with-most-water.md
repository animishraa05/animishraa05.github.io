---
title: "Container With Most Water"
link: "https://leetcode.com/problems/container-with-most-water/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We need to find two lines that, together with the x-axis, form a container that holds the most water. The area is limited by the shorter line and the distance between them.
**Pattern:** Two Pointers.

The brute force way is to check all possible pairs of lines. This takes $O(N^2)$ time, which is too slow.

To optimize, we can use the **Two Pointers** technique, starting from the outermost lines (the widest possible container). The area is calculated as `min(height[left], height[right]) * (right - left)`. 
Since moving pointers inwards always decreases the width (`right - left`), the only way to possibly get a larger area is to move the pointer pointing to the *shorter* line, hoping to find a taller line that compensates for the lost width. 
Moving the taller line would guarantee a smaller or equal area because the height is bounded by the shorter line.

## Code

### Brute-Force Approach
Pseudocode:
1. Initialize `max_area = 0`.
2. Loop `i` from 0 to n-1.
3. Loop `j` from `i+1` to n-1.
4. Calculate area: `min(height[i], height[j]) * (j - i)`.
5. Update `max_area` if this area is larger.

```cpp
class Solution {
public:
    int maxArea(vector<int>& height) {
        int max_area = 0;
        int n = height.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int area = min(height[i], height[j]) * (j - i);
                max_area = max(max_area, area);
            }
        }
        return max_area;
    }
};
```

### Optimal Approach
Pseudocode:
1. Initialize two pointers: `left = 0`, `right = height.size() - 1`.
2. Initialize `max_area = 0`.
3. Loop while `left < right`:
   - Calculate `current_area = min(height[left], height[right]) * (right - left)`.
   - Update `max_area = max(max_area, current_area)`.
   - If `height[left] < height[right]`, increment `left`.
   - Else, decrement `right`.
4. Return `max_area`.

```cpp
class Solution {
public:
    int maxArea(vector<int>& height) {
        int left = 0;
        int right = height.size() - 1;
        int max_area = 0;
        
        while (left < right) {
            // The height of the container is limited by the shorter line
            int h = min(height[left], height[right]);
            int w = right - left;
            max_area = max(max_area, h * w);
            
            // Move the pointer pointing to the shorter line
            if (height[left] < height[right]) {
                left++;
            } else {
                right--;
            }
        }
                
        return max_area;
    }
};
```

## Complexity
- **Brute Force:**
  - Time: $O(N^2)$ due to the nested loops checking every possible pair.
  - Space: $O(1)$ since we only use a few variables.
- **Optimal (Two Pointers):**
  - Time: $O(N)$ where $N$ is the number of lines. We process each element at most once using the two pointers.
  - Space: $O(1)$. No extra data structures are used.

## Edge Cases
- **Lines of equal height:** The logic `else { right--; }` naturally handles this. If they are equal, moving either pointer is fine. Moving both is also valid, but moving one works perfectly and simplifies the code.
- **Array with exactly two elements:** The minimum required input size is 2, and the algorithm will accurately compute the single possible area and terminate.
- **Heights of zero:** E.g., `[0, 2]`. The `min(0, 2) * 1` evaluates to 0, which is correct as a container with 0 height can hold no water.

## Notes
**Thought Process & Recognition:** 
This is a classic greedy two-pointer problem. 
How to recognize? You need to maximize an area (or some product) dependent on two elements at a distance. You start with the maximum distance, then greedily move the constraint (the shorter height) inward to hunt for a better answer. 

**Mental Model:** Imagine a physical container. The water spills over the shorter edge. To hold more water, you *must* increase the height of the shorter edge, even if it means bringing the edges closer together. Bringing the taller edge inward can never help, because the water level is still constrained by the shorter edge, but the width is now strictly smaller.
