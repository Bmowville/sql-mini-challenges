-- Challenge 027: Weekly retention (active customers by week + WoW retention rate)
-- Goal:
-- For each week, show:
--   week_start, active_customers, prev_week_active, retained_from_prev, retention_rate
-- Notes:
-- - A customer is "active" in a week if they placed >= 1 order in that week.
-- - retention_rate = retained_from_prev / prev_week_active (NULL when no prev week)

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id     INTEGER PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  order_date   TEXT    NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd   REAL    NOT NULL
);

-- Sample data across multiple weeks (with overlaps to create retention)
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1, 101, '2024-01-02', 25.00),
  (2, 102, '2024-01-03', 40.00),
  (3, 103, '2024-01-05', 15.00),

  (4, 101, '2024-01-09', 30.00),
  (5, 104, '2024-01-10', 22.00),

  (6, 101, '2024-01-16', 18.00),
  (7, 102, '2024-01-18', 55.00),
  (8, 105, '2024-01-19', 12.00),

  (9, 103, '2024-01-23', 60.00),
  (10, 105, '2024-01-24', 45.00),
  (11, 106, '2024-01-26', 10.00),

  (12, 102, '2024-01-30', 35.00),
  (13, 106, '2024-02-01', 20.00),
  (14, 107, '2024-02-02', 15.00);
