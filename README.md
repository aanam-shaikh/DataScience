# Target Brazil — Customer & Revenue Analysis

## Project Overview
SQL-based analysis of Brazilian e-commerce data using BigQuery.
Explores order patterns, revenue distribution, and geographic insights
across 110,000+ orders.

## Business Questions Answered
1. Which customers place the most orders?
2. How does revenue vary by order status?
3. Which states generate the most revenue?
4. What percentage of total revenue does each state contribute?

## Key Insights
- SP (São Paulo) accounts for 38% of total revenue
- Top 3 states (SP, RJ, MG) generate 63% of all revenue
- Cancelled orders have a higher avg item price (R$175) than delivered ones (R$119)
- 97% of orders are successfully delivered

## SQL Concepts Used
- Window functions: RANK(), OVER()
- JOINs across 3 tables (orders, order_items, customers)
- CTEs (WITH clause)
- Aggregations: COUNT, SUM, AVG, ROUND

## Tools
- Google BigQuery
- Target Brazil public dataset