-- Output:
-- cohort_month | customers_in_cohort | repeat_within_30d | repeat_rate_30d

WITH ranked AS (
  SELECT
    o.customer_id,
    o.order_date,
    o.order_id,
    ROW_NUMBER() OVER (
      PARTITION BY o.customer_id
      ORDER BY o.order_date, o.order_id
    ) AS rn
  FROM orders o
),
first_second AS (
  SELECT
    customer_id,
    MAX(CASE WHEN rn = 1 THEN order_date END) AS first_order_date,
    MAX(CASE WHEN rn = 2 THEN order_date END) AS second_order_date
  FROM ranked
  GROUP BY customer_id
),
flags AS (
  SELECT
    customer_id,
    strftime('%Y-%m', first_order_date) AS cohort_month,
    CASE
      WHEN second_order_date IS NOT NULL
       AND (julianday(second_order_date) - julianday(first_order_date)) <= 30
      THEN 1 ELSE 0
    END AS repeated_30d
  FROM first_second
)
SELECT
  cohort_month,
  COUNT(*) AS customers_in_cohort,
  SUM(repeated_30d) AS repeat_within_30d,
  ROUND(1.0 * SUM(repeated_30d) / COUNT(*), 4) AS repeat_rate_30d
FROM flags
GROUP BY cohort_month
ORDER BY cohort_month;
