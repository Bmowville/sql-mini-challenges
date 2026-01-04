-- Output columns:
-- customer_id | tier | region | effective_start | effective_end | is_current

WITH ordered AS (
  SELECT
    customer_id,
    tier,
    region,
    date(change_date) AS effective_start,
    LEAD(date(change_date)) OVER (PARTITION BY customer_id ORDER BY date(change_date)) AS next_start
  FROM customer_changes
),
scd2 AS (
  SELECT
    customer_id,
    tier,
    region,
    effective_start,
    CASE
      WHEN next_start IS NULL THEN NULL
      ELSE date(next_start, '-1 day')
    END AS effective_end,
    CASE
      WHEN next_start IS NULL THEN 1 ELSE 0
    END AS is_current
  FROM ordered
)
SELECT
  customer_id,
  tier,
  region,
  effective_start,
  effective_end,
  is_current
FROM scd2
ORDER BY customer_id, effective_start;
