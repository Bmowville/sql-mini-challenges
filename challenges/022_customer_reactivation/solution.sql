-- Output:
-- customer_id | customer_name | prev_order_date | reactivated_order_date | days_inactive

WITH ordered AS (
  SELECT
    customer_id,
    customer_name,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_order_date
  FROM orders
),
gaps AS (
  SELECT
    customer_id,
    customer_name,
    prev_order_date,
    order_date AS reactivated_order_date,
    CAST(julianday(order_date) - julianday(prev_order_date) AS INTEGER) AS days_inactive
  FROM ordered
  WHERE prev_order_date IS NOT NULL
)
SELECT
  customer_id,
  customer_name,
  prev_order_date,
  reactivated_order_date,
  days_inactive
FROM gaps
WHERE days_inactive >= 30
ORDER BY days_inactive DESC, customer_id;
