-- Challenge 004: Cohort retention (users active by month after signup)
-- Output: for each signup cohort month, count active users at month_offset 0,1,2...

WITH cohorts AS (
  SELECT
    user_id,
    date(signup_date, 'start of month') AS cohort_month
  FROM users
),
activity AS (
  SELECT
    e.user_id,
    date(e.event_date, 'start of month') AS activity_month
  FROM events e
  GROUP BY e.user_id, activity_month
),
joined AS (
  SELECT
    c.cohort_month,
    a.user_id,
    a.activity_month,
    (
      (CAST(strftime('%Y', a.activity_month) AS INTEGER) * 12 + CAST(strftime('%m', a.activity_month) AS INTEGER))
      - (CAST(strftime('%Y', c.cohort_month) AS INTEGER) * 12 + CAST(strftime('%m', c.cohort_month) AS INTEGER))
    ) AS month_offset
  FROM cohorts c
  JOIN activity a
    ON a.user_id = c.user_id
  WHERE a.activity_month >= c.cohort_month
),
retention AS (
  SELECT
    cohort_month,
    month_offset,
    COUNT(DISTINCT user_id) AS active_users
  FROM joined
  GROUP BY cohort_month, month_offset
)
SELECT
  strftime('%Y-%m', cohort_month) AS cohort,
  month_offset,
  active_users
FROM retention
ORDER BY cohort_month, month_offset;
