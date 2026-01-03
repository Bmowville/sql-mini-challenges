-- Output columns:
-- day | country | dau | wau_7d | new_users_7d | new_user_share | wau_change_pct

WITH RECURSIVE
bounds AS (
  SELECT
    MIN(date(event_ts)) AS start_day,
    MAX(date(event_ts)) AS end_day
  FROM events
),
date_spine(day) AS (
  SELECT start_day FROM bounds
  UNION ALL
  SELECT date(day, '+1 day')
  FROM date_spine
  JOIN bounds
  WHERE day < end_day
),
countries AS (
  SELECT DISTINCT country FROM users
),
first_seen AS (
  SELECT
    user_id,
    MIN(date(event_ts)) AS first_day
  FROM events
  GROUP BY user_id
),
daily_country AS (
  SELECT
    d.day,
    c.country,

    -- DAU: active on that exact day
    COUNT(DISTINCT CASE
      WHEN date(e.event_ts) = d.day THEN e.user_id
    END) AS dau,

    -- WAU: active in last 7 days including day
    COUNT(DISTINCT CASE
      WHEN date(e.event_ts) BETWEEN date(d.day, '-6 day') AND d.day THEN e.user_id
    END) AS wau_7d,

    -- New users in last 7 days (by first-ever activity date)
    COUNT(DISTINCT CASE
      WHEN f.first_day BETWEEN date(d.day, '-6 day') AND d.day THEN f.user_id
    END) AS new_users_7d

  FROM date_spine d
  CROSS JOIN countries c
  LEFT JOIN users u
    ON u.country = c.country
  LEFT JOIN events e
    ON e.user_id = u.user_id
  LEFT JOIN first_seen f
    ON f.user_id = u.user_id
  GROUP BY d.day, c.country
),
final AS (
  SELECT
    day,
    country,
    dau,
    wau_7d,
    new_users_7d,
    ROUND(1.0 * new_users_7d / NULLIF(wau_7d, 0), 4) AS new_user_share,
    ROUND(
      1.0 * (wau_7d - LAG(wau_7d) OVER (PARTITION BY country ORDER BY day))
      / NULLIF(LAG(wau_7d) OVER (PARTITION BY country ORDER BY day), 0),
      4
    ) AS wau_change_pct
  FROM daily_country
)
SELECT
  day,
  country,
  dau,
  wau_7d,
  new_users_7d,
  new_user_share,
  wau_change_pct
FROM final
ORDER BY country, day;
