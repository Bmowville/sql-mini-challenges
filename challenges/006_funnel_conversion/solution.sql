-- Challenge 006: Funnel conversion rates
-- Output: users at each stage + conversion rates between stages

WITH stage_users AS (
  SELECT
    event_type,
    COUNT(DISTINCT user_id) AS users
  FROM events
  WHERE event_type IN ('view', 'add_to_cart', 'purchase')
  GROUP BY event_type
),
pivot AS (
  SELECT
    MAX(CASE WHEN event_type = 'view' THEN users END)        AS view_users,
    MAX(CASE WHEN event_type = 'add_to_cart' THEN users END) AS cart_users,
    MAX(CASE WHEN event_type = 'purchase' THEN users END)    AS purchase_users
  FROM stage_users
)
SELECT
  view_users,
  cart_users,
  purchase_users,
  ROUND(1.0 * cart_users / NULLIF(view_users, 0), 4)      AS view_to_cart_rate,
  ROUND(1.0 * purchase_users / NULLIF(cart_users, 0), 4)  AS cart_to_purchase_rate,
  ROUND(1.0 * purchase_users / NULLIF(view_users, 0), 4)  AS view_to_purchase_rate
FROM pivot;
