WITH first_orders AS (
  SELECT
    customer_id,
    MIN(order_date) AS first_order_date
  FROM orders
  GROUP BY customer_id
),
second_orders AS (
  SELECT
    o.customer_id,
    MIN(o.order_date) AS second_order_date
  FROM orders o
  JOIN first_orders f
    ON f.customer_id = o.customer_id
   AND o.order_date > f.first_order_date
  GROUP BY o.customer_id
),
cohort AS (
  SELECT
    f.customer_id,
    strftime('%Y-%m', f.first_order_date) AS first_purchase_month,
    f.first_order_date,
    s.second_order_date,
    CASE
      WHEN s.second_order_date IS NOT NULL
       AND (julianday(s.second_order_date) - julianday(f.first_order_date)) <= 30
      THEN 1 ELSE 0
    END AS repeated_within_30d
  FROM first_orders f
  LEFT JOIN second_orders s
    ON s.customer_id = f.customer_id
)
SELECT
  first_purchase_month,
  COUNT(*) AS cohort_customers,
  SUM(repeated_within_30d) AS repeat_customers_30d,
  ROUND(1.0 * SUM(repeated_within_30d) / COUNT(*), 4) AS repeat_rate_30d
FROM cohort
GROUP BY first_purchase_month
ORDER BY first_purchase_month;
