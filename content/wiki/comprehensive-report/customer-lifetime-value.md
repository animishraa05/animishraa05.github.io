---
concept: Customer Lifetime Value
aliases: [CLV, lifetime value, customer value]
tags: [database, analytics]
created: 2026-04-14
updated: 2026-04-14
---

# Customer Lifetime Value

## The Problem
Not all customers are equal—a customer who spent ₹50,000 over 2 years is more valuable than one who spent ₹500. Marketing needs to identify high-value customers for retention efforts, but raw revenue totals don't tell the whole story.

## Core Idea
Customer Lifetime Value (CLV) is the total revenue expected from a customer over their entire relationship with the company. It combines order frequency, average order value, and tenure to create a single metric that enables customer segmentation, retention targeting, and acquisition budget allocation.

## How It Works
1. **Aggregate per customer**: From fact_orders, sum net_total for each customer
2. **Calculate metrics**:
   - Total orders: `COUNT(order_id)`
   - Lifetime value: `SUM(net_total)`
   - Average order value: `AVG(net_total)`
   - Last order date: `MAX(order_timestamp)`
   - Days since last order: `CURRENT_DATE - last_order_date`
3. **Quartile ranking**: Use NTILE(4) to divide into 4 groups by lifetime value
4. **Segment assignment**:
   - Q1 (top 25%): Champions
   - Q2: Loyal
   - Q3: At-Risk
   - Q4 (bottom 25%): Dormant

```sql
SELECT c.customer_id, c.full_name, c.city,
       COUNT(fo.order_id) AS total_orders,
       SUM(fo.net_total) AS lifetime_value,
       NTILE(4) OVER (ORDER BY SUM(fo.net_total) DESC) AS clv_quartile
FROM dim_customer c
LEFT JOIN fact_orders fo ON c.customer_id = fo.customer_id
GROUP BY c.customer_id, c.full_name, c.city
```

## Key Properties
- **LEFT JOIN**: Include customers with zero orders (new prospects who registered but never ordered)
- **Quartile segmentation**: NTILE(4) creates equal groups for targeted marketing
- **Actionable tiers**: Champions, Loyal, At-Risk, Dormant map to specific marketing actions
- **Combined with tenure**: Premium + tenure_days creates customer_segment for richer analysis

## Connections
- Related: [[rfm-segmentation|RFM Segmentation]] — CLV monetary dimension is related to RFM
- Related: [[dimension-table|Dimension Table]] — customer data stored in dim_customer
- Related: [[fact-table|Fact Table]] — order data in fact_orders used for CLV calculation

## Edge Cases & Gotchas
- **Zero orders**: LEFT JOIN includes customers who registered but never ordered—they have CLV = 0
- **Cancelled orders**: Filter by `status = 'Delivered'` to exclude cancelled/refunded orders
- **Static calculation**: CLV updates only when ETL runs—not real-time

## Sources
- [[../comprehensive-report-summary|FoodFlow Analytics Comprehensive Report]]
