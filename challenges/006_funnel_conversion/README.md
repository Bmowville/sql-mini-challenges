# Challenge 006: Funnel conversion rates

Goal: Count users at each funnel stage and compute conversion rates:
view → add_to_cart → purchase.

## Files
- `schema.sql` creates the `events` table and inserts sample data
- `solution.sql` returns stage counts + conversion rates

## Run (SQLite)
```bash
cat schema.sql solution.sql | sqlite3 -header -column :memory:
```

Windows Command Prompt:
```bat
type schema.sql solution.sql | sqlite3 -header -column :memory:
```
