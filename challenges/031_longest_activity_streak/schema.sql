-- Challenge 031: Longest consecutive-day activity streak (gap & islands)
-- Goal: For each user, find their longest streak of consecutive active days.
-- Output should include:
--   user_id, longest_streak_days, streak_start, streak_end

DROP TABLE IF EXISTS activity;

CREATE TABLE activity (
  activity_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  activity_date TEXT NOT NULL  -- YYYY-MM-DD
);

-- Sample activity with gaps and multiple streaks
INSERT INTO activity (activity_id, user_id, activity_date) VALUES
  -- user 101: streaks 3 days (1-3), 2 days (6-7), 4 days (10-13)
  (1, 101, '2024-01-01'),
  (2, 101, '2024-01-02'),
  (3, 101, '2024-01-03'),
  (4, 101, '2024-01-06'),
  (5, 101, '2024-01-07'),
  (6, 101, '2024-01-10'),
  (7, 101, '2024-01-11'),
  (8, 101, '2024-01-12'),
  (9, 101, '2024-01-13'),

  -- user 102: streaks 1 day (2), 3 days (5-7), 3 days (10-12)
  (10, 102, '2024-01-02'),
  (11, 102, '2024-01-05'),
  (12, 102, '2024-01-06'),
  (13, 102, '2024-01-07'),
  (14, 102, '2024-01-10'),
  (15, 102, '2024-01-11'),
  (16, 102, '2024-01-12'),

  -- user 103: streaks 2 days (1-2), 1 day (4), 5 days (8-12)
  (17, 103, '2024-01-01'),
  (18, 103, '2024-01-02'),
  (19, 103, '2024-01-04'),
  (20, 103, '2024-01-08'),
  (21, 103, '2024-01-09'),
  (22, 103, '2024-01-10'),
  (23, 103, '2024-01-11'),
  (24, 103, '2024-01-12');
