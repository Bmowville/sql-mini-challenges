-- Output:
-- customer_id | customer_name | last_order_date | days_since_last_order

WITH params AS (
  SELECT date('2024-04-01') AS as_of_date
),
last_orders AS (
  SELECT
    c.customer_id,
    c.customer_name,
    MAX(date(o.order_date)) AS last_order_date
  FROM customers c
  JOIN orders o
    ON o.customer_id = c.customer_id
  GROUP BY c.customer_id, c.customer_name
),
scored AS (
  SELECT
    lo.customer_id,
    lo.customer_name,
    lo.last_order_date,
    CAST(julianday((SELECT as_of_date FROM params)) - julianday(lo.last_order_date) AS INTEGER) AS days_since_last_order
  FROM last_orders lo
)
SELECT
  customer_id,
  customer_name,
  last_order_date,
  days_since_last_order
FROM scored
WHERE days_since_last_order > 30
ORDER BY days_since_last_order DESC, customer_id;
