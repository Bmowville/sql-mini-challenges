-- Challenge 012: Product return rate
-- Goal: compute return rate per product (returns / orders)

DROP TABLE IF EXISTS returns;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  product_id   INTEGER PRIMARY KEY,
  product_name TEXT NOT NULL,
  category     TEXT NOT NULL
);

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  order_date  TEXT NOT NULL  -- ISO date
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

-- One return record per returned order_item_id
CREATE TABLE returns (
  return_id     INTEGER PRIMARY KEY,
  order_item_id INTEGER NOT NULL,
  return_date   TEXT NOT NULL,  -- ISO date
  reason        TEXT NOT NULL,
  FOREIGN KEY(order_item_id) REFERENCES order_items(order_item_id)
);

INSERT INTO products (product_id, product_name, category) VALUES
  (1, 'tshirt',     'apparel'),
  (2, 'jeans',      'apparel'),
  (3, 'headphones', 'electronics'),
  (4, 'mouse',      'electronics'),
  (5, 'chair',      'home'),
  (6, 'vacuum',     'home');

INSERT INTO orders (order_id, order_date) VALUES
  (101, '2024-03-01'),
  (102, '2024-03-02'),
  (103, '2024-03-03'),
  (104, '2024-03-04'),
  (105, '2024-03-05'),
  (106, '2024-03-06'),
  (107, '2024-03-07'),
  (108, '2024-03-08');

-- order_items (treat each row as a purchased line; return rate based on line-count, not quantity)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (1,  101, 1, 2, 18.00),   -- tshirt
  (2,  101, 3, 1, 80.00),   -- headphones
  (3,  102, 2, 1, 55.00),   -- jeans
  (4,  102, 4, 1, 25.00),   -- mouse
  (5,  103, 5, 1, 120.00),  -- chair
  (6,  103, 1, 1, 18.00),   -- tshirt
  (7,  104, 6, 1, 180.00),  -- vacuum
  (8,  104, 3, 1, 80.00),   -- headphones
  (9,  105, 4, 2, 25.00),   -- mouse (qty 2, still 1 line)
  (10, 105, 2, 1, 55.00),   -- jeans
  (11, 106, 1, 1, 18.00),   -- tshirt
  (12, 106, 5, 1, 120.00),  -- chair
  (13, 107, 3, 1, 80.00),   -- headphones
  (14, 107, 6, 1, 180.00),  -- vacuum
  (15, 108, 2, 1, 55.00),   -- jeans
  (16, 108, 4, 1, 25.00);   -- mouse

-- Returns (some products have higher return rate)
INSERT INTO returns (return_id, order_item_id, return_date, reason) VALUES
  (1,  2,  '2024-03-10', 'defective'),    -- headphones
  (2,  8,  '2024-03-12', 'defective'),    -- headphones
  (3,  13, '2024-03-13', 'defective'),    -- headphones

  (4,  3,  '2024-03-11', 'size'),         -- jeans
  (5,  10, '2024-03-14', 'size'),         -- jeans

  (6,  9,  '2024-03-15', 'not as described'), -- mouse
  (7,  5,  '2024-03-16', 'damaged');          -- chair
