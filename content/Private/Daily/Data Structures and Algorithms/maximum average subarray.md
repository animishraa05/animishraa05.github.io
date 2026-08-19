*we just need to calculate the maximum of average of subarray(a contigous part of array of k size given) inside the array.*

brute force thinking and small changes which we forget.
- start generating all subarray of size k.
- how to do that - start with i from 0 to n-k (as not all subarray can be of size k), and I will only keep starting index, the iteration will be done by j which will go from j= i to j = i+k as it basically iterates through all elements inside the window.
- then just calculate sum, average and do max of maxavg, avg.
TC- O(n*k) as the first loop is calculating n element and second is doing k elements only as subarray will be k size

the only change in window is to add one element and then remove one last element.

optimal thinking-

- what if we take a current sum which show current sum, which is sum of current window. 
- we cant do immediate slide. we have to first calculate sum of first window.

psuedocode thinking 

- is array smaller than k , if no continue
- first calculate first window sum. 
- update current sum. max sum
- now for each iteration, - shrink the last element(i -k) , add next element (i) and update the max sum.
- remember i starts at loop = k 

so 
fitrst make a loop (i to k ) to get first window in. inside the loop just do currsum +=arr[i] and make maxsum = currsum;
then do from i = k to n-1 for next window
then inside it , do currsum = currsum - [i - k]
then currsum = currsum + [i]
then maxsum = max(currsum, maxsum);
return (double)maxum/k;z

ok so this is how it works.