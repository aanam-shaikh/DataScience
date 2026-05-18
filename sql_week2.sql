
SELECT 
    order_id,
    customer_id, 
    order_purchase_timestamp,
    ROW_NUMBER() OVER ( ORDER BY order_purchase_timestamp ) AS row_num
FROM `sqltarget-472618.SQL_TARGET.orders`
LIMIT 10;    

SELECT
    customer_id,
    order_id,
    order_purchase_timestamp,
   ROW_NUMBER()  over (partition by customer_id order by order_purchase_timestamp) as order_number
FROM `sqltarget-472618.SQL_TARGET.orders` 
order by customer_id, order_number
limit 20;  




SELECT 
  c.customer_state,
  count(order_id) as total_orders,
  RANK() OVER (order by count(order_id)DESC ) as Rank,
  ROW_NUMBER() OVER (order by count(order_id) DESC ) as Row_num
FROM `sqltarget-472618.SQL_TARGET.orders` o
JOIN `sqltarget-472618.SQL_TARGET.customers` c
on o.customer_id = c.customer_id
GROUP by c.customer_state
order by Rank
limit 10;


WITH monthly AS (
  SELECT 
    DATE_TRUNC(order_purchase_timestamp, MONTH) AS order_month,
    COUNT(order_id) AS total_orders
  FROM `sqltarget-472618.SQL_TARGET.orders`
  GROUP BY order_month
)
SELECT 
  order_month,
  total_orders,
  LAG(total_orders) OVER (ORDER BY order_month) AS prev_month_orders
FROM monthly
ORDER BY order_month;



WITH month_met AS (
  SELECT 
    DATE_TRUNC(order_purchase_timestamp, MONTH) AS order_month,
    COUNT(order_id) AS total_orders
  FROM `sqltarget-472618.SQL_TARGET.orders`
  GROUP BY order_month
)
SELECT 
  order_month,
  total_orders,
  LAG(total_orders) OVER (order by order_month) AS prev_month_orders,
  ROUND((total_orders - LAG(total_orders) OVER ( ORDER BY order_month))
/ LAG (total_orders) OVER (order by order_month) * 100,1) as pct_change
FROM month_met
ORDER BY order_month ASC
LIMIT 10;
