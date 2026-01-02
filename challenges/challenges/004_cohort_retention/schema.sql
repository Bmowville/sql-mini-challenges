-- Challenge 004: Cohort retention (users active by month after signup)

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS events;

CREATE TABLE users (
  user_id INTEGER PRIMARY KEY,
  signup_date TEXT NOT NULL          -- YYYY-MM-DD
);

CREATE TABLE events (
  event_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  event_date TEXT NOT NULL,          -- YYYY-MM-DD
  event_type TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, signup_date) VALUES
  (1, '2024-01-10'),
  (2, '2024-01-18'),
  (3, '2024-02-05'),
  (4, '2024-02-20'),
  (5, '2024-03-02');

-- "Active" = any event in that month
INSERT INTO events (event_id, user_id, event_date, event_type) VALUES
  (1, 1, '2024-01-15', 'login'),
  (2, 1, '2024-02-10', 'login'),
  (3, 1, '2024-03-01', 'purchase'),

  (4, 2, '2024-01-20', 'login'),
  (5, 2, '2024-02-25', 'login'),

  (6, 3, '2024-02-10', 'login'),
  (7, 3, '2024-03-12', 'login'),

  (8, 4, '2024-02-22', 'login'),

  (9, 5, '2024-03-05', 'login'),
  (10,5, '2024-04-07', 'login');
