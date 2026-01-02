-- Challenge 007: Category revenue share (% of total)
-- Goal: compute revenue by category and percent of total revenue

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS order_items;

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name TEXT NOT NULL,
  category TEXT NOT NULL,
  price_usd REAL NOT NULL
);

CREATE TABLE order_items (
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  order_date TEXT NOT NULL, -- ISO date: YYYY-MM-DD
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, category, price_usd) VALUES
  (1, 'Basic Tee', 'apparel', 15.00),
  (2, 'Hoodie', 'apparel', 45.00),
  (3, 'Mug', 'home', 12.00),
  (4, 'Notebook', 'home', 8.00),
  (5, 'Wireless Mouse', 'electronics', 25.00),
  (6, 'USB-C Cable', 'electronics', 10.00);

INSERT INTO order_items (order_id, product_id, quantity, order_date) VALUES
  (101, 1, 2, '2024-01-01'),
  (101, 3, 1, '2024-01-01'),
  (102, 2, 1, '2024-01-02'),
  (102, 6, 2, '2024-01-02'),
  (103, 5, 1, '2024-01-03'),
  (103, 6, 3, '2024-01-03'),
  (104, 4, 4, '2024-01-04'),
  (105, 1, 1, '2024-01-05'),
  (105, 2, 1, '2024-01-05'),
  (106, 3, 2, '2024-01-06'),
  (106, 5, 2, '2024-01-06');
