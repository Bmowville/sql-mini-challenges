-- Challenge 023: Weekly active users (WAU)
-- Goal: count distinct active users per week (Monday-based week)

DROP TABLE IF EXISTS events;

CREATE TABLE events (
  event_id   INTEGER PRIMARY KEY,
  user_id    INTEGER NOT NULL,
  event_time TEXT    NOT NULL,  -- ISO datetime: YYYY-MM-DD HH:MM:SS
  event_type TEXT    NOT NULL
);

INSERT INTO events (event_id, user_id, event_time, event_type) VALUES
  (1, 101, '2024-01-01 09:10:00', 'open'),
  (2, 101, '2024-01-03 12:05:00', 'click'),
  (3, 102, '2024-01-04 18:20:00', 'open'),
  (4, 103, '2024-01-06 08:00:00', 'open'),

  (5, 101, '2024-01-08 10:00:00', 'open'),
  (6, 104, '2024-01-09 16:30:00', 'open'),
  (7, 102, '2024-01-12 07:50:00', 'click'),

  (8, 105, '2024-01-15 09:00:00', 'open'),
  (9, 101, '2024-01-16 11:45:00', 'click'),
  (10,106, '2024-01-18 13:15:00', 'open'),

  (11,102, '2024-01-22 08:05:00', 'open'),
  (12,107, '2024-01-23 20:10:00', 'open'),
  (13,103, '2024-01-28 14:00:00', 'click');
