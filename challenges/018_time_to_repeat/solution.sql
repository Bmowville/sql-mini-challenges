-- Output columns:
-- customer_id | customer_name | first_order_date | second_order_date | days_to_second

WITH ranked AS (
  SELECT
    o.customer_id,
    c.customer_name,
    o.order_date,
    o.order_id,
    ROW_NUMBER() OVER (
      PARTITION BY o.customer_id
      ORDER BY o.order_date, o.order_id
    ) AS rn
  FROM orders o
  JOIN customers c ON c.customer_id = o.customer_id
),
first_second AS (
  SELECT
    customer_id,
    customer_name,
    MAX(CASE WHEN rn = 1 THEN order_date END) AS first_order_date,
    MAX(CASE WHEN rn = 2 THEN order_date END) AS second_order_date
  FROM ranked
  GROUP BY customer_id, customer_name
)
SELECT
  customer_id,
  customer_name,
  first_order_date,
  second_order_date,
  CAST(ROUND(julianday(second_order_date) - julianday(first_order_date)) AS INTEGER) AS days_to_second
FROM first_second
WHERE second_order_date IS NOT NULL
ORDER BY days_to_second DESC, customer_id;
