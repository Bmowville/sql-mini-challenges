-- RFM per customer + quartile scoring
-- Notes:
-- - Recency is "days since last order" using the max(order_date) in the dataset as the reference date.
-- - Scores are 1..4 using NTILE(4). Higher is better.
--   * r_score: lower recency_days (more recent) should score higher, so we invert it.

WITH last_date AS (
  SELECT MAX(order_date) AS last_date
  FROM orders
),
rfm_base AS (
  SELECT
    c.customer_id,
    c.customer_name,
    CAST(julianday(ld.last_date) - julianday(MAX(o.order_date)) AS INT) AS recency_days,
    COUNT(o.order_id) AS frequency,
    ROUND(SUM(o.amount_usd), 2) AS monetary_usd
  FROM customers c
  JOIN orders o
    ON o.customer_id = c.customer_id
  CROSS JOIN last_date ld
  GROUP BY c.customer_id, c.customer_name
),
scored AS (
  SELECT
    *,
    (5 - NTILE(4) OVER (ORDER BY recency_days)) AS r_score,
    NTILE(4) OVER (ORDER BY frequency) AS f_score,
    NTILE(4) OVER (ORDER BY monetary_usd) AS m_score
  FROM rfm_base
)
SELECT
  customer_id,
  customer_name,
  recency_days,
  frequency,
  monetary_usd,
  r_score,
  f_score,
  m_score,
  printf('%d%d%d', r_score, f_score, m_score) AS rfm_segment
FROM scored
ORDER BY monetary_usd DESC, customer_id;
