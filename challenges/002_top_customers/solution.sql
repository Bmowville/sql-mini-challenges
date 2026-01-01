-- Goal: rank customers by total spend and return the top 3

WITH customer_totals AS (
  SELECT
    customer_id,
    ROUND(SUM(amount_usd), 2) AS total_spend_usd
  FROM orders
  GROUP BY customer_id
),
ranked AS (
  SELECT
    customer_id,
    total_spend_usd,
    DENSE_RANK() OVER (ORDER BY total_spend_usd DESC) AS spend_rank
  FROM customer_totals
)
SELECT
  customer_id,
  total_spend_usd,
  spend_rank
FROM ranked
WHERE spend_rank <= 3
ORDER BY spend_rank, customer_id;
