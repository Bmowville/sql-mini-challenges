# Challenge 026: Repeat purchase within 30 days (cohort repeat rate)

Goal: For each customer’s **first purchase month**, calculate the share of customers who make a **second purchase within 30 days** of their first order.

## Files
- `schema.sql` creates the table + inserts sample data
- `solution.sql` returns cohort repeat rate (30-day)

## Run (SQLite)

Windows CMD:

```bat
type challenges\026_repeat_purchase_30d\schema.sql challenges\026_repeat_purchase_30d\solution.sql | sqlite3
```

## Output

Columns:
- first_purchase_month
- cohort_customers
- repeat_customers_30d
- repeat_rate_30d