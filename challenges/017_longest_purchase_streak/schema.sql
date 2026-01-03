-- Challenge 017: Longest consecutive monthly purchase streak
-- Goal: for each customer, find their longest streak of consecutive months with >= 1 order

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id     INTEGER PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  order_date   TEXT    NOT NULL, -- YYYY-MM-DD
  amount_usd   REAL    NOT NULL
);

-- Customer 101: Jan, Feb, Mar (3), then May (break)
-- Customer 102: Jan, Mar (no streak > 1)
-- Customer 103: Feb, Mar, Apr, May (4)
-- Customer 104: Jan, Feb (2)
INSERT INTO orders (order_id, customer_id, order_date, amount_usd) VALUES
(1, 101, '2024-01-05', 25.0),
(2, 101, '2024-02-10', 40.0),
(3, 101, '2024-03-01', 15.0),
(4, 101, '2024-05-20', 60.0),

(5, 102, '2024-01-12', 20.0),
(6, 102, '2024-03-15', 35.0),

(7, 103, '2024-02-14', 22.0),
(8, 103, '2024-03-18', 18.0),
(9, 103, '2024-04-22', 55.0),
(10,103, '2024-05-02', 44.0),

(11,104, '2024-01-11', 80.0),
(12,104, '2024-02-25', 20.0);
