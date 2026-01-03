-- Challenge 020: Retention matrix (cohort month x month number)
-- Goal: active users by months since signup

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS events;

CREATE TABLE users (
  user_id     INTEGER PRIMARY KEY,
  signup_date TEXT NOT NULL  -- ISO date: YYYY-MM-DD
);

CREATE TABLE events (
  event_id   INTEGER PRIMARY KEY,
  user_id    INTEGER NOT NULL,
  event_date TEXT NOT NULL,  -- ISO date
  event_type TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Users sign up across 3 cohorts
INSERT INTO users (user_id, signup_date) VALUES
  (101, '2024-01-05'),
  (102, '2024-01-20'),
  (103, '2024-02-02'),
  (104, '2024-02-18'),
  (105, '2024-03-03'),
  (106, '2024-03-22');

-- Events in various months (simulate activity)
INSERT INTO events (event_id, user_id, event_date, event_type) VALUES
  (1, 101, '2024-01-06', 'login'),
  (2, 101, '2024-02-10', 'login'),
  (3, 101, '2024-03-01', 'login'),

  (4, 102, '2024-01-21', 'login'),
  (5, 102, '2024-02-05', 'login'),

  (6, 103, '2024-02-03', 'login'),
  (7, 103, '2024-03-15', 'login'),

  (8, 104, '2024-02-19', 'login'),

  (9, 105, '2024-03-04', 'login'),
  (10,105, '2024-04-01', 'login'),

  (11,106, '2024-03-25', 'login'),
  (12,106, '2024-04-20', 'login'),
  (13,106, '2024-05-05', 'login');
