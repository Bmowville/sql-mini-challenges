-- Challenge 009: Top products per category
-- Goal: top 3 products by revenue within each category

WITH product_revenue AS (
  SELECT
    p.category,
    p.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue_usd
  FROM order_items oi
  JOIN products p
    ON p.product_id = oi.product_id
  GROUP BY p.category, p.product_name
),
ranked AS (
  SELECT
    category,
    product_name,
    revenue_usd,
    DENSE_RANK() OVER (
      PARTITION BY category
      ORDER BY revenue_usd DESC
    ) AS revenue_rank
  FROM product_revenue
)
SELECT
  category,
  product_name,
  revenue_usd,
  revenue_rank
FROM ranked
WHERE revenue_rank <= 3
ORDER BY category, revenue_rank, product_name;
