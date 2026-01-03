-- Output columns:
-- month | customer_id | customer_name | customer_month_revenue | rank_in_month
-- month_total_revenue | revenue_share_of_month | prev_month_revenue | mom_revenue_change

WITH monthly AS (
  SELECT
    strftime('%Y-%m', o.order_date) AS month,
    o.customer_id,
    SUM(o.amount_usd) AS customer_month_revenue
  FROM orders o
  GROUP BY 1, 2
),
monthly_with_names AS (
  SELECT
    m.month,
    m.customer_id,
    c.customer_name,
    m.customer_month_revenue
  FROM monthly m
  JOIN customers c
    ON c.customer_id = m.customer_id
),
ranked AS (
  SELECT
    month,
    customer_id,
    customer_name,
    customer_month_revenue,
    RANK() OVER (
      PARTITION BY month
      ORDER BY customer_month_revenue DESC
    ) AS rank_in_month,
    SUM(customer_month_revenue) OVER (PARTITION BY month) AS month_total_revenue
  FROM monthly_with_names
),
with_mom AS (
  SELECT
    month,
    customer_id,
    customer_name,
    customer_month_revenue,
    rank_in_month,
    month_total_revenue,
    ROUND(1.0 * customer_month_revenue / NULLIF(month_total_revenue, 0), 4) AS revenue_share_of_month,
    LAG(customer_month_revenue) OVER (
      PARTITION BY customer_id
      ORDER BY month
    ) AS prev_month_revenue
  FROM ranked
)
SELECT
  month,
  customer_id,
  customer_name,
  customer_month_revenue,
  rank_in_month,
  month_total_revenue,
  revenue_share_of_month,
  prev_month_revenue,
  CASE
    WHEN prev_month_revenue IS NULL THEN NULL
    ELSE ROUND(customer_month_revenue - prev_month_revenue, 2)
  END AS mom_revenue_change
FROM with_mom
WHERE rank_in_month <= 3
ORDER BY month, rank_in_month, customer_month_revenue DESC, customer_id;
