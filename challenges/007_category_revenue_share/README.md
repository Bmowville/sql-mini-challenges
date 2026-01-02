# Challenge 007: Category revenue share

Goal: compute revenue by product category and each category’s percent of total revenue.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns category revenue + % of total

## Run (SQLite)
Windows CMD:
```bash
type challenges\007_category_revenue_share\schema.sql challenges\007_category_revenue_share\solution.sql | sqlite3
```
## Output

- Columns:
- category
- revenue_usd
- pct_of_total
