-- Monthly revenue + month-over-month growth %
WITH monthly AS (
  SELECT
    strftime('%Y-%m', order_date) AS ym,
    ROUND(SUM(amount_usd), 2)     AS revenue_usd
  FROM orders
  GROUP BY 1
),
with_prev AS (
  SELECT
    ym,
    revenue_usd,
    LAG(revenue_usd) OVER (ORDER BY ym) AS prev_revenue_usd
  FROM monthly
)
SELECT
  ym,
  revenue_usd,
  prev_revenue_usd,
  CASE
    WHEN prev_revenue_usd IS NULL OR prev_revenue_usd = 0 THEN NULL
    ELSE ROUND((revenue_usd - prev_revenue_usd) / prev_revenue_usd, 4)
  END AS mom_growth_pct
FROM with_prev
ORDER BY ym;
