-- Challenge 030: Top customers per month (with ties) + MoM change + share of month revenue
-- Goal:
-- 1) Aggregate monthly revenue by customer
-- 2) Rank customers per month (handle ties)
-- 3) Return top 3 ranks per month (so ties can produce >3 rows)
-- 4) Include:
--    - customer_month_revenue
--    - month_total_revenue
--    - revenue_share_of_month
--    - mom_revenue_change (vs previous month for that customer)

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date TEXT NOT NULL,   -- YYYY-MM-DD
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

-- January
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (1, 101, '2024-01-03', 120.00),
  (2, 101, '2024-01-18',  80.00),  -- Ava Jan total 200
  (3, 102, '2024-01-05', 150.00),  -- Ben Jan total 150
  (4, 103, '2024-01-08', 150.00),  -- Cara Jan total 150 (tie with Ben)
  (5, 104, '2024-01-20',  90.00),  -- Dan Jan total 90
  (6, 105, '2024-01-22',  60.00);  -- Eli Jan total 60

-- February
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (7,  101, '2024-02-02', 140.00),  -- Ava Feb total 140
  (8,  102, '2024-02-06', 140.00),  -- Ben Feb total 140 (tie with Ava)
  (9,  103, '2024-02-10',  70.00),
  (10, 104, '2024-02-12', 200.00),  -- Dan Feb total 200 (top)
  (11, 105, '2024-02-25',  60.00),
  (12, 106, '2024-02-28',  60.00);

-- March
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
  (13, 101, '2024-03-01',  90.00),
  (14, 102, '2024-03-03',  50.00),
  (15, 103, '2024-03-08', 220.00),  -- Cara Mar total 220 (top)
  (16, 104, '2024-03-10', 220.00),  -- Dan Mar total 220 (tie top)
  (17, 106, '2024-03-15',  80.00),
  (18, 105, '2024-03-20',  80.00);
