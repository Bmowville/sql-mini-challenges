-- Challenge 025: Signup to first purchase
-- Goal: for each user, find days from signup to first purchase (or NULL if never purchased)

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS orders;

CREATE TABLE users (
  user_id     INTEGER PRIMARY KEY,
  user_name   TEXT NOT NULL,
  signup_date TEXT NOT NULL  -- ISO: YYYY-MM-DD
);

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  user_id     INTEGER NOT NULL,
  order_date  TEXT NOT NULL, -- ISO: YYYY-MM-DD
  amount_usd  REAL NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Users
INSERT INTO users (user_id, user_name, signup_date) VALUES
(101, 'Ava',  '2024-01-01'),
(102, 'Ben',  '2024-01-03'),
(103, 'Cara', '2024-01-05'),
(104, 'Dan',  '2024-01-08'),
(105, 'Eli',  '2024-01-10'),
(106, 'Fay',  '2024-01-12'),
(107, 'Gus',  '2024-01-15'),
(108, 'Hana', '2024-01-20');

-- Orders (some users never purchase)
INSERT INTO orders (order_id, user_id, order_date, amount_usd) VALUES
(1,  101, '2024-01-02', 35.00),
(2,  101, '2024-01-18', 20.00),

(3,  102, '2024-01-20', 50.00),

(4,  103, '2024-01-06', 15.00),
(5,  103, '2024-02-01', 25.00),

(6,  104, '2024-01-25', 40.00),

(7,  105, '2024-02-15', 60.00),

(8,  106, '2024-01-13', 18.00),

(9,  108, '2024-02-05', 22.00);
