-- Challenge 021: Churned customers (no orders in last 30 days)
-- Goal: find customers with prior orders but inactive recently

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
  customer_id   INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date  TEXT NOT NULL, -- ISO date YYYY-MM-DD
  amount_usd  REAL NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name) VALUES
  (101, 'Ava'),
  (102, 'Ben'),
  (103, 'Cara'),
  (104, 'Dan'),
  (105, 'Eli'),
  (106, 'Fay');

-- Mix of recent + stale customers (as_of_date will be 2024-04-01)
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1, 101, '2024-03-20', 40.0),
  (2, 101, '2024-02-10', 30.0),

  (3, 102, '2024-01-05', 120.0),

  (4, 103, '2024-03-01', 25.0),
  (5, 103, '2024-03-28', 60.0),

  (6, 104, '2023-12-15', 200.0),

  (7, 105, '2024-02-29', 55.0),

  (8, 106, '2024-03-31', 15.0);
