-- Challenge 003: Customer retention (repeat customers by month)
-- Goal: find customers who purchased in consecutive months (retention)

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id     INTEGER PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  order_date   TEXT    NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd   REAL    NOT NULL
);

-- Sample data across multiple months
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1, 101, '2024-01-05', 25.00),
  (2, 101, '2024-02-10', 40.00),
  (3, 101, '2024-04-02', 15.00),

  (4, 102, '2024-01-20', 60.00),
  (5, 102, '2024-03-01', 35.00),

  (6, 103, '2024-02-14', 22.00),
  (7, 103, '2024-03-18', 18.00),
  (8, 103, '2024-04-22', 55.00),

  (9, 104, '2024-01-11', 80.00),
  (10,104, '2024-02-25', 20.00),

  (11,105, '2024-03-09', 44.00);

