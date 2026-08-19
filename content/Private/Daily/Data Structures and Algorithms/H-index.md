_find the maximum h index( for each element h there should be h number of citation for it. ) like for candidate = [3,0,6,1,5] the h index is 3 as for 3 there are three citation[i]= 3,5,6 which are >= 3. so its the h index._

#### Brute force

We can calculate the every possible value for h index from start 1 to n where for each we loop through entire array to count how atleast how many have that number of citations.
IF we find that the current one does not have that many citations. We can say that the last one was max h index.

**psuedocode**

answer = 0

for h from 0 to n

    count = 0

    for every paper

        if citations >= h

            count++

    if count >= h

        answer = h

return answer
