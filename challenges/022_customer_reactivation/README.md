# Challenge 022: Customer reactivation

Goal: find customers who placed an order after being inactive for **30+ days** since their previous order.

## Files
- `schema.sql` creates the table and inserts sample data
- `solution.sql` finds reactivated customers and the inactive gap in days

## Run (SQLite)

Windows CMD:
```bat
type challenges\022_customer_reactivation\schema.sql challenges\022_customer_reactivation\solution.sql | sqlite3
```

## Output

Columns:
- customer_id
- customer_name
- prev_order_date
- reactivated_order_date
- days_inactive