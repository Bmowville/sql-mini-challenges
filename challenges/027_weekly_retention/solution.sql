-- Weekly retention: active customers per week + retained customers from previous week
-- Output columns:
--   week_start | active_customers | prev_week_active | retained_from_prev | retention_rate

WITH weekly_active AS (
  SELECT
    date(order_date, 'weekday 1', '-7 days') AS week_start,  -- Monday week start
    customer_id
  FROM orders
  GROUP BY week_start, customer_id
),
weekly_counts AS (
  SELECT
    week_start,
    COUNT(*) AS active_customers
  FROM weekly_active
  GROUP BY week_start
),
retained AS (
  SELECT
    cur.week_start AS week_start,
    COUNT(*) AS retained_from_prev
  FROM weekly_active cur
  JOIN weekly_active prev
    ON prev.customer_id = cur.customer_id
   AND prev.week_start = date(cur.week_start, '-7 days')
  GROUP BY cur.week_start
),
final AS (
  SELECT
    wc.week_start,
    wc.active_customers,
    LAG(wc.active_customers) OVER (ORDER BY wc.week_start) AS prev_week_active,
    COALESCE(r.retained_from_prev, 0) AS retained_from_prev
  FROM weekly_counts wc
  LEFT JOIN retained r
    ON r.week_start = wc.week_start
)
SELECT
  week_start,
  active_customers,
  prev_week_active,
  retained_from_prev,
  CASE
    WHEN prev_week_active IS NULL OR prev_week_active = 0 THEN NULL
    ELSE ROUND(1.0 * retained_from_prev / prev_week_active, 4)
  END AS retention_rate
FROM final
ORDER BY week_start;
