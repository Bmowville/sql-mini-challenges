-- Output:
-- order_date | revenue_usd | rolling_7d_revenue | rolling_7d_avg

WITH daily AS (
  SELECT
    order_date,
    ROUND(SUM(amount_usd), 2) AS revenue_usd
  FROM orders
  GROUP BY order_date
),
bounds AS (
  SELECT
    MIN(order_date) AS start_date,
    MAX(order_date) AS end_date
  FROM orders
),
date_spine AS (
  SELECT start_date AS d
  FROM bounds
  UNION ALL
  SELECT date(d, '+1 day')
  FROM date_spine, bounds
  WHERE d < end_date
),
filled AS (
  SELECT
    d AS order_date,
    COALESCE(daily.revenue_usd, 0.0) AS revenue_usd
  FROM date_spine
  LEFT JOIN daily
    ON daily.order_date = date_spine.d
)
SELECT
  order_date,
  revenue_usd,
  ROUND(
    SUM(revenue_usd) OVER (
      ORDER BY order_date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ),
    2
  ) AS rolling_7d_revenue,
  ROUND(
    AVG(revenue_usd) OVER (
      ORDER BY order_date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ),
    2
  ) AS rolling_7d_avg
FROM filled
ORDER BY order_date;
