---
concept: RFM Segmentation
aliases: [RFM, recency frequency monetary, customer segmentation]
tags: [database, analytics]
created: 2026-04-14
updated: 2026-04-14
---

## The Problem
Marketers need to segment customers into actionable groups—like "champions" who buy frequently and recently, or "at-risk" who used to buy but haven't ordered recently. Simple counts aren't enough—they need behavioral segmentation based on purchase patterns.

## Core Idea
RFM (Recency, Frequency, Monetary) is a customer segmentation technique that scores each customer on three dimensions:
- **Recency**: Days since last order (lower is better)
- **Frequency**: Number of orders (higher is better)
- **Monetary**: Total spending (higher is better)

Each dimension is scored 1-5 using NTILE(5), then combined into 9 actionable segments.

## How It Works
1. **Aggregate customer metrics**: From fact_orders, get recency_days, frequency (count), monetary (sum)
2. **NTILE scoring**: Divide customers into 5 equal groups per dimension
   - Recency: 5 = most recent, 1 = least recent
   - Frequency: 5 = most frequent, 1 = least frequent
   - Monetary: 5 = highest spend, 1 = lowest spend
3. **Segment assignment**: Decision tree based on R/F/M scores

| Segment | R Score | F Score | M Score |
|---------|----------|----------|---------|
| Champions | 4+ | 4+ | 4+ |
| Loyal Customers | 3+ | 3+ | 3+ |
| New Customers | 4+ | ≤2 | ≤2 |
| Potential Loyalists | 3+ | 3+ | 2+ |
| Recent Customers | 4+ | 4+ | ≤2 |
| At-Risk Customers | ≤2 | 4+ | 4+ |
| About to Sleep | ≤2 | 3+ | 3+ |
| Lost | ≤2 | ≤2 | ≤2 |
| Can't Lose Them | 3+ | ≤2 | 3+ |

## Key Properties
- **NTILE(5)**: Equal-frequency binning—each quintile has ~20% of customers
- **9 segments**: Standard marketing framework with actionable insights
- **SQL implementation**: Uses window functions (NTILE) and CASE expressions
- **Business value**: Directs marketing resources to highest-value segments

## Connections
- Related: [[customer-lifetime-value|Customer Lifetime Value]] — CLV is closely related to RFM monetary dimension
- Related: [[data-warehouse|Data Warehouse]] — RFM queries run against warehouse
- Related: [[etl-pipeline|ETL Pipeline]] — customer data prepared by ETL

## Edge Cases & Gotchas
- **Zero orders**: Customers with no orders require LEFT JOIN, result in NULL/zero values
- **Equal-frequency binning**: NTILE creates equal groups, not equal ranges—outliers affect scores
- **Static segmentation**: Updates only when ETL runs—not real-time