# Challenge 011: Pareto customers (80/20 revenue)

Goal: compute revenue per customer, each customer’s % of total revenue, and the cumulative % so you can see who makes up the top ~80%.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns customer revenue + % of total + cumulative %

## Run (SQLite)

Windows CMD:
```bat
type challenges\011_pareto_customers\schema.sql challenges\011_pareto_customers\solution.sql | sqlite3
```

## Output

Columns:
- customer_id
- customer_name
- revenue_usd
- pct_of_total
- cum_pct_total
- in_top_80 (1 if within the first ~80% cumulative revenue)