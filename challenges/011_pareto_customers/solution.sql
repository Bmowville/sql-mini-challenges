-- Return each customer's revenue, % of total, and cumulative % (Pareto view)

WITH customer_revenue AS (
  SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(o.amount_usd), 2) AS revenue_usd
  FROM customers c
  JOIN orders o
    ON o.customer_id = c.customer_id
  GROUP BY c.customer_id, c.customer_name
),
totals AS (
  SELECT SUM(revenue_usd) AS total_revenue
  FROM customer_revenue
),
ranked AS (
  SELECT
    cr.customer_id,
    cr.customer_name,
    cr.revenue_usd,
    ROUND(cr.revenue_usd * 1.0 / t.total_revenue, 4) AS pct_of_total,
    ROUND(
      SUM(cr.revenue_usd) OVER (
        ORDER BY cr.revenue_usd DESC, cr.customer_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) * 1.0 / t.total_revenue,
      4
    ) AS cum_pct_total
  FROM customer_revenue cr
  CROSS JOIN totals t
)
SELECT
  customer_id,
  customer_name,
  revenue_usd,
  pct_of_total,
  cum_pct_total,
  CASE WHEN cum_pct_total <= 0.80 THEN 1 ELSE 0 END AS in_top_80
FROM ranked
ORDER BY revenue_usd DESC, customer_id;
