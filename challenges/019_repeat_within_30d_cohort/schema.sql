-- Challenge 019: Repeat purchase within 30 days (cohort by first purchase month)
-- Goal: For each cohort month (customer's first order month), compute % who ordered again within 30 days

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
  customer_id   INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id     INTEGER PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  order_date   TEXT NOT NULL,   -- ISO: YYYY-MM-DD
  amount_usd   REAL NOT NULL,
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
  (108, 'Hana');

-- Mix of first orders across Jan/Feb/Mar, with some repeats within 30 days and some not
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  -- Jan cohort
  (1,  101, '2024-01-03', 25.00),
  (2,  101, '2024-01-20', 40.00),   -- within 30d (17 days)
  (3,  102, '2024-01-10', 60.00),
  (4,  102, '2024-03-05', 35.00),   -- NOT within 30d (55 days)
  (5,  103, '2024-01-15', 20.00),   -- no repeat

  -- Feb cohort
  (6,  104, '2024-02-01', 80.00),
  (7,  104, '2024-02-25', 20.00),   -- within 30d (24 days)
  (8,  105, '2024-02-10', 12.00),
  (9,  105, '2024-03-15', 18.00),   -- NOT within 30d (34 days)
  (10, 106, '2024-02-14', 22.00),   -- no repeat

  -- Mar cohort
  (11, 107, '2024-03-05', 15.00),
  (12, 107, '2024-03-20', 30.00),   -- within 30d (15 days)
  (13, 108, '2024-03-25', 50.00);   -- no repeat
