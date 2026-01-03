-- Challenge 016: Monthly median order value
-- Goal: compute median order value per month (SQLite)

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id     INTEGER PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  order_date   TEXT    NOT NULL,  -- YYYY-MM-DD
  amount_usd   REAL    NOT NULL
);

INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
(1,  101, '2024-01-02', 25.00),
(2,  102, '2024-01-03', 40.00),
(3,  103, '2024-01-05', 15.00),
(4,  101, '2024-01-10', 80.00),
(5,  104, '2024-01-11', 20.00),
(6,  105, '2024-01-20', 55.00),

(7,  101, '2024-02-01', 35.00),
(8,  102, '2024-02-02', 120.00),
(9,  103, '2024-02-10', 18.00),
(10, 104, '2024-02-15', 60.00),
(11, 105, '2024-02-18', 42.00),

(12, 101, '2024-03-03', 99.00),
(13, 102, '2024-03-04', 10.00),
(14, 103, '2024-03-08', 12.00),
(15, 104, '2024-03-11', 65.00);
