_find the length of longest substring wo duplicate chars_

no duplicates, meaning unique char

constraint assumes sliding window.

#### brute force

- basic checking all possible substring and then get a max length from it of completely unique char

so normal brute force take i, as the starting index, j as ending index and k for getting the substring bw them getting on^3

on the fly calculating max getting on^2

for duplicates, i'd say I will be trying w array or set. lets see both

- make a ml
- outer loop i from first string char to end
- inner loop from j = i; -> n
- so then see it, if it has been seen before, its a duplicate, break out and start again with next step, for this will have to map out something..
- then after that checking just checkl the lenght j -i +1 and compare it w max;
- return the maxlengthj.
  too crazy. have to repeat.

#### optimal

to get O(n), one should be looking at hmap, or sliding window w it.
