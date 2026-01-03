-- Challenge 011: Pareto customers (80/20 revenue)
-- Goal: find which customers make up ~80% of total revenue

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id   INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date  TEXT NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd  REAL NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name) VALUES
  (101, 'Ava'),
  (102, 'Ben'),
  (103, 'Cara'),
  (104, 'Dan'),
  (105, 'Eli'),
  (106, 'Fay'),
  (107, 'Gus'),
  (108, 'Hana'),
  (109, 'Ian'),
  (110, 'Jules');

-- Make revenue concentrated (Pareto-ish)
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1,  102, '2024-02-01', 120.00),
  (2,  102, '2024-02-05',  80.00),
  (3,  102, '2024-02-10',  60.00),

  (4,  104, '2024-02-02', 200.00),
  (5,  104, '2024-02-11',  60.00),

  (6,  105, '2024-02-03',  90.00),
  (7,  105, '2024-02-09',  70.00),
  (8,  105, '2024-02-12',  30.00),

  (9,  101, '2024-02-04',  40.00),
  (10, 101, '2024-02-08',  35.00),
  (11, 101, '2024-02-13',  25.00),

  (12, 103, '2024-02-06',  45.00),
  (13, 103, '2024-02-14',  30.00),

  (14, 106, '2024-02-07',  25.00),
  (15, 107, '2024-02-07',  20.00),
  (16, 108, '2024-02-15',  18.00),
  (17, 109, '2024-02-16',  15.00),
  (18, 110, '2024-02-16',  12.00);
