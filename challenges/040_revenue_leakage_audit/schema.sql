-- Challenge 040: Revenue leakage audit
--
-- Scenario:
-- A finance/data team needs to reconcile completed orders against payments and refunds.
-- Expected order amount comes from item totals minus discounts, plus tax.
-- Net collected comes from successful payments minus completed refunds.
--
-- Output only orders with an issue:
-- order_id | expected_amount | successful_payments | duplicate_successful_payments | completed_refunds | net_collected | variance | issue_type

DROP TABLE IF EXISTS refunds;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_discounts;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date TEXT NOT NULL,
  status TEXT NOT NULL,
  tax_rate REAL NOT NULL
);

CREATE TABLE order_items (
  item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  sku TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price REAL NOT NULL
);

CREATE TABLE order_discounts (
  discount_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  discount_amount REAL NOT NULL,
  reason TEXT NOT NULL
);

CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  payment_ref TEXT NOT NULL,
  paid_at TEXT NOT NULL,
  amount REAL NOT NULL,
  status TEXT NOT NULL
);

CREATE TABLE refunds (
  refund_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  refund_amount REAL NOT NULL,
  status TEXT NOT NULL
);

INSERT INTO orders (order_id, customer_id, order_date, status, tax_rate) VALUES
  (501, 1001, '2024-04-01', 'completed', 0.08),
  (502, 1002, '2024-04-02', 'completed', 0.08),
  (503, 1003, '2024-04-03', 'completed', 0.10),
  (504, 1004, '2024-04-04', 'completed', 0.08),
  (505, 1005, '2024-04-05', 'completed', 0.08),
  (506, 1006, '2024-04-06', 'completed', 0.08);

INSERT INTO order_items (item_id, order_id, sku, quantity, unit_price) VALUES
  (1, 501, 'KIT-A', 2, 50.00),
  (2, 502, 'KIT-B', 1, 80.00),
  (3, 503, 'KIT-C', 3, 40.00),
  (4, 504, 'KIT-D', 1, 60.00),
  (5, 505, 'KIT-E', 1, 200.00),
  (6, 506, 'KIT-F', 1, 30.00);

INSERT INTO order_discounts (discount_id, order_id, discount_amount, reason) VALUES
  (1, 501, 10.00, 'promo'),
  (2, 503, 20.00, 'retention_credit');

INSERT INTO payments (payment_id, order_id, payment_ref, paid_at, amount, status) VALUES
  (1, 501, 'pay-501', '2024-04-01 10:15:00', 97.20, 'succeeded'),
  (2, 502, 'pay-502-failed', '2024-04-02 11:00:00', 86.40, 'failed'),
  (3, 503, 'pay-503', '2024-04-03 12:05:00', 90.00, 'succeeded'),
  (4, 504, 'pay-504', '2024-04-04 09:30:00', 64.80, 'succeeded'),
  (5, 504, 'pay-504', '2024-04-04 09:31:00', 64.80, 'succeeded'),
  (6, 505, 'pay-505', '2024-04-05 14:20:00', 216.00, 'succeeded'),
  (7, 506, 'pay-506', '2024-04-06 16:45:00', 40.00, 'succeeded');

INSERT INTO refunds (refund_id, order_id, refund_amount, status) VALUES
  (1, 505, 50.00, 'completed'),
  (2, 501, 10.00, 'voided');