-- Output:
-- user_id | session_id | session_start | session_end | events_in_session | session_minutes

WITH ordered AS (
  SELECT
    user_id,
    event_ts,
    LAG(event_ts) OVER (PARTITION BY user_id ORDER BY event_ts) AS prev_ts
  FROM events
),
flags AS (
  SELECT
    user_id,
    event_ts,
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
    SUM(is_new_session) OVER (
      PARTITION BY user_id
      ORDER BY event_ts
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS session_id
  FROM flags
)
SELECT
  user_id,
  session_id,
  MIN(event_ts) AS session_start,
  MAX(event_ts) AS session_end,
  COUNT(*) AS events_in_session,
  CAST(ROUND((julianday(MAX(event_ts)) - julianday(MIN(event_ts))) * 24.0 * 60.0, 0) AS INT) AS session_minutes
FROM sessionized
GROUP BY user_id, session_id
ORDER BY user_id, session_id;
