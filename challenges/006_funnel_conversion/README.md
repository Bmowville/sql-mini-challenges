# Challenge 006: Funnel conversion rates

Goal: Count users at each funnel stage and compute conversion rates:
view → add_to_cart → purchase.

## Files
- `schema.sql` creates the `events` table and inserts sample data
- `solution.sql` returns stage counts + conversion rates

## Run (SQLite)
```bash
cat challenges/006_funnel_conversion/schema.sql challenges/006_funnel_conversion/solution.sql | sqlite3 -header -column :memory:
```

Windows Command Prompt:
```bat
type challenges\006_funnel_conversion\schema.sql challenges\006_funnel_conversion\solution.sql | sqlite3 -header -column :memory:
```
