-- Challenge 028: Rolling 7-day active users (WAU) + DAU + new users + WoW/DoD change
-- Goal: For each day and country:
--   - dau: distinct active users that day
--   - wau_7d: distinct active users in last 7 days (including day)
--   - new_users_7d: users whose first-ever activity falls in last 7 days (including day)
--   - new_user_share: new_users_7d / wau_7d
--   - wau_change_pct: percent change vs prior day wau_7d

DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id   INTEGER PRIMARY KEY,
  name      TEXT NOT NULL,
  country   TEXT NOT NULL
);

CREATE TABLE events (
  event_id    INTEGER PRIMARY KEY,
  user_id     INTEGER NOT NULL,
  event_ts    TEXT NOT NULL,   -- ISO datetime: YYYY-MM-DD HH:MM:SS
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, name, country) VALUES
  (101, 'Ava', 'US'),
  (102, 'Ben', 'US'),
  (103, 'Cara','CA'),
  (104, 'Dan', 'CA'),
  (105, 'Eli', 'US'),
  (106, 'Fay', 'UK'),
  (107, 'Gus', 'UK');

-- Events across days with gaps + repeats
INSERT INTO events (event_id, user_id, event_ts) VALUES
  (1,  101, '2024-01-01 09:10:00'),
  (2,  102, '2024-01-01 10:30:00'),
  (3,  101, '2024-01-02 08:05:00'),
  (4,  103, '2024-01-03 12:00:00'),
  (5,  104, '2024-01-04 18:20:00'),
  (6,  101, '2024-01-05 07:55:00'),
  (7,  105, '2024-01-08 13:10:00'),
  (8,  102, '2024-01-09 09:40:00'),
  (9,  103, '2024-01-10 16:15:00'),
  (10, 106, '2024-01-11 11:11:00'),
  (11, 107, '2024-01-12 20:45:00'),
  (12, 101, '2024-01-14 09:00:00'),
  (13, 104, '2024-01-14 10:00:00');
