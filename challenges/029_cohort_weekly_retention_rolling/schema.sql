-- Challenge 029: Cohort weekly retention + rolling 4-week retention
-- Goal: For each signup cohort week + region, compute weekly retention rate
-- and rolling 4-week avg retention.

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS events;

CREATE TABLE users (
  user_id     INTEGER PRIMARY KEY,
  region      TEXT NOT NULL,
  signup_date TEXT NOT NULL -- YYYY-MM-DD
);

CREATE TABLE events (
  event_id    INTEGER PRIMARY KEY,
  user_id     INTEGER NOT NULL,
  event_date  TEXT NOT NULL, -- YYYY-MM-DD
  event_type  TEXT NOT NULL,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);

-- Users (two cohorts across regions)
INSERT INTO users (user_id, region, signup_date) VALUES
  (101, 'US', '2024-01-01'),
  (102, 'US', '2024-01-03'),
  (103, 'US', '2024-01-06'),
  (104, 'CA', '2024-01-02'),
  (105, 'CA', '2024-01-06'),
  (106, 'UK', '2024-01-08'),
  (107, 'UK', '2024-01-10'),
  (108, 'US', '2024-01-09'),
  (109, 'CA', '2024-01-09'),
  (110, 'UK', '2024-01-14');

-- Events (activity spread across weeks; some users churn/return)
INSERT INTO events (event_id, user_id, event_date, event_type) VALUES
  (1, 101, '2024-01-01', 'login'),
  (2, 101, '2024-01-09', 'login'),
  (3, 101, '2024-01-16', 'login'),
  (4, 101, '2024-01-30', 'login'),

  (5, 102, '2024-01-03', 'login'),
  (6, 102, '2024-01-10', 'login'),

  (7, 103, '2024-01-06', 'login'),
  (8, 103, '2024-01-20', 'login'),

  (9, 104, '2024-01-02', 'login'),
  (10, 104, '2024-01-08', 'login'),
  (11, 104, '2024-01-22', 'login'),

  (12, 105, '2024-01-06', 'login'),
  (13, 105, '2024-01-15', 'login'),
  (14, 105, '2024-01-29', 'login'),

  (15, 106, '2024-01-08', 'login'),
  (16, 106, '2024-01-15', 'login'),

  (17, 107, '2024-01-10', 'login'),
  (18, 107, '2024-01-24', 'login'),

  (19, 108, '2024-01-09', 'login'),
  (20, 108, '2024-01-23', 'login'),

  (21, 109, '2024-01-09', 'login'),
  (22, 109, '2024-01-16', 'login'),

  (23, 110, '2024-01-14', 'login');
