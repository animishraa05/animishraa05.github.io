---
title: "Rotate Image"
link: "https://leetcode.com/problems/rotate-image/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We need to rotate an $N \times N$ 2D matrix by 90 degrees clockwise, *in-place*. 

There are two primary ways to do this mathematically/geometrically:
1. **Transpose + Reverse Rows (The most elegant and easiest to remember)**
   - First, transpose the matrix. Transposing means swapping `matrix[i][j]` with `matrix[j][i]`. It flips the matrix over its main diagonal.
   - Second, reverse each row. Flipping it horizontally gives us the 90-degree clockwise rotation.
   - Why does this work? A transpose turns rows into columns (but going top-to-bottom instead of bottom-to-top as we need). Reversing the rows corrects this order. 

2. **Layer-by-Layer 4-Way Swap**
   - Similar to "Spiral Matrix", we process the matrix layer by layer (outermost ring, then the next inner ring, etc.).
   - For each element in the top row of a layer, we perform a 4-way swap. We move the top element to the right, the right to the bottom, the bottom to the left, and the left to the top.

We will focus on the **Transpose + Reverse** approach for the optimal code as it is dramatically simpler to write bug-free in an interview, but I'll provide both concepts.

## Code

### Brute Force (Out of Place)
The most naive approach is to create a new matrix. The first row of the original matrix becomes the last column of the new matrix. 
**Pseudocode:**
```text
new_matrix = empty N x N
for r from 0 to N-1:
    for c from 0 to N-1:
        new_matrix[c][N - 1 - r] = matrix[r][c]
copy new_matrix back to matrix
```
But the problem strictly requires an *in-place* solution, making this invalid.

### Optimal Approach (Transpose + Reverse)

**Pseudocode:**
```text
# 1. Transpose
for i from 0 to N-1:
    for j from i to N-1:
        swap(matrix[i][j], matrix[j][i])

# 2. Reverse each row
for i from 0 to N-1:
    reverse(matrix[i])
```

**C++ Code:**
```cpp
#include <vector>
#include <algorithm>

class Solution {
public:
    void rotate(std::vector<std::vector<int>>& matrix) {
        int n = matrix.size();
        
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                std::swap(matrix[i][j], matrix[j][i]);
            }
        }
        
        for (int i = 0; i < n; ++i) {
            std::reverse(matrix[i].begin(), matrix[i].end());
        }
    }
};
```

### Alternative Optimal (Layer-by-layer 4-way swap)
```cpp
#include <vector>

class Solution {
public:
    void rotate(std::vector<std::vector<int>>& matrix) {
        int left = 0, right = matrix.size() - 1;
        
        while (left < right) {
            for (int i = 0; i < right - left; ++i) {
                int top = left, bottom = right;
                
                int top_left = matrix[top][left + i];
                
                matrix[top][left + i] = matrix[bottom - i][left];
                matrix[bottom - i][left] = matrix[bottom][right - i];
                matrix[bottom][right - i] = matrix[top + i][right];
                matrix[top + i][right] = top_left;
            }
            right--;
            left++;
        }
    }
};
```

## Complexity
- **Time Complexity:** $O(N^2)$ where $N$ is the number of rows/columns. Both the transpose and the reverse steps visit each cell in the matrix.
- **Space Complexity:** $O(1)$. We do everything perfectly in-place with no extra data structures. 

## Edge Cases
1. **1x1 Matrix:** $N=1$. The transpose loop doesn't do anything, reverse doesn't change anything. Correctly left alone.
2. **Even vs Odd dimensions:** Both approaches handle odd and even $N$ flawlessly. The middle element in an odd matrix stays exactly in place during a 90-degree rotation, which transpose + reverse naturally preserves.

## Notes
- **Mental Model:** Think of standard image manipulation tools. Flipping across the diagonal then flipping horizontally creates a 90-degree clockwise rotation.
- **Follow-up:** How do you rotate 90 degrees *counter-clockwise*?
  - Reverse each row FIRST, then Transpose.
  - OR Transpose FIRST, then reverse each column. 
- **Bug Alert:** In the transpose step, always ensure the inner loop starts at `j = i`. If you do `j = 0 to N-1`, you will swap `(0,1)` with `(1,0)` and then when you reach `i=1, j=0` you will swap `(1,0)` with `(0,1)` again, completely undoing your transpose!
