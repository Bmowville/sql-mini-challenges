-- Challenge 010: Customer LTV (lifetime value)
-- Goal: total revenue per customer + rank customers by LTV

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date TEXT NOT NULL, -- ISO date: YYYY-MM-DD
  amount_usd REAL NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name) VALUES
  (101, 'Ava'),
  (102, 'Ben'),
  (103, 'Cara'),
  (104, 'Dan'),
  (105, 'Eli');

-- Sample purchases (multiple orders per customer)
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1, 101, '2024-01-03', 35.00),
  (2, 101, '2024-01-18', 60.00),
  (3, 101, '2024-02-11', 20.00),

  (4, 102, '2024-01-05', 120.00),
  (5, 102, '2024-03-01', 80.00),

  (6, 103, '2024-02-02', 15.00),
  (7, 103, '2024-02-20', 25.00),
  (8, 103, '2024-03-15', 40.00),
  (9, 103, '2024-04-01', 10.00),

  (10, 104, '2024-01-09', 200.00),

  (11, 105, '2024-01-12', 55.00),
  (12, 105, '2024-01-29', 45.00),
  (13, 105, '2024-02-10', 90.00);
