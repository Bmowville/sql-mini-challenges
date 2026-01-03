-- Challenge 026: Repeat purchase within 30 days (cohort repeat rate)
-- Goal: for each first_purchase_month cohort, compute % of customers
-- who make a second purchase within 30 days of their first purchase.

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date TEXT NOT NULL,   -- ISO: YYYY-MM-DD
  amount_usd REAL NOT NULL
);

-- Sample data: enough variety to show repeats + non-repeats
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1, 101, '2024-01-02', 35.00),
  (2, 101, '2024-01-20', 15.00),  -- repeat within 30
  (3, 102, '2024-01-03', 50.00),
  (4, 102, '2024-02-10', 25.00),  -- repeat after 30+
  (5, 103, '2024-01-05', 20.00),
  (6, 104, '2024-01-08', 40.00),
  (7, 104, '2024-01-25', 30.00),  -- repeat within 30
  (8, 105, '2024-02-01', 60.00),
  (9, 105, '2024-02-20', 10.00),  -- repeat within 30
  (10, 106, '2024-02-05', 22.00),
  (11, 107, '2024-02-14', 18.00),
  (12, 107, '2024-03-10', 12.00), -- repeat after 30+
  (13, 108, '2024-03-01', 55.00),
  (14, 108, '2024-03-15', 15.00), -- repeat within 30
  (15, 109, '2024-03-02', 25.00),
  (16, 110, '2024-03-20', 30.00);
