---
title: "Koko Eating Bananas"
link: "https://leetcode.com/problems/koko-eating-bananas/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This problem is a classic example of the "Binary Search on Answer" pattern. 
When we see a problem asking to find a "minimum" or "maximum" value (in this case, minimum eating speed `k`) that satisfies a certain condition (eating all bananas within `h` hours), and the solution space is monotonic, binary search is the way to go.
Why monotonic? Because if Koko can eat all bananas at speed `k`, she can definitely eat them at any speed `> k`. If she cannot eat them at speed `k`, she definitely cannot eat them at any speed `< k`.

The solution space for the eating speed `k` is between `1` (minimum possible speed) and `max(piles)` (at this speed, she eats any pile in exactly 1 hour). 

We define a helper function `canEatAll(speed)` that computes the total hours required to eat all bananas at a given `speed`. If `total_hours <= h`, it's a valid speed, and we try to find a smaller one (search left). Otherwise, we need a larger speed (search right).

## Code
### Brute Force
```cpp
// Pseudocode:
// max_speed = max(piles)
// For speed from 1 to max_speed:
//   total_hours = 0
//   For pile in piles:
//       total_hours += (pile + speed - 1) / speed
//   If total_hours <= h:
//       return speed

#include <vector>
#include <algorithm>

class Solution {
public:
    int minEatingSpeed(std::vector<int>& piles, int h) {
        int max_speed = *std::max_element(piles.begin(), piles.end());
        for (int speed = 1; speed <= max_speed; ++speed) {
            long long hours = 0;
            for (int pile : piles) {
                hours += (pile + speed - 1) / speed; // Equivalent to ceil(pile / speed)
            }
            if (hours <= h) {
                return speed;
            }
        }
        return -1;
    }
};
```

### Optimal Approach
```cpp
// Pseudocode:
// low = 1, high = max(piles)
// result = high
// While low <= high:
//   mid = low + (high - low) / 2
//   total_hours = 0
//   For pile in piles:
//       total_hours += (pile + mid - 1) / mid
//   If total_hours <= h:
//       result = mid  // This is a valid speed, record it
//       high = mid - 1 // Try to find a smaller valid speed
//   Else:
//       low = mid + 1 // Speed too slow, increase it
// Return result

#include <vector>
#include <algorithm>

class Solution {
public:
    int minEatingSpeed(std::vector<int>& piles, int h) {
        int left = 1;
        int right = *std::max_element(piles.begin(), piles.end());
        int res = right;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            // Calculate total hours needed at speed 'mid'
            long long hours = 0;
            for (int pile : piles) {
                // Integer math ceiling equivalent
                hours += (pile + mid - 1) / mid;
            }
                
            if (hours <= h) {
                res = mid;
                right = mid - 1; // See if we can do better (smaller speed)
            } else {
                left = mid + 1; // Need to eat faster
            }
        }
        return res;
    }
};
```

## Complexity
- **Time Complexity**: `O(N * log(M))`, where `N` is the number of piles and `M` is the maximum number of bananas in a pile. The binary search takes `O(log(M))` steps. In each step, we iterate through all `N` piles to calculate the hours needed.
- **Space Complexity**: `O(1)`. We only use a few integer variables (`left`, `right`, `mid`, `hours`, `res`), so the extra space required is constant.

## Edge Cases
1. **`h` equals the number of piles (`h == len(piles)`)**: Koko must eat exactly one pile per hour. The optimal speed is exactly `max(piles)`. The binary search naturally converges to this.
2. **Very large pile sizes and `h`**: This could potentially cause integer overflow when summing up hours, so we use a `long long` for `hours` in C++ to prevent overflow issues since `h` can be up to $10^9$. 
3. **Small `h`**: `h` is guaranteed to be `>= len(piles)`. If it wasn't, there would be no solution, but constraints prevent this.

## Notes
- **Recognition**: Any problem phrasing that boils down to "Find the minimum capacity/speed/weight to achieve X within Y limit" screams Binary Search on Answer (e.g., Capacity To Ship Packages Within D Days, Split Array Largest Sum).
- **Trick for ceiling division**: In C++, `ceil(a / (double)b)` can be rewritten using integer arithmetic as `(a + b - 1) / b`. This avoids floating-point inaccuracies and is generally faster.
- Mentally visualize the timeline: the x-axis is speed `k`, the y-axis is hours `h`. It's a monotonically decreasing curve. We just need to find the first `x` where `y <= h`.
