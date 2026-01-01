-- Challenge 003: Customer retention (repeat customers by month)
-- Goal: list customers who ordered in consecutive months

WITH monthly_orders AS (
  SELECT
    customer_id,
    -- month key like 2024-02
    strftime('%Y-%m', order_date) AS ym,
    -- sortable month index for "consecutive month" math
    (CAST(strftime('%Y', order_date) AS INTEGER) * 12) + CAST(strftime('%m', order_date) AS INTEGER) AS ym_idx
  FROM orders
  GROUP BY customer_id, ym
),
ranked AS (
  SELECT
    customer_id,
    ym,
    ym_idx,
    LAG(ym)     OVER (PARTITION BY customer_id ORDER BY ym_idx) AS prev_ym,
    LAG(ym_idx) OVER (PARTITION BY customer_id ORDER BY ym_idx) AS prev_ym_idx
  FROM monthly_orders
)
SELECT
  customer_id,
  prev_ym AS from_month,
  ym      AS to_month
FROM ranked
WHERE prev_ym_idx IS NOT NULL
  AND (ym_idx - prev_ym_idx) = 1
ORDER BY customer_id, from_month;

