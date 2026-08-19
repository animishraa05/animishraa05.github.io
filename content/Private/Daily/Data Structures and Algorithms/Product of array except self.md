*need to return an array in which each element of it corresponds to product of all the element in the given array except the one corresponding to the returned array element*

meaning for nums[1,2,3,4]
we can just return answer(24,12,8,6)
 and you know wht we are talking about from this


##### brute force
Very straightforward here is using two nested loops where we let the inner loop multiply all the numbers except when it matches the outer loop.
Psuedocode

answer = vector<int> answer(1,n);
for int i = 0-> n-1 
ca = 1;
for j= 0 to n-1 
if I not equal to j
ca = ca * nums[j]
answer[i] = ca;

return answer;
