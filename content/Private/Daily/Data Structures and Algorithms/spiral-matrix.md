---
title: "Spiral Matrix"
link: "https://leetcode.com/problems/spiral-matrix/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The core strategy here is **Layer-by-Layer Boundary Traversal**. We can think of the matrix as a series of concentric rectangles (or spirals). The idea is to maintain four pointers that define the current boundaries of our traversal: `top`, `bottom`, `left`, and `right`. 

Why this pattern? Because a spiral goes in a specific sequence of directions: Right -> Down -> Left -> Up. By peeling off the outermost layer completely, the remaining inner elements form a smaller sub-matrix. We just repeat the same Right-Down-Left-Up process on the new sub-matrix by bringing our boundaries inward.

1. **Right**: Traverse from `left` to `right` along the `top` row. Once done, increment `top` to peel off that row.
2. **Down**: Traverse from `top` to `bottom` along the `right` column. Once done, decrement `right` to peel off that column.
3. **Left**: Traverse from `right` to `left` along the `bottom` row. Once done, decrement `bottom`.
4. **Up**: Traverse from `bottom` to `top` along the `left` column. Once done, increment `left`.

We must ensure that after going Right and Down, we check if we still have a valid row or column left before going Left or Up. Otherwise, in non-square matrices, we might duplicate entries.

## Code

### Brute Force / Simulation Approach
The brute-force way is to literally simulate the path. We use a visited matrix of the same size to keep track of where we've been, and an array of direction vectors. We move in the current direction until we hit the edge of the matrix or a visited cell, at which point we turn 90 degrees clockwise.

**Pseudocode (Simulation):**
```text
directions = [(0,1), (1,0), (0,-1), (-1,0)]
visited = boolean matrix
r, c = 0, 0
di = 0
for i from 0 to m*n - 1:
    add matrix[r][c] to result
    visited[r][c] = true
    next_r = r + directions[di][0]
    next_c = c + directions[di][1]
    if next_r, next_c out of bounds OR visited[next_r][next_c]:
        di = (di + 1) % 4
        next_r = r + directions[di][0]
        next_c = c + directions[di][1]
    r, c = next_r, next_c
```

### Optimal Approach (Boundary Pointers)
We eliminate the O(M*N) extra space by strictly maintaining boundary pointers.

**Pseudocode (Optimal):**
```text
top = 0, bottom = m - 1
left = 0, right = n - 1
while top <= bottom and left <= right:
    # Go Right
    for col from left to right:
        add matrix[top][col]
    top += 1
    
    # Go Down
    for row from top to bottom:
        add matrix[row][right]
    right -= 1
    
    if top <= bottom:
        # Go Left
        for col from right down to left:
            add matrix[bottom][col]
        bottom -= 1
        
    if left <= right:
        # Go Up
        for row from bottom down to top:
            add matrix[row][left]
        left += 1
```

**C++ Code:**
```cpp
#include <vector>

class Solution {
public:
    std::vector<int> spiralOrder(std::vector<std::vector<int>>& matrix) {
        if (matrix.empty()) return {};
        
        std::vector<int> result;
        int top = 0, bottom = matrix.size() - 1;
        int left = 0, right = matrix[0].size() - 1;
        
        while (top <= bottom && left <= right) {
            for (int i = left; i <= right; ++i)
                result.push_back(matrix[top][i]);
            top++;
            
            for (int i = top; i <= bottom; ++i)
                result.push_back(matrix[i][right]);
            right--;
            
            if (top <= bottom) {
                for (int i = right; i >= left; --i)
                    result.push_back(matrix[bottom][i]);
                bottom--;
            }
                
            if (left <= right) {
                for (int i = bottom; i >= top; --i)
                    result.push_back(matrix[i][left]);
                left++;
            }
        }
        
        return result;
    }
};
```

## Complexity
- **Time Complexity:** $O(M \times N)$ where M is the number of rows and N is the number of columns. We visit exactly every element in the matrix once. No redundant visits.
- **Space Complexity:** $O(1)$ auxiliary space. We only use 4 pointers and a few variables. The output array `result` takes $O(M \times N)$ space, but this is typically not counted in auxiliary space complexity since it's the required format for the answer. 

## Edge Cases
1. **Empty Matrix (`[]`):** Handled with `if not matrix: return []`.
2. **Single Row (`[[1, 2, 3]]`):** The code traverses right. `top` becomes 1. The `top <= bottom` check fails before moving Left, preventing duplicates!
3. **Single Column (`[[1], [2], [3]]`):** Traverses right (just one element), goes down. `right` shrinks. The `left <= right` check prevents moving Up! 
4. **1x1 Matrix (`[[1]]`):** Processed correctly, pointers cross immediately.

## Notes
- **Mental Model:** Visualize peeling an onion layer by layer. The outer ring gets shaved off by shifting the respective `top`, `bottom`, `left`, `right` variable inwards. 
- **Key Trap:** The most common mistake is forgetting the `if top <= bottom:` and `if left <= right:` checks before the final two loops in the while block. When the remaining matrix is a 1D row or column, going Left or Up will incorrectly re-traverse the same elements backwards if you don't check whether the boundaries have crossed.
- **Recognition:** You can apply a similar 4-pointer boundary logic for problems like *Spiral Matrix II* (where you build the matrix) or *Rotate Image* (layer-by-layer modification).
