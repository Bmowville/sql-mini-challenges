-- Challenge 022: Customer reactivation (returned after being inactive)
-- Goal: find customers who placed an order after >= 30 days since their previous order

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id     INTEGER PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  customer_name TEXT NOT NULL,
  order_date   TEXT NOT NULL,   -- ISO date: YYYY-MM-DD
  amount_usd   REAL NOT NULL
);

INSERT INTO orders (order_id, customer_id, customer_name, order_date, amount_usd) VALUES
  (1, 101, 'Ava',  '2024-01-01', 40.0),
  (2, 101, 'Ava',  '2024-01-10', 25.0),
  (3, 101, 'Ava',  '2024-03-01', 60.0),   -- reactivation (>= 30 days)

  (4, 102, 'Ben',  '2024-01-05', 15.0),
  (5, 102, 'Ben',  '2024-02-01', 20.0),   -- 27 days (not reactivation)
  (6, 102, 'Ben',  '2024-03-10', 55.0),   -- reactivation (>= 30 days since 2024-02-01)

  (7, 103, 'Cara', '2024-02-15', 30.0),
  (8, 103, 'Cara', '2024-02-28', 10.0),   -- 13 days
  (9, 103, 'Cara', '2024-03-20', 25.0),   -- 21 days (not)

  (10, 104, 'Dan', '2024-01-01', 80.0),
  (11, 104, 'Dan', '2024-04-05', 90.0);   -- reactivation (>= 30 days)
