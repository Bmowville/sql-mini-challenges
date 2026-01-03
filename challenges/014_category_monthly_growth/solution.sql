-- Challenge 014: Category monthly growth
-- Output: month, category, revenue_usd, prev_revenue_usd, mom_growth_pct

WITH monthly AS (
  SELECT
    strftime('%Y-%m', o.order_date) AS ym,
    p.category AS category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue_usd
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p ON p.product_id = oi.product_id
  GROUP BY ym, category
),
ranked AS (
  SELECT
    ym,
    category,
    revenue_usd,
    LAG(revenue_usd) OVER (PARTITION BY category ORDER BY ym) AS prev_revenue_usd
  FROM monthly
)
SELECT
  ym,
  category,
  revenue_usd,
  prev_revenue_usd,
  CASE
    WHEN prev_revenue_usd IS NULL OR prev_revenue_usd = 0 THEN NULL
    ELSE ROUND((revenue_usd - prev_revenue_usd) / prev_revenue_usd, 4)
  END AS mom_growth_pct
FROM ranked
ORDER BY ym, category;
