# Challenge 021: Churned customers (no orders in last 30 days)

Goal: List customers who have ordered before, but **haven’t ordered in the last 30 days** relative to an `as_of_date`.

In `solution.sql`, the `as_of_date` is set to `2024-04-01`.

## Files
- `schema.sql` creates tables + sample data
- `solution.sql` returns churned customers

## Run (SQLite)

Windows CMD:

```bat
type challenges\021_churned_customers\schema.sql challenges\021_churned_customers\solution.sql | sqlite3
```

## Output

Columns:
- customer_id
- customer_name
- last_order_date
- days_since_last_order