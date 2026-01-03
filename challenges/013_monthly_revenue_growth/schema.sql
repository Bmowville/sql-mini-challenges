-- Challenge 013: Monthly revenue growth (MoM %)
-- Goal: monthly revenue + month-over-month percent change

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  order_date  TEXT NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd  REAL NOT NULL
);

-- Sample data across multiple months
INSERT INTO orders (order_id, order_date, amount_usd) VALUES
  (1,  '2024-01-03',  50.00),
  (2,  '2024-01-12',  25.00),
  (3,  '2024-01-28',  80.00),

  (4,  '2024-02-02',  40.00),
  (5,  '2024-02-10',  60.00),
  (6,  '2024-02-22',  30.00),

  (7,  '2024-03-01',  90.00),
  (8,  '2024-03-08',  40.00),
  (9,  '2024-03-19',  20.00),
  (10, '2024-03-28',  10.00),

  (11, '2024-04-04', 120.00),
  (12, '2024-04-16',  30.00),

  (13, '2024-05-05',  70.00),
  (14, '2024-05-18',  20.00),
  (15, '2024-05-29',  40.00);
