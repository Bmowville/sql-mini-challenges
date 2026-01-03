-- Output columns:
-- cohort_week | region | week_n | active_users | cohort_size | retention_rate | rolling_4wk_retention

WITH user_cohorts AS (
  SELECT
    u.user_id,
    u.region,
    date(u.signup_date, '-' || ((cast(strftime('%w', u.signup_date) as integer) + 6) % 7) || ' days') AS cohort_week_start
  FROM users u
),
event_weeks AS (
  SELECT
    e.user_id,
    date(e.event_date, '-' || ((cast(strftime('%w', e.event_date) as integer) + 6) % 7) || ' days') AS event_week_start
  FROM events e
),
cohort_activity AS (
  SELECT
    uc.cohort_week_start AS cohort_week,
    uc.region,
    ew.event_week_start AS activity_week,
    CAST((julianday(ew.event_week_start) - julianday(uc.cohort_week_start)) / 7 AS integer) AS week_n,
    uc.user_id
  FROM user_cohorts uc
  JOIN event_weeks ew
    ON ew.user_id = uc.user_id
  WHERE ew.event_week_start >= uc.cohort_week_start
),
active_by_week AS (
  SELECT
    cohort_week,
    region,
    week_n,
    COUNT(DISTINCT user_id) AS active_users
  FROM cohort_activity
  GROUP BY 1,2,3
),
cohort_sizes AS (
  SELECT
    cohort_week_start AS cohort_week,
    region,
    COUNT(*) AS cohort_size
  FROM user_cohorts
  GROUP BY 1,2
),
joined AS (
  SELECT
    a.cohort_week,
    a.region,
    a.week_n,
    a.active_users,
    cs.cohort_size,
    ROUND(1.0 * a.active_users / cs.cohort_size, 4) AS retention_rate
  FROM active_by_week a
  JOIN cohort_sizes cs
    ON cs.cohort_week = a.cohort_week
   AND cs.region = a.region
)
SELECT
  cohort_week,
  region,
  week_n,
  active_users,
  cohort_size,
  retention_rate,
  ROUND(
    AVG(retention_rate) OVER (
      PARTITION BY cohort_week, region
      ORDER BY week_n
      ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
    ),
    4
  ) AS rolling_4wk_retention
FROM joined
ORDER BY cohort_week, region, week_n;
