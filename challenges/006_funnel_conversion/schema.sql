-- Challenge 006: Funnel conversion rates
-- Goal: compute conversion rates from view -> add_to_cart -> purchase

DROP TABLE IF EXISTS events;

CREATE TABLE events (
  event_id   INTEGER PRIMARY KEY,
  user_id    INTEGER NOT NULL,
  event_date TEXT NOT NULL,   -- YYYY-MM-DD
  event_type TEXT NOT NULL    -- view, add_to_cart, purchase
);

INSERT INTO events (event_id, user_id, event_date, event_type) VALUES
  (1,  1, '2024-01-01', 'view'),
  (2,  1, '2024-01-01', 'add_to_cart'),
  (3,  1, '2024-01-02', 'purchase'),

  (4,  2, '2024-01-01', 'view'),
  (5,  2, '2024-01-03', 'add_to_cart'),

  (6,  3, '2024-01-02', 'view'),

  (7,  4, '2024-01-02', 'view'),
  (8,  4, '2024-01-02', 'add_to_cart'),
  (9,  4, '2024-01-04', 'purchase'),

  (10, 5, '2024-01-03', 'view'),
  (11, 5, '2024-01-03', 'add_to_cart'),
  (12, 6, '2024-01-04', 'view');
