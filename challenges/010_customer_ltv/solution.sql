-- Return each customer's lifetime value and rank (highest first)

WITH customer_ltv AS (
  SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(o.amount_usd), 2) AS ltv_usd,
    COUNT(*) AS orders_count
  FROM customers c
  JOIN orders o
    ON o.customer_id = c.customer_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT
  customer_id,
  customer_name,
  ltv_usd,
  orders_count,
  DENSE_RANK() OVER (ORDER BY ltv_usd DESC) AS ltv_rank
FROM customer_ltv
ORDER BY ltv_rank, customer_id;
