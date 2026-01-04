-- Challenge 035: Subscription renewals, missed renewals, and winback within 30 days
-- Scenario:
-- A subscription "billing cycle" is 30 days.
-- For each user, we have payment dates (when they paid).
--
-- Definitions:
-- - "on_time_renewal": next payment happens 25 to 35 days after prior payment (tolerance window)
-- - "missed_renewal": no on-time renewal after a payment
-- - "winback_30d": after a missed renewal, user pays again within 30 days after the expected renewal date
--
-- Output per user:
-- user_id | cycles | on_time_renewals | missed_renewals | winbacks_30d

DROP TABLE IF EXISTS payments;

CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  paid_date TEXT NOT NULL  -- YYYY-MM-DD
);

INSERT INTO payments (payment_id, user_id, paid_date) VALUES
  -- user 201: renews on time twice, then misses and never returns
  (1, 201, '2024-01-01'),
  (2, 201, '2024-01-31'), -- 30 days (on time)
  (3, 201, '2024-03-01'), -- 30 days (on time)

  -- user 202: misses renewal but winbacks within 30 days of expected renewal
  (4, 202, '2024-01-05'),
  (5, 202, '2024-02-10'), -- 36 days (outside tolerance => missed renewal for Jan 5 cycle)
  -- expected renewal date: 2024-02-04; winback window: 2024-02-04..2024-03-05 (30d)
  -- 2024-02-10 is within that => winback_30d

  -- user 203: late payment but NOT within winback window (too late)
  (6, 203, '2024-01-10'),
  (7, 203, '2024-03-20'), -- expected 2024-02-09; winback window ends 2024-03-10

  -- user 204: messy history: on-time, then missed, then winback, then on-time again
  (8,  204, '2024-01-01'),
  (9,  204, '2024-01-30'), -- 29 days on time
  (10, 204, '2024-03-10'), -- expected 2024-02-29; this is 40 days after Jan 30 => missed renewal
  -- winback window from expected 2024-02-29 to 2024-03-30 -> 2024-03-10 qualifies as winback
  (11, 204, '2024-04-09'); -- 30 days from 2024-03-10 (on time)
