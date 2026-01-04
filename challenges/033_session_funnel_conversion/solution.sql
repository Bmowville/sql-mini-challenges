-- Output columns (by region):
-- region | sessions_total | view_sessions | cart_sessions | purchase_sessions
-- cart_rate_from_view | purchase_rate_from_view | purchase_rate_from_cart

WITH ordered AS (
  SELECT
    e.user_id,
    e.event_ts,
    e.event_name,
    LAG(e.event_ts) OVER (PARTITION BY e.user_id ORDER BY e.event_ts) AS prev_ts
  FROM events e
),
flags AS (
  SELECT
    user_id,
    event_ts,
    event_name,
    CASE
      WHEN prev_ts IS NULL THEN 1
      WHEN (julianday(event_ts) - julianday(prev_ts)) * 24.0 * 60.0 > 30.0 THEN 1
      ELSE 0
    END AS is_new_session
  FROM ordered
),
sessionized AS (
  SELECT
    user_id,
    event_ts,
    event_name,
    SUM(is_new_session) OVER (
      PARTITION BY user_id
      ORDER BY event_ts
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS session_id
  FROM flags
),
session_facts AS (
  SELECT
    s.user_id,
    s.session_id,
    MAX(CASE WHEN s.event_name = 'view' THEN 1 ELSE 0 END) AS has_view,
    MAX(CASE WHEN s.event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS has_cart,
    MAX(CASE WHEN s.event_name = 'purchase' THEN 1 ELSE 0 END) AS has_purchase
  FROM sessionized s
  GROUP BY s.user_id, s.session_id
),
by_region AS (
  SELECT
    u.region,
    COUNT(*) AS sessions_total,
    SUM(has_view) AS view_sessions,
    SUM(CASE WHEN has_view = 1 AND has_cart = 1 THEN 1 ELSE 0 END) AS cart_sessions,
    SUM(CASE WHEN has_view = 1 AND has_cart = 1 AND has_purchase = 1 THEN 1 ELSE 0 END) AS purchase_sessions
  FROM session_facts f
  JOIN users u
    ON u.user_id = f.user_id
  GROUP BY u.region
)
SELECT
  region,
  sessions_total,
  view_sessions,
  cart_sessions,
  purchase_sessions,
  ROUND(1.0 * cart_sessions / NULLIF(view_sessions, 0), 4) AS cart_rate_from_view,
  ROUND(1.0 * purchase_sessions / NULLIF(view_sessions, 0), 4) AS purchase_rate_from_view,
  ROUND(1.0 * purchase_sessions / NULLIF(cart_sessions, 0), 4) AS purchase_rate_from_cart
FROM by_region
ORDER BY region;
