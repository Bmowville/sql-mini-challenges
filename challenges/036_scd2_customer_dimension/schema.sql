-- Challenge 036: SCD Type 2 (customer dimension history) in pure SQL
-- Input: change events showing customer attribute updates over time
-- Goal: produce a dimension history table with:
--   customer_id, tier, region, effective_start, effective_end, is_current
--
-- Rules:
-- - effective_start = change_date
-- - effective_end = day before next change_date for that customer (or NULL for current)
-- - is_current = 1 for the latest row per customer else 0

DROP TABLE IF EXISTS customer_changes;

CREATE TABLE customer_changes (
  change_id   INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  change_date TEXT NOT NULL,     -- YYYY-MM-DD
  tier        TEXT NOT NULL,     -- e.g., 'basic','plus','pro'
  region      TEXT NOT NULL      -- e.g., 'US','CA','UK'
);

-- Customer 1 changes tier, then region, then tier again
INSERT INTO customer_changes (change_id, customer_id, change_date, tier, region) VALUES
  (1, 1, '2024-01-01', 'basic', 'US'),
  (2, 1, '2024-02-10', 'plus',  'US'),
  (3, 1, '2024-03-05', 'plus',  'CA'),
  (4, 1, '2024-04-01', 'pro',   'CA');

-- Customer 2 changes once
INSERT INTO customer_changes (change_id, customer_id, change_date, tier, region) VALUES
  (5, 2, '2024-01-15', 'basic', 'UK'),
  (6, 2, '2024-03-20', 'plus',  'UK');

-- Customer 3 only has initial state
INSERT INTO customer_changes (change_id, customer_id, change_date, tier, region) VALUES
  (7, 3, '2024-02-01', 'basic', 'US');
