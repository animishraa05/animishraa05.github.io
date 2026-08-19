what we will be basically doing here in the brute force was just take 2 loops, if the count is more than the n/2 then return the number

tho for the better approach, we would use hashmaps, unordered_map<int,int> mpp, where we will do this
-- create a hashmap,
run the iteration first to get the frequency
check if the frequency given is more than n/2 then return.

**psuedocode**

hashmap mpp

for num :nums // range based for loop equivalent to for int i=0 ->n and i++ int num=nums[i]
mpp[num]++; // this will increase the count of frequency, ba

for (auto it : mpp){ //
if (it.second >= n/2){
return it.first;
}

**optimal solution**
uses something known as boyer-moore voting algo

- hashmap store frequency and basically stores no of times something occurs
- we use here a term known as vote i.e., frequency. So, we just see that the majority element will have more votes than all other votes combined.
- we use this algo which just says the element which is not majority will get cancelled out.

we will be using a candidate(element) and its count. and increase count when candidate occurs and decrease when some other does.
