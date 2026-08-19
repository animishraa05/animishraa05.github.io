---
title: "Kth Missing Positive Number"
link: "https://leetcode.com/problems/kth-missing-positive-number/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We are given a strictly increasing array of positive integers and need to find the `k`-th missing positive integer. 

The brute-force approach iterates through the array elements and computes missing numbers linearly. This is $O(N)$.
Since the array is sorted, we can use **Binary Search** for an optimal $O(\log N)$ solution.
For any index `i`, if no elements were missing, `arr[i]` should be `i + 1`. 
The number of missing elements *before* index `i` is exactly `arr[i] - (i + 1)`.
Using Binary Search, we want to find the first index `i` where the count of missing numbers is greater than or equal to `k`. Once we find the correct bounds, the answer will be `k + left`.

## Code
### Brute Force
```cpp
// Pseudocode:
// For each num in arr:
//   if num <= k: k++
//   else: break
// Return k

#include <vector>

using namespace std;

class Solution {
public:
    int findKthPositive_brute(vector<int>& arr, int k) {
        for (int num : arr) {
            if (num <= k) {
                k++;
            } else {
                break;
            }
        }
        return k;
    }
};
```

### Optimal Approach (Binary Search)
```cpp
// Pseudocode:
// left = 0, right = len(arr) - 1
// While left <= right:
//   mid = left + (right - left) / 2
//   missing = arr[mid] - (mid + 1)
//   if missing < k:
//     left = mid + 1
//   else:
//     right = mid - 1
// return left + k

#include <vector>

using namespace std;

class Solution {
public:
    int findKthPositive(vector<int>& arr, int k) {
        int left = 0, right = arr.size() - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            // Calculate how many numbers are missing before arr[mid]
            int missing_before_mid = arr[mid] - (mid + 1);
            
            if (missing_before_mid < k) {
                // We haven't found k missing numbers yet, search right
                left = mid + 1;
            } else {
                // We found k or more, but we want the *first* occurrence, search left
                right = mid - 1;
            }
        }
        
        // At the end of the loop, left > right.
        // The answer lies between arr[right] and arr[left]
        // Answer = arr[right] + (k - missing_before_right)
        // Since missing_before_right = arr[right] - (right + 1),
        // Answer = arr[right] + k - (arr[right] - (right + 1)) = k + right + 1
        // Since left = right + 1, Answer = k + left.
        return left + k;
    }
};
```

## Complexity
- **Time Complexity:** $O(\log N)$ because we cut the search space in half at each step of the binary search.
- **Space Complexity:** $O(1)$ as we only use pointers.

## Edge Cases
1. `k` is smaller than the first element: e.g., `arr = [4, 5, 6], k = 2`. The loop quickly exits with `left = 0`. Returns `k + 0 = 2`, which is correct.
2. `k` is beyond the last missing number in the array: e.g., `arr = [2, 3, 4], k = 5`. `left` will move out of bounds to `arr.size()`. Returns `3 + 5 = 8`.

## Notes
- **Thought Process & Recognition:** Recognizing Binary Search here is tricky because we are not explicitly searching for a number in the array. Instead, we are binary searching over the *index* based on a calculated metric: `missing_count`. The fact that `missing_count = arr[i] - (i + 1)` is monotonically increasing allows binary search to work perfectly.
- **Mental Model:** Instead of thinking about the numbers themselves, look at the gap between the expected number and the actual number. If `arr = [2,3,4,7,11]`, expected is `[1,2,3,4,5]`. The differences are `[1,1,1,3,6]`. Since the differences array is sorted, you can binary search on it.
