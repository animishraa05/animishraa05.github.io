_we have to check whether we can to array ke last index tak, specifying the method ki jo bhi element hai utni jump mae max le sakta hu_

[2,3,1,0,4] and we have to specify that whether we can reach the last index at 4 through jumping at 1st.

**Solution**

- we can not reach the end if there is a zero in between.
- We can not reach zero if there is an index greater than the maximum index we can reach, which is literally just adding the element to index.

##### Pseudocode

function(){
max index = 0
for i = 0 to n-1 {
if (maxindex < i){
return false}
else{
max(maxindex, i + arr[i])}
}
return true
