-- Challenge 038: Inventory stockout risk
--
-- Scenario:
-- A warehouse team wants to find products that may stock out before replenishment.
-- Combine recent sales velocity, current available inventory, supplier lead time,
-- safety stock, and the next open purchase order.
--
-- Use as-of date: 2024-05-15
-- Recent sales window: 2024-05-09 through 2024-05-15
--
-- Output per product:
-- product_id | sku | net_available_units | recent_7d_units | avg_daily_units | days_of_cover | next_open_po_date | risk_level

DROP TABLE IF EXISTS purchase_orders;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  sku TEXT NOT NULL,
  category TEXT NOT NULL,
  lead_time_days INTEGER NOT NULL,
  safety_stock_units INTEGER NOT NULL
);

CREATE TABLE inventory (
  product_id INTEGER PRIMARY KEY,
  on_hand_units INTEGER NOT NULL,
  reserved_units INTEGER NOT NULL
);

CREATE TABLE sales (
  sale_id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL,
  sold_date TEXT NOT NULL,
  units_sold INTEGER NOT NULL
);

CREATE TABLE purchase_orders (
  po_id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL,
  due_date TEXT NOT NULL,
  units_ordered INTEGER NOT NULL,
  status TEXT NOT NULL
);

INSERT INTO products (product_id, sku, category, lead_time_days, safety_stock_units) VALUES
  (101, 'WIDGET-A', 'widgets', 10, 20),
  (102, 'FILTER-B', 'filters', 6, 10),
  (103, 'PUMP-C', 'pumps', 14, 15),
  (104, 'SENSOR-D', 'sensors', 7, 5);

INSERT INTO inventory (product_id, on_hand_units, reserved_units) VALUES
  (101, 72, 12),
  (102, 130, 10),
  (103, 65, 15),
  (104, 8, 0);

INSERT INTO sales (sale_id, product_id, sold_date, units_sold) VALUES
  (1, 101, '2024-05-02', 30),
  (2, 101, '2024-05-09', 8),
  (3, 101, '2024-05-10', 10),
  (4, 101, '2024-05-11', 12),
  (5, 101, '2024-05-12', 9),
  (6, 101, '2024-05-13', 11),
  (7, 101, '2024-05-14', 10),
  (8, 101, '2024-05-15', 10),
  (9, 102, '2024-05-09', 4),
  (10, 102, '2024-05-10', 8),
  (11, 102, '2024-05-12', 6),
  (12, 102, '2024-05-14', 10),
  (13, 102, '2024-05-15', 14),
  (14, 103, '2024-05-09', 2),
  (15, 103, '2024-05-10', 3),
  (16, 103, '2024-05-11', 4),
  (17, 103, '2024-05-12', 3),
  (18, 103, '2024-05-14', 5),
  (19, 103, '2024-05-15', 4),
  (20, 104, '2024-05-07', 5);

INSERT INTO purchase_orders (po_id, product_id, due_date, units_ordered, status) VALUES
  (1, 101, '2024-05-22', 80, 'open'),
  (2, 101, '2024-06-05', 120, 'open'),
  (3, 102, '2024-05-25', 60, 'open'),
  (4, 102, '2024-05-18', 30, 'closed'),
  (5, 103, '2024-06-01', 40, 'open'),
  (6, 104, '2024-05-25', 20, 'open');