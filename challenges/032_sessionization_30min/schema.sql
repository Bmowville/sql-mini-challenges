-- Challenge 032: Sessionization with 30-minute inactivity gap
-- Goal:
-- For each user, split events into sessions where a new session starts
-- when the gap from the previous event is > 30 minutes.
--
-- Output (per session):
-- user_id | session_id | session_start | session_end | events_in_session | session_minutes

DROP TABLE IF EXISTS events;

CREATE TABLE events (
  event_id   INTEGER PRIMARY KEY,
  user_id    INTEGER NOT NULL,
  event_ts   TEXT NOT NULL -- ISO: YYYY-MM-DD HH:MM:SS
);

-- Sample events
INSERT INTO events (event_id, user_id, event_ts) VALUES
  -- user 101: 3 sessions
  (1, 101, '2024-01-01 09:00:00'),
  (2, 101, '2024-01-01 09:10:00'),
  (3, 101, '2024-01-01 09:45:00'),  -- gap 35 min -> new session
  (4, 101, '2024-01-01 09:55:00'),
  (5, 101, '2024-01-01 11:00:00'),  -- gap 65 min -> new session
  (6, 101, '2024-01-01 11:05:00'),

  -- user 102: 2 sessions
  (7, 102, '2024-01-02 14:00:00'),
  (8, 102, '2024-01-02 14:20:00'),
  (9, 102, '2024-01-02 14:40:00'),  -- gap 20 min -> same session
  (10,102, '2024-01-02 15:30:01'),  -- gap > 30 -> new session
  (11,102, '2024-01-02 15:40:00'),

  -- user 103: edge case (single event)
  (12,103, '2024-01-03 08:00:00');
