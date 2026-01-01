-- Challenge 002: Top customers by total spend (window function)

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id TEXT NOT NULL,
  order_date TEXT NOT NULL,   -- ISO date string
  amount_usd REAL NOT NULL
);

INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1, 'C001', '2026-01-01', 24.50),
  (2, 'C002', '2026-01-02', 120.00),
  (3, 'C001', '2026-01-03', 75.25),
  (4, 'C003', '2026-01-03', 10.00),
  (5, 'C002', '2026-01-04', 15.00),
  (6, 'C004', '2026-01-04', 300.00),
  (7, 'C003', '2026-01-05', 80.00),
  (8, 'C005', '2026-01-05', 55.00);
