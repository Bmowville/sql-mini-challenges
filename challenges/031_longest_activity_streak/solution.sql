-- Output columns:
-- user_id | longest_streak_days | streak_start | streak_end

WITH dedup AS (
  -- Safety: if the table ever has multiple rows per user per day
  SELECT DISTINCT
    user_id,
    date(activity_date) AS activity_date
  FROM activity
),
numbered AS (
  SELECT
    user_id,
    activity_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY activity_date) AS rn
  FROM dedup
),
islands AS (
  -- Gap & islands trick:
  -- For consecutive days, (julianday(date) - rn) stays constant
  SELECT
    user_id,
    activity_date,
    rn,
    (julianday(activity_date) - rn) AS island_key
  FROM numbered
),
streaks AS (
  SELECT
    user_id,
    MIN(activity_date) AS streak_start,
    MAX(activity_date) AS streak_end,
    COUNT(*) AS streak_days
  FROM islands
  GROUP BY user_id, island_key
),
ranked AS (
  SELECT
    user_id,
    streak_days,
    streak_start,
    streak_end,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY streak_days DESC, streak_start ASC
    ) AS pick_one
  FROM streaks
)
SELECT
  user_id,
  streak_days AS longest_streak_days,
  streak_start,
  streak_end
FROM ranked
WHERE pick_one = 1
ORDER BY user_id;
