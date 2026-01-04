-- Output:
-- reactivation_month | users_reactivated | retained_next_month | retention_rate_next_month
--
-- Notes:
-- - We treat each reactivation event as belonging to a cohort month.
-- - "Retained next month" means the user has at least one event in the next calendar month.

WITH dedup AS (
  SELECT DISTINCT
    user_id,
    date(event_date) AS event_date
  FROM events
),
ordered AS (
  SELECT
    user_id,
    event_date,
    LAG(event_date) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_date
  FROM dedup
),
reactivations AS (
  SELECT
    user_id,
    event_date AS reactivation_date,
    strftime('%Y-%m', event_date) AS reactivation_month,
    date(strftime('%Y-%m-01', event_date), '+1 month') AS next_month_start,
    date(strftime('%Y-%m-01', event_date), '+2 month') AS next_month_end
  FROM ordered
  WHERE prev_date IS NOT NULL
    AND (julianday(event_date) - julianday(prev_date)) > 14
),
retained_flag AS (
  SELECT
    r.user_id,
    r.reactivation_date,
    r.reactivation_month,
    CASE
      WHEN EXISTS (
        SELECT 1
        FROM dedup e
        WHERE e.user_id = r.user_id
          AND e.event_date >= r.next_month_start
          AND e.event_date <  r.next_month_end
      )
      THEN 1 ELSE 0
    END AS retained_next_month
  FROM reactivations r
),
by_month AS (
  SELECT
    reactivation_month,
    COUNT(*) AS reactivation_events,
    COUNT(DISTINCT user_id) AS users_reactivated,
    SUM(retained_next_month) AS retained_next_month
  FROM retained_flag
  GROUP BY reactivation_month
)
SELECT
  reactivation_month,
  users_reactivated,
  retained_next_month,
  ROUND(1.0 * retained_next_month / NULLIF(users_reactivated, 0), 4) AS retention_rate_next_month
FROM by_month
ORDER BY reactivation_month;
