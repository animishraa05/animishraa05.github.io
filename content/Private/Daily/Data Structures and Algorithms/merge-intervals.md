---
title: "Merge Intervals"
link: "https://leetcode.com/problems/merge-intervals/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We are given an array of intervals and asked to merge all overlapping intervals into one.

**Why Sorting?**
To merge intervals efficiently, we need overlapping intervals to be adjacent to each other in our data structure. By sorting the intervals based on their **start times**, we guarantee that any interval that could possibly merge with the current interval will be located immediately after it.

Once sorted, we can maintain a `merged` list. For every subsequent interval, we only need to compare it with the **last** interval in our `merged` list.
- If the new interval's start time is $\le$ the last merged interval's end time, they overlap. We update the end time of the last merged interval to be the maximum of the two end times.
- If they don't overlap, we simply append the new interval to `merged`.

**Specific questions to practice:**
- Insert Interval
- Non-overlapping Intervals
- Meeting Rooms I & II

## Code

### Brute-Force Approach
Compare every interval with every other interval. If they overlap, merge them and remove the old ones. Repeat until no more merges can be done.
*Complexity:* $O(n^2)$ time due to nested looping and frequent modifications.

### Optimal Approach (Sort and Merge)

*Pseudocode logic:*
1. Edge case: if `intervals` is empty, return empty list.
2. Sort `intervals` by the `start` value (the 0th index).
3. Initialize `merged` list with the first interval: `merged = [intervals[0]]`.
4. Loop through the remaining intervals from index 1 to $n-1$:
   - Let `last_merged` be the last interval in `merged`.
   - Let `current` be the current interval in the loop.
   - **Overlap condition:** If `current[0] <= last_merged[1]`:
     - Update the end of `last_merged`: `last_merged[1] = max(last_merged[1], current[1])`.
     - (Note: we don't need to update the start time because they are already sorted by start time).
   - **No overlap:** Else:
     - Append `current` to `merged`.
5. Return `merged`.

```cpp
class Solution {
public:
    std::vector<std::vector<int>> merge(std::vector<std::vector<int>>& intervals) {
        if (intervals.empty()) {
            return {};
        }
            
        // Step 1: Sort the intervals by their start times
        std::sort(intervals.begin(), intervals.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[0] < b[0];
        });
        
        // Step 2: Initialize the merged vector with the first interval
        std::vector<std::vector<int>> merged;
        merged.push_back(intervals[0]);
        
        for (int i = 1; i < intervals.size(); ++i) {
            // Get reference to the last interval in our merged list
            std::vector<int>& lastMerged = merged.back();
            const std::vector<int>& current = intervals[i];
            
            // Step 3: Check for overlap
            // If the current interval starts before or when the last one ends
            if (current[0] <= lastMerged[1]) {
                // Merge them by extending the end time
                lastMerged[1] = std::max(lastMerged[1], current[1]);
            } else {
                // No overlap, so we add it as a new distinct interval
                merged.push_back(current);
            }
        }
                
        return merged;
    }
};
```

## Complexity
- **Time Complexity:** $O(n \log n)$
  - Sorting the array of intervals dominates the time complexity. The linear scan takes $O(n)$ time. Total time is bounded by the sort.
- **Space Complexity:** $O(n)$ or $O(\log n)$
  - `std::sort` in C++ typically uses introsort which uses $O(\log n)$ auxiliary stack space. The `merged` vector in the worst case (no overlaps) stores all $n$ intervals.

## Edge Cases
- **Fully encapsulated intervals:** `[[1, 5], [2, 4]]`. Sorted, it's the same. `current[0] <= lastMerged[1]` ($2 \le 5$) is true. End becomes `max(5, 4) = 5`. Result `[[1, 5]]`. Correct.
- **Identical intervals:** `[[1, 4], [1, 4]]`. Merges into `[[1, 4]]`. Correct.
- **Adjacent overlapping:** `[[1, 2], [2, 3]]`. Merges into `[[1, 3]]`. Correct.

## Notes
- **Recognition:** Any problem involving "intervals", "overlapping", "meetings", or "schedules" is an immediate trigger for **Sorting by Start Time**. 
- **Mental Model:** Picture painting a line on the ground. If you always start painting from left to right, you only ever need to check if your new paint brush stroke overlaps with the *very rightmost edge* of the wet paint you just put down. You never need to look backwards at previous disjoint sections.
