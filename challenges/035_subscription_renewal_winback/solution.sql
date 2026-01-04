-- Output per user:
-- user_id | cycles | on_time_renewals | missed_renewals | winbacks_30d
--
-- Notes:
-- - "cycle" here means each payment that should be followed by an on-time renewal.
-- - The last payment for a user is treated as a cycle that may be missed (no future payment).

WITH ordered AS (
  SELECT
    user_id,
    date(paid_date) AS paid_date,
    LEAD(date(paid_date)) OVER (PARTITION BY user_id ORDER BY date(paid_date)) AS next_paid_date
  FROM payments
),
expected AS (
  SELECT
    user_id,
    paid_date,
    next_paid_date,
    date(paid_date, '+30 day') AS expected_renewal_date,
    date(paid_date, '+25 day') AS on_time_start,
    date(paid_date, '+35 day') AS on_time_end,
    date(paid_date, '+60 day') AS winback_end -- expected + 30 days
  FROM ordered
),
classified AS (
  SELECT
    user_id,
    paid_date,
    expected_renewal_date,
    next_paid_date,
    CASE
      WHEN next_paid_date IS NOT NULL
       AND next_paid_date BETWEEN on_time_start AND on_time_end
      THEN 1 ELSE 0
    END AS is_on_time_renewal,
    CASE
      -- missed renewal if no next payment in on-time window
      WHEN next_paid_date IS NULL THEN 1
      WHEN next_paid_date NOT BETWEEN on_time_start AND on_time_end THEN 1
      ELSE 0
    END AS is_missed_renewal,
    CASE
      -- winback if missed renewal AND a next payment exists within 30 days after expected renewal
      WHEN (
        (next_paid_date IS NULL) OR (next_paid_date NOT BETWEEN on_time_start AND on_time_end)
      )
      AND next_paid_date IS NOT NULL
      AND next_paid_date >= expected_renewal_date
      AND next_paid_date <= winback_end
      THEN 1 ELSE 0
    END AS is_winback_30d
  FROM expected
),
by_user AS (
  SELECT
    user_id,
    COUNT(*) AS cycles,
    SUM(is_on_time_renewal) AS on_time_renewals,
    SUM(is_missed_renewal) AS missed_renewals,
    SUM(is_winback_30d) AS winbacks_30d
  FROM classified
  GROUP BY user_id
)
SELECT
  user_id,
  cycles,
  on_time_renewals,
  missed_renewals,
  winbacks_30d
FROM by_user
ORDER BY user_id;
