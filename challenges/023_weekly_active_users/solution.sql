-- Output:
-- week_start (Monday)
-- wau (distinct users with >=1 event that week)

WITH base AS (
  SELECT
    user_id,
    date(event_time) AS d
  FROM events
),
weeks AS (
  SELECT
    user_id,
    date(d, 'weekday 1', '-7 days') AS week_start
  FROM base
)
SELECT
  week_start,
  COUNT(DISTINCT user_id) AS wau
FROM weeks
GROUP BY week_start
ORDER BY week_start;
