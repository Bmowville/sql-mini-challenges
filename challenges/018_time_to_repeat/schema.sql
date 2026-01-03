-- Challenge 018: Time to repeat purchase (1st -> 2nd order)
-- Goal: For each customer with 2+ orders, return first_order_date, second_order_date, days_to_second

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
  customer_id   INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id     INTEGER PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  order_date   TEXT NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd   REAL NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name) VALUES
  (101, 'Ava'),
  (102, 'Ben'),
  (103, 'Cara'),
  (104, 'Dan'),
  (105, 'Eli'),
  (106, 'Fay');

-- Sample orders (some customers have only 1 order -> excluded)
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1,  101, '2024-01-03', 25.00),
  (2,  101, '2024-01-20', 40.00),
  (3,  101, '2024-02-02', 15.00),

  (4,  102, '2024-01-10', 60.00),
  (5,  102, '2024-03-05', 35.00),

  (6,  103, '2024-02-14', 22.00),  -- only 1 order (excluded)

  (7,  104, '2024-01-01', 80.00),
  (8,  104, '2024-01-02', 20.00),

  (9,  105, '2024-01-15', 12.00),
  (10, 105, '2024-01-15', 18.00),  -- same day, different order_id
  (11, 105, '2024-02-01', 50.00),

  (12, 106, '2024-04-01', 10.00);  -- only 1 order (excluded)
