-- Challenge 009: Top products per category (window function)
-- Goal: rank products by revenue within each category and return the top 3 per category

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  product_id   INTEGER PRIMARY KEY,
  category     TEXT NOT NULL,
  product_name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id   INTEGER PRIMARY KEY,
  order_date TEXT NOT NULL   -- ISO date: YYYY-MM-DD
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

-- Products
INSERT INTO products (product_id, category, product_name) VALUES
  (1, 'apparel',     'tshirt'),
  (2, 'apparel',     'jeans'),
  (3, 'apparel',     'sneakers'),
  (4, 'apparel',     'hoodie'),
  (5, 'electronics', 'headphones'),
  (6, 'electronics', 'laptop'),
  (7, 'electronics', 'mouse'),
  (8, 'electronics', 'keyboard'),
  (9, 'home',        'lamp'),
  (10,'home',        'chair'),
  (11,'home',        'blender'),
  (12,'home',        'vacuum');

-- Orders
INSERT INTO orders (order_id, order_date) VALUES
  (101, '2024-02-01'),
  (102, '2024-02-02'),
  (103, '2024-02-03'),
  (104, '2024-02-04'),
  (105, '2024-02-05'),
  (106, '2024-02-06');

-- Order items (quantity * unit_price = revenue)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (1,  101, 1, 2, 18.00),    -- tshirt
  (2,  101, 6, 1, 950.00),   -- laptop
  (3,  101, 10,1, 120.00),   -- chair

  (4,  102, 2, 1, 55.00),    -- jeans
  (5,  102, 5, 2, 80.00),    -- headphones
  (6,  102, 9, 1, 35.00),    -- lamp

  (7,  103, 3, 1, 110.00),   -- sneakers
  (8,  103, 7, 3, 25.00),    -- mouse
  (9,  103, 11,1, 70.00),    -- blender

  (10, 104, 4, 2, 45.00),    -- hoodie
  (11, 104, 8, 1, 90.00),    -- keyboard
  (12, 104, 12,1, 180.00),   -- vacuum

  (13, 105, 5, 1, 80.00),    -- headphones
  (14, 105, 7, 2, 25.00),    -- mouse
  (15, 105, 10,1, 120.00),   -- chair

  (16, 106, 6, 1, 950.00),   -- laptop
  (17, 106, 2, 2, 55.00),    -- jeans
  (18, 106, 12,1, 180.00);   -- vacuum
