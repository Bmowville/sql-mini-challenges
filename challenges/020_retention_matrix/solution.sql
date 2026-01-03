-- Output:
-- cohort_month | month_number | active_users

WITH user_activity AS (
  SELECT DISTINCT
    u.user_id,
    strftime('%Y-%m', u.signup_date) AS cohort_month,
    -- month index for signup and event to compute month_number
    (CAST(strftime('%Y', u.signup_date) AS INTEGER) * 12 + CAST(strftime('%m', u.signup_date) AS INTEGER)) AS signup_m,
    (CAST(strftime('%Y', e.event_date) AS INTEGER) * 12 + CAST(strftime('%m', e.event_date) AS INTEGER)) AS event_m
  FROM users u
  JOIN events e
    ON e.user_id = u.user_id
),
bucketed AS (
  SELECT
    cohort_month,
    (event_m - signup_m) AS month_number,
    user_id
  FROM user_activity
  WHERE (event_m - signup_m) >= 0
)
SELECT
  cohort_month,
  month_number,
  COUNT(DISTINCT user_id) AS active_users
FROM bucketed
GROUP BY cohort_month, month_number
ORDER BY cohort_month, month_number;
