WITH months AS (
  SELECT
    customer_id,
    strftime('%Y-%m', order_date) AS ym,
    (CAST(strftime('%Y', order_date) AS INTEGER) * 12) + CAST(strftime('%m', order_date) AS INTEGER) AS ym_idx
  FROM orders
  GROUP BY customer_id, ym
),
gaps AS (
  SELECT
    customer_id,
    ym,
    ym_idx,
    CASE
      WHEN LAG(ym_idx) OVER (PARTITION BY customer_id ORDER BY ym_idx) IS NULL THEN 1
      WHEN ym_idx - LAG(ym_idx) OVER (PARTITION BY customer_id ORDER BY ym_idx) = 1 THEN 0
      ELSE 1
    END AS is_new_group
  FROM months
),
grp AS (
  SELECT
    customer_id,
    ym,
    ym_idx,
    SUM(is_new_group) OVER (PARTITION BY customer_id ORDER BY ym_idx) AS grp_id
  FROM gaps
),
streaks AS (
  SELECT
    customer_id,
    grp_id,
    MIN(ym) AS streak_start,
    MAX(ym) AS streak_end,
    COUNT(*) AS streak_len
  FROM grp
  GROUP BY customer_id, grp_id
)
SELECT
  customer_id,
  MAX(streak_len) AS longest_streak_months
FROM streaks
GROUP BY customer_id
ORDER BY longest_streak_months DESC, customer_id;
