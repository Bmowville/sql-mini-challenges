-- Challenge 024: RFM segmentation
-- Goal: compute Recency / Frequency / Monetary per customer and score each metric into quartiles.

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date TEXT NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd REAL NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name) VALUES
  (101, 'Ava'),
  (102, 'Ben'),
  (103, 'Cara'),
  (104, 'Dan'),
  (105, 'Eli'),
  (106, 'Fay');

-- Sample orders (latest date in data becomes the reference "today")
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1, 101, '2024-01-05', 40.00),
  (2, 101, '2024-02-10', 35.00),
  (3, 101, '2024-03-18', 60.00),

  (4, 102, '2024-01-12', 15.00),
  (5, 102, '2024-03-01', 25.00),

  (6, 103, '2024-02-05', 120.00),
  (7, 103, '2024-02-20', 60.00),

  (8, 104, '2024-01-25', 200.00),

  (9, 105, '2024-03-15', 30.00),
  (10, 105, '2024-03-20', 45.00),

  (11, 106, '2024-01-02', 10.00);
