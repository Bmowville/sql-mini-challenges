-- Challenge 012 solution: return rate per product (based on purchased lines)

WITH purchased_lines AS (
  SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(*) AS purchased_lines
  FROM order_items oi
  JOIN products p
    ON p.product_id = oi.product_id
  GROUP BY p.product_id, p.product_name, p.category
),
returned_lines AS (
  SELECT
    p.product_id,
    COUNT(*) AS returned_lines
  FROM returns r
  JOIN order_items oi
    ON oi.order_item_id = r.order_item_id
  JOIN products p
    ON p.product_id = oi.product_id
  GROUP BY p.product_id
)
SELECT
  pl.product_id,
  pl.product_name,
  pl.category,
  pl.purchased_lines,
  COALESCE(rl.returned_lines, 0) AS returned_lines,
  ROUND(
    COALESCE(rl.returned_lines, 0) * 1.0 / NULLIF(pl.purchased_lines, 0),
    4
  ) AS return_rate
FROM purchased_lines pl
LEFT JOIN returned_lines rl
  ON rl.product_id = pl.product_id
ORDER BY return_rate DESC, pl.product_id;
