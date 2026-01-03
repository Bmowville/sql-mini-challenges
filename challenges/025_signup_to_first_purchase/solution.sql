-- Challenge 025: Signup to first purchase
-- Output columns:
-- user_id | user_name | signup_date | first_order_date | days_to_first_purchase

WITH first_orders AS (
  SELECT
    u.user_id,
    u.user_name,
    u.signup_date,
    MIN(o.order_date) AS first_order_date
  FROM users u
  LEFT JOIN orders o
    ON o.user_id = u.user_id
  GROUP BY u.user_id, u.user_name, u.signup_date
),
final AS (
  SELECT
    user_id,
    user_name,
    signup_date,
    first_order_date,
    CASE
      WHEN first_order_date IS NULL THEN NULL
      ELSE CAST(julianday(first_order_date) - julianday(signup_date) AS INT)
    END AS days_to_first_purchase
  FROM first_orders
)
SELECT
  user_id,
  user_name,
  signup_date,
  first_order_date,
  days_to_first_purchase
FROM final
ORDER BY user_id;

-- Summary row (avg + median over purchasers only)
WITH first_orders AS (
  SELECT
    u.user_id,
    u.user_name,
    u.signup_date,
    MIN(o.order_date) AS first_order_date
  FROM users u
  LEFT JOIN orders o
    ON o.user_id = u.user_id
  GROUP BY u.user_id, u.user_name, u.signup_date
),
lags AS (
  SELECT
    user_id,
    user_name,
    signup_date,
    first_order_date,
    CASE
      WHEN first_order_date IS NULL THEN NULL
      ELSE CAST(julianday(first_order_date) - julianday(signup_date) AS INT)
    END AS days_to_first_purchase
  FROM first_orders
),
purchasers AS (
  SELECT *
  FROM lags
  WHERE days_to_first_purchase IS NOT NULL
),
ranked AS (
  SELECT
    days_to_first_purchase,
    ROW_NUMBER() OVER (ORDER BY days_to_first_purchase) AS rn,
    COUNT(*) OVER () AS n
  FROM purchasers
),
median_calc AS (
  SELECT AVG(days_to_first_purchase * 1.0) AS median_days
  FROM ranked
  WHERE rn IN ((n + 1) / 2, (n + 2) / 2)
),
avg_calc AS (
  SELECT AVG(days_to_first_purchase * 1.0) AS avg_days
  FROM purchasers
)
SELECT
  'SUMMARY' AS user_id,
  NULL AS user_name,
  NULL AS signup_date,
  NULL AS first_order_date,
  printf(
    'avg=%.2f, median=%.2f',
    (SELECT avg_days FROM avg_calc),
    (SELECT median_days FROM median_calc)
  ) AS days_to_first_purchase;
