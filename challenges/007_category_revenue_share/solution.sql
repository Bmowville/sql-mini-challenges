-- Revenue by category + share of total revenue

WITH line_items AS (
  SELECT
    p.category,
    (oi.quantity * p.price_usd) AS line_revenue
  FROM order_items oi
  JOIN products p ON p.product_id = oi.product_id
),
category_totals AS (
  SELECT
    category,
    ROUND(SUM(line_revenue), 2) AS revenue_usd
  FROM line_items
  GROUP BY category
),
grand_total AS (
  SELECT SUM(revenue_usd) AS total_revenue
  FROM category_totals
)
SELECT
  ct.category,
  ct.revenue_usd,
  ROUND((ct.revenue_usd * 100.0) / gt.total_revenue, 2) AS pct_of_total
FROM category_totals ct
CROSS JOIN grand_total gt
ORDER BY ct.revenue_usd DESC, ct.category;
