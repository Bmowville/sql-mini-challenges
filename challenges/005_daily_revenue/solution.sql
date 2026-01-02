-- Challenge 005: Daily revenue
-- Output: one row per day with daily revenue + 7-day rolling revenue (including that day)

WITH daily AS (
  SELECT
    order_date,
    ROUND(SUM(amount_usd), 2) AS daily_revenue_usd
  FROM orders
  GROUP BY order_date
),
with_roll AS (
  SELECT
    order_date,
    daily_revenue_usd,
    ROUND(
      SUM(daily_revenue_usd) OVER (
        ORDER BY order_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
      ),
      2
    ) AS rolling_7d_revenue_usd
  FROM daily
)
SELECT
  order_date,
  daily_revenue_usd,
  rolling_7d_revenue_usd
FROM with_roll
ORDER BY order_date;
