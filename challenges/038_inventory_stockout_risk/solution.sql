-- Output columns:
-- product_id | sku | net_available_units | recent_7d_units | avg_daily_units | days_of_cover | next_open_po_date | risk_level

WITH params AS (
  SELECT date('2024-05-15') AS as_of_date
),
recent_sales AS (
  SELECT
    p.product_id,
    COALESCE(SUM(
      CASE
        WHEN date(s.sold_date) BETWEEN date(params.as_of_date, '-6 day') AND params.as_of_date
        THEN s.units_sold
        ELSE 0
      END
    ), 0) AS recent_7d_units
  FROM products p
  CROSS JOIN params
  LEFT JOIN sales s ON s.product_id = p.product_id
  GROUP BY p.product_id
),
next_purchase_order AS (
  SELECT
    product_id,
    MIN(date(due_date)) AS next_open_po_date
  FROM purchase_orders
  WHERE status = 'open'
  GROUP BY product_id
),
metrics AS (
  SELECT
    p.product_id,
    p.sku,
    p.lead_time_days,
    p.safety_stock_units,
    i.on_hand_units - i.reserved_units AS net_available_units,
    rs.recent_7d_units,
    ROUND(rs.recent_7d_units / 7.0, 2) AS avg_daily_units,
    CASE
      WHEN rs.recent_7d_units = 0 THEN NULL
      ELSE ROUND((i.on_hand_units - i.reserved_units) * 7.0 / rs.recent_7d_units, 2)
    END AS days_of_cover,
    npo.next_open_po_date
  FROM products p
  JOIN inventory i ON i.product_id = p.product_id
  JOIN recent_sales rs ON rs.product_id = p.product_id
  LEFT JOIN next_purchase_order npo ON npo.product_id = p.product_id
),
scored AS (
  SELECT
    product_id,
    sku,
    net_available_units,
    recent_7d_units,
    avg_daily_units,
    days_of_cover,
    next_open_po_date,
    CASE
      WHEN recent_7d_units = 0 THEN 'no_recent_demand'
      WHEN net_available_units <= safety_stock_units THEN 'critical'
      WHEN days_of_cover <= lead_time_days THEN 'critical'
      WHEN days_of_cover <= lead_time_days + 7 THEN 'watch'
      ELSE 'healthy'
    END AS risk_level
  FROM metrics
)
SELECT
  product_id,
  sku,
  net_available_units,
  recent_7d_units,
  avg_daily_units,
  days_of_cover,
  next_open_po_date,
  risk_level
FROM scored
ORDER BY product_id;