-- Output columns:
-- order_id | expected_amount | successful_payments | duplicate_successful_payments | completed_refunds | net_collected | variance | issue_type

WITH item_totals AS (
  SELECT
    order_id,
    SUM(quantity * unit_price) AS item_total
  FROM order_items
  GROUP BY order_id
),
discount_totals AS (
  SELECT
    order_id,
    SUM(discount_amount) AS discount_total
  FROM order_discounts
  GROUP BY order_id
),
payment_totals AS (
  SELECT
    order_id,
    COUNT(*) AS successful_payments,
    COUNT(*) - COUNT(DISTINCT payment_ref) AS duplicate_successful_payments,
    SUM(amount) AS successful_payment_amount
  FROM payments
  WHERE status = 'succeeded'
  GROUP BY order_id
),
refund_totals AS (
  SELECT
    order_id,
    SUM(refund_amount) AS completed_refunds
  FROM refunds
  WHERE status = 'completed'
  GROUP BY order_id
),
audit_base AS (
  SELECT
    o.order_id,
    ROUND((it.item_total - COALESCE(dt.discount_total, 0)) * (1 + o.tax_rate), 2) AS expected_amount,
    COALESCE(pt.successful_payments, 0) AS successful_payments,
    COALESCE(pt.duplicate_successful_payments, 0) AS duplicate_successful_payments,
    COALESCE(rt.completed_refunds, 0) AS completed_refunds,
    ROUND(COALESCE(pt.successful_payment_amount, 0) - COALESCE(rt.completed_refunds, 0), 2) AS net_collected
  FROM orders o
  JOIN item_totals it ON it.order_id = o.order_id
  LEFT JOIN discount_totals dt ON dt.order_id = o.order_id
  LEFT JOIN payment_totals pt ON pt.order_id = o.order_id
  LEFT JOIN refund_totals rt ON rt.order_id = o.order_id
  WHERE o.status = 'completed'
),
classified AS (
  SELECT
    order_id,
    expected_amount,
    successful_payments,
    duplicate_successful_payments,
    completed_refunds,
    net_collected,
    ROUND(net_collected - expected_amount, 2) AS variance,
    CASE
      WHEN successful_payments = 0 THEN 'missing_payment'
      WHEN duplicate_successful_payments > 0 THEN 'duplicate_payment'
      WHEN net_collected - expected_amount < -0.01 THEN 'underpaid'
      WHEN net_collected - expected_amount > 0.01 THEN 'overpaid'
      ELSE 'ok'
    END AS issue_type
  FROM audit_base
)
SELECT
  order_id,
  expected_amount,
  successful_payments,
  duplicate_successful_payments,
  completed_refunds,
  net_collected,
  variance,
  issue_type
FROM classified
WHERE issue_type <> 'ok'
ORDER BY order_id;