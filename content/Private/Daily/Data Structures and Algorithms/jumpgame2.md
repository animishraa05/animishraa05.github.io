_here the new catch is, we have to specify the minimum number of jumps to get to last index, instead of jumpgame 1 in which we had to tell whether one could reach the end or not,_

##### Greedy approach and understanding

the one thing guarenteed is that we can always reach the end. the 1st part was asking whether we can or not.

so basic solution is to try out all the possible jumps from each index and select the minimum one.

so

f (i)
{
if (i has gone past last element (i > n-1)){
return 0;
}

answer = INTmax;
for ( i = 1 to arr[i]){
answer = min( answer, 1 + f{i + jumps})} // exponential in nature TC.

optimal greedy

- just store a jumps in range way.
- we just check the range whether we can reach something or not.

}
