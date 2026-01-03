-- Challenge 014: Category monthly growth (monthly revenue per category + MoM %)
-- Goal: monthly revenue per category + month-over-month growth per category

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS products;

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  order_date  TEXT NOT NULL   -- ISO date: YYYY-MM-DD
);

CREATE TABLE products (
  product_id   INTEGER PRIMARY KEY,
  category     TEXT NOT NULL,
  product_name TEXT NOT NULL
);

CREATE TABLE order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id      INTEGER NOT NULL,
  product_id    INTEGER NOT NULL,
  quantity      INTEGER NOT NULL,
  unit_price    REAL NOT NULL,
  FOREIGN KEY(order_id) REFERENCES orders(order_id),
  FOREIGN KEY(product_id) REFERENCES products(product_id)
);

-- Products (3 categories)
INSERT INTO products (product_id, category, product_name) VALUES
  (1,  'apparel',      'tshirt'),
  (2,  'apparel',      'jeans'),
  (3,  'apparel',      'sneakers'),
  (4,  'electronics',  'mouse'),
  (5,  'electronics',  'headphones'),
  (6,  'electronics',  'laptop'),
  (7,  'home',         'lamp'),
  (8,  'home',         'chair'),
  (9,  'home',         'vacuum');

-- Orders across months (Jan -> May)
INSERT INTO orders (order_id, order_date) VALUES
  (101, '2024-01-10'),
  (102, '2024-01-22'),

  (201, '2024-02-05'),
  (202, '2024-02-18'),

  (301, '2024-03-03'),
  (302, '2024-03-21'),

  (401, '2024-04-07'),
  (402, '2024-04-25'),

  (501, '2024-05-11'),
  (502, '2024-05-27');

-- Order items (revenue = quantity * unit_price)
-- Jan totals:
-- apparel 120, electronics 180, home 100
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (1, 101, 1, 2, 20.00),   -- apparel 40
  (2, 101, 4, 3, 30.00),   -- electronics 90
  (3, 101, 8, 1, 60.00),   -- home 60
  (4, 102, 2, 1, 80.00),   -- apparel 80
  (5, 102, 5, 1, 90.00),   -- electronics 90
  (6, 102, 7, 2, 20.00);   -- home 40

-- Feb totals:
-- apparel 150, electronics 120, home 80
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (7,  201, 3, 1, 100.00), -- apparel 100
  (8,  201, 4, 2, 20.00),  -- electronics 40
  (9,  201, 9, 1, 50.00),  -- home 50
  (10, 202, 1, 1, 50.00),  -- apparel 50
  (11, 202, 5, 2, 40.00),  -- electronics 80
  (12, 202, 7, 3, 10.00);  -- home 30

-- Mar totals:
-- apparel 90, electronics 300, home 70
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (13, 301, 2, 1, 90.00),  -- apparel 90
  (14, 301, 6, 1, 200.00), -- electronics 200
  (15, 301, 8, 1, 70.00),  -- home 70
  (16, 302, 5, 1, 100.00); -- electronics 100

-- Apr totals:
-- apparel 180, electronics 200, home 120
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (17, 401, 3, 2, 90.00),  -- apparel 180
  (18, 401, 4, 4, 25.00),  -- electronics 100
  (19, 401, 7, 1, 30.00),  -- home 30
  (20, 402, 5, 1, 100.00), -- electronics 100
  (21, 402, 9, 1, 90.00);  -- home 90

-- May totals:
-- apparel 120, electronics 260, home 80
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (22, 501, 1, 3, 20.00),  -- apparel 60
  (23, 501, 6, 1, 180.00), -- electronics 180
  (24, 501, 8, 1, 80.00),  -- home 80
  (25, 502, 2, 1, 60.00),  -- apparel 60
  (26, 502, 5, 2, 40.00);  -- electronics 80
