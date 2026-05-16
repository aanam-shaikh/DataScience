SELECT *
FROM `sqltarget-472618.SQL_TARGET.orders`
LIMIT 10;


SELECT customer_id,
       count(order_id) AS Total_Orders,
       RANK() OVER(ORDER BY COUNT(order_id)DESC) AS Customer_Rank

FROM `sqltarget-472618.SQL_TARGET.orders`
GROUP BY customer_id
ORDER BY customer_rank
LIMIT 20;      



SELECT
  o.order_status,
  count(o.order_id) AS Total_Orders,
  ROUND(sum(oi.price),2) AS Total_Revenue,
  ROUND(avg(oi.price),2) AS Avg_Order_Value,
  RANK() OVER (ORDER BY COUNT(o.order_id)DESC) as Status_Rank

FROM `sqltarget-472618.SQL_TARGET.orders` o
JOIN `sqltarget-472618.SQL_TARGET.order_items` oi
on o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY Status_Rank;  


SELECT 
  c.customer_state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS total_revenue,
  ROUND(AVG(oi.price), 2) AS avg_item_price,
  RANK() OVER (ORDER BY SUM(oi.price) DESC) AS revenue_rank
FROM `sqltarget-472618.SQL_TARGET.orders` o
JOIN `sqltarget-472618.SQL_TARGET.order_items` oi ON o.order_id = oi.order_id
JOIN `sqltarget-472618.SQL_TARGET.customers` c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY revenue_rank
LIMIT 10;


WITH state_metrics AS (
  SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
  FROM `sqltarget-472618.SQL_TARGET.orders` o
  JOIN `sqltarget-472618.SQL_TARGET.order_items` oi ON o.order_id = oi.order_id
  JOIN `sqltarget-472618.SQL_TARGET.customers` c ON o.customer_id = c.customer_id
  GROUP BY c.customer_state
)
SELECT 
  customer_state,
  total_orders,
  total_revenue,
  ROUND(total_revenue / SUM(total_revenue) OVER (), 2) * 100 AS revenue_share_pct
FROM state_metrics
ORDER BY total_revenue DESC
LIMIT 10;



