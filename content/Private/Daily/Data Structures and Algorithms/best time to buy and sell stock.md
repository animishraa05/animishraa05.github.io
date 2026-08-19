_the question asks to get the maximum profit through buying and selling stocks_

##### solutions and brute force

- you can buy and sell multiple times.
- will use the concept of getting the basic pseudocode like this

int profit = 0;
for (int i -> n ){
if profit it greater than yesterday
calculate and add the profit (add the difference in profit)
return profit.
}
so like if prices[i] > profit[i - 1]
profit = profit + (prices[i] - prices[i - 1])

so **we basically just see whether the stocks are going up or not from yesterday, if yes we are adding them to profit, by getting the difference.**
