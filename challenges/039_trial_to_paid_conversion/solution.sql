-- Output columns:
-- cohort_month | trial_plan | trials | converted_14d | converted_30d | conversion_30d_pct | avg_days_to_paid_30d | new_mrr_30d

WITH first_paid AS (
  SELECT
    user_id,
    date(started_date) AS started_date,
    paid_plan,
    monthly_amount,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY date(started_date), subscription_id
    ) AS rn
  FROM subscriptions
  WHERE status = 'active'
),
trial_outcomes AS (
  SELECT
    substr(ts.signup_date, 1, 7) AS cohort_month,
    ts.trial_plan,
    ts.user_id,
    CASE
      WHEN fp.started_date IS NULL THEN NULL
      WHEN fp.started_date < date(ts.signup_date) THEN NULL
      ELSE CAST(julianday(fp.started_date) - julianday(ts.signup_date) AS INTEGER)
    END AS days_to_paid,
    fp.monthly_amount
  FROM trial_signups ts
  LEFT JOIN first_paid fp
    ON fp.user_id = ts.user_id
   AND fp.rn = 1
)
SELECT
  cohort_month,
  trial_plan,
  COUNT(*) AS trials,
  SUM(CASE WHEN days_to_paid BETWEEN 0 AND 14 THEN 1 ELSE 0 END) AS converted_14d,
  SUM(CASE WHEN days_to_paid BETWEEN 0 AND 30 THEN 1 ELSE 0 END) AS converted_30d,
  ROUND(100.0 * SUM(CASE WHEN days_to_paid BETWEEN 0 AND 30 THEN 1 ELSE 0 END) / COUNT(*), 2) AS conversion_30d_pct,
  ROUND(AVG(CASE WHEN days_to_paid BETWEEN 0 AND 30 THEN days_to_paid END), 2) AS avg_days_to_paid_30d,
  COALESCE(SUM(CASE WHEN days_to_paid BETWEEN 0 AND 30 THEN monthly_amount ELSE 0 END), 0) AS new_mrr_30d
FROM trial_outcomes
GROUP BY cohort_month, trial_plan
ORDER BY cohort_month, trial_plan;