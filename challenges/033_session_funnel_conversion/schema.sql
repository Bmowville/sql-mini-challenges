-- Challenge 033: Session funnel conversion (view -> add_to_cart -> purchase)
-- Goal:
-- 1) Sessionize events using 30-minute inactivity gap
-- 2) For each session, flag whether it includes:
--      viewed, added_to_cart, purchased
-- 3) Count sessions by region and compute conversion rates:
--      view_sessions, cart_sessions, purchase_sessions
--      cart_rate_from_view, purchase_rate_from_view, purchase_rate_from_cart

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS events;

CREATE TABLE users (
  user_id INTEGER PRIMARY KEY,
  region TEXT NOT NULL
);

CREATE TABLE events (
  event_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  event_ts TEXT NOT NULL,        -- YYYY-MM-DD HH:MM:SS
  event_name TEXT NOT NULL,      -- 'view' | 'add_to_cart' | 'purchase'
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, region) VALUES
  (101, 'US'),
  (102, 'US'),
  (103, 'CA'),
  (104, 'CA'),
  (105, 'UK');

-- Events are designed to create multiple sessions and partial funnels
INSERT INTO events (event_id, user_id, event_ts, event_name) VALUES
  -- 101 (US): full funnel in one session, then view-only session
  (1, 101, '2024-01-01 09:00:00', 'view'),
  (2, 101, '2024-01-01 09:05:00', 'add_to_cart'),
  (3, 101, '2024-01-01 09:12:00', 'purchase'),
  (4, 101, '2024-01-01 10:00:00', 'view'), -- new session (>30 min gap)

  -- 102 (US): view + cart but no purchase
  (5, 102, '2024-01-02 14:00:00', 'view'),
  (6, 102, '2024-01-02 14:10:00', 'add_to_cart'),

  -- 103 (CA): purchase but missing cart (should not count as full funnel)
  (7, 103, '2024-01-03 11:00:00', 'view'),
  (8, 103, '2024-01-03 11:25:00', 'purchase'),

  -- 104 (CA): two sessions: view only, then full funnel
  (9,  104, '2024-01-04 08:00:00', 'view'),
  (10, 104, '2024-01-04 09:10:00', 'view'),        -- new session
  (11, 104, '2024-01-04 09:15:00', 'add_to_cart'),
  (12, 104, '2024-01-04 09:20:00', 'purchase'),

  -- 105 (UK): view + cart + purchase but purchase happens in next session (should not count)
  (13, 105, '2024-01-05 16:00:00', 'view'),
  (14, 105, '2024-01-05 16:10:00', 'add_to_cart'),
  (15, 105, '2024-01-05 17:00:00', 'purchase');    -- new session, purchase-only
