-- Challenge 005: Daily revenue (grouping + date handling)
-- Goal: total revenue per day and 7-day rolling revenue

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  order_date  TEXT NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd  REAL NOT NULL
);

-- Sample data across multiple days
INSERT INTO orders (order_id, order_date, amount_usd) VALUES
  (1, '2024-01-01', 25.00),
  (2, '2024-01-01', 10.00),
  (3, '2024-01-02', 15.50),
  (4, '2024-01-03', 40.00),
  (5, '2024-01-03', 5.00),
  (6, '2024-01-04', 12.00),
  (7, '2024-01-06', 30.00),
  (8, '2024-01-07', 8.25),
  (9, '2024-01-07', 19.75),
  (10, '2024-01-08', 22.00);
