WITH base AS (
  SELECT
    strftime('%Y-%m', order_date) AS ym,
    amount_usd
  FROM orders
),
ranked AS (
  SELECT
    ym,
    amount_usd,
    ROW_NUMBER() OVER (PARTITION BY ym ORDER BY amount_usd) AS rn,
    COUNT(*) OVER (PARTITION BY ym) AS cnt
  FROM base
),
picked AS (
  SELECT
    ym,
    amount_usd
  FROM ranked
  WHERE rn IN ( (cnt + 1) / 2, (cnt + 2) / 2 )
)
SELECT
  ym,
  ROUND(AVG(amount_usd), 2) AS median_order_value
FROM picked
GROUP BY ym
ORDER BY ym;
