-- Build sessions using 30-min inactivity cutoff
-- Output: user_id, session_num, session_start, session_end, duration_min, event_count, pageviews

WITH ordered AS (
  SELECT
    event_id,
    user_id,
    event_time,
    event_type,
    page,
    LAG(event_time) OVER (PARTITION BY user_id ORDER BY event_time) AS prev_time
  FROM events
),
flagged AS (
  SELECT
    *,
    CASE
      WHEN prev_time IS NULL THEN 1
      WHEN ((julianday(event_time) - julianday(prev_time)) * 1440.0) > 30.0 THEN 1
      ELSE 0
    END AS is_new_session
  FROM ordered
),
sessionized AS (
  SELECT
    *,
    SUM(is_new_session) OVER (PARTITION BY user_id ORDER BY event_time) AS session_num
  FROM flagged
)
SELECT
  user_id,
  session_num,
  MIN(event_time) AS session_start,
  MAX(event_time) AS session_end,
  ROUND((julianday(MAX(event_time)) - julianday(MIN(event_time))) * 1440.0, 2) AS duration_min,
  COUNT(*) AS event_count,
  SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS pageviews
FROM sessionized
GROUP BY user_id, session_num
ORDER BY user_id, session_num;
