-- Challenge 008: Daily revenue with missing dates (date spine)
-- Goal: show every date in range, fill missing days with 0 revenue

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  order_date  TEXT NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd  REAL NOT NULL
);

-- Sample data with gaps in dates
INSERT INTO orders (order_id, order_date, amount_usd) VALUES
  (1,  '2024-01-01', 35.0),
  (2,  '2024-01-01', 20.0),
  (3,  '2024-01-02', 15.5),
  (4,  '2024-01-04', 45.0),
  (5,  '2024-01-04', 12.0),
  (6,  '2024-01-06', 50.0),
  (7,  '2024-01-07', 28.0),
  (8,  '2024-01-10', 10.0),
  (9,  '2024-01-10', 8.0),
  (10, '2024-01-12', 22.0);
