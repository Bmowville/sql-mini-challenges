-- Challenge 034: Reactivation cohorts (gap > 14 days) + retention after reactivation
-- Definitions:
-- - A "reactivation" happens when a user has an event after being inactive for > 14 days.
-- - The reactivation_cohort is the month (YYYY-MM) of that reactivation date.
-- Goal output:
-- reactivation_month | users_reactivated | retained_next_month | retention_rate_next_month

DROP TABLE IF EXISTS events;

CREATE TABLE events (
  event_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  event_date TEXT NOT NULL   -- YYYY-MM-DD
);

-- Sample data with gaps > 14 days and multiple reactivations possible
INSERT INTO events (event_id, user_id, event_date) VALUES
  -- user 101: active, then gap 20 days, returns, then returns next month
  (1, 101, '2024-01-01'),
  (2, 101, '2024-01-05'),
  (3, 101, '2024-01-25'),  -- reactivation (gap 20 days)
  (4, 101, '2024-02-03'),  -- retained next month

  -- user 102: gap 16 days, reactivates, but no next-month activity
  (5, 102, '2024-01-02'),
  (6, 102, '2024-01-18'),  -- reactivation (gap 16 days)

  -- user 103: no big gap (not a reactivation)
  (7, 103, '2024-01-03'),
  (8, 103, '2024-01-10'),
  (9, 103, '2024-01-20'),

  -- user 104: long gap crossing months, reactivates in Feb, then active in Mar
  (10,104, '2024-01-04'),
  (11,104, '2024-02-10'),  -- reactivation (gap > 14)
  (12,104, '2024-03-02'),  -- retained next month (Mar)

  -- user 105: multiple reactivations; we count each reactivation event separately
  (13,105, '2024-01-01'),
  (14,105, '2024-01-30'),  -- reactivation (gap 29)
  (15,105, '2024-02-20'),  -- reactivation again (gap 21)
  (16,105, '2024-03-01');  -- retained next month after Feb reactivation
