# Challenge 030: Top customers per month (with ties) + MoM change + share of month

Goal:
- Aggregate monthly revenue by customer
- Rank customers per month using `RANK()` (ties allowed)
- Return top 3 ranks per month (ties can produce more than 3 rows)
- Include month total revenue, revenue share, and month-over-month change per customer

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns top customers per month with ties + MoM change

## Run (SQLite)

Windows CMD:
```bat
type challenges\030_top_customers_monthly_ties\schema.sql challenges\030_top_customers_monthly_ties\solution.sql | sqlite3
```

## Output

- Columns:
- month
- customer_id
- customer_name
- customer_month_revenue
- rank_in_month
- month_total_revenue
- revenue_share_of_month
- prev_month_revenue
- mom_revenue_change