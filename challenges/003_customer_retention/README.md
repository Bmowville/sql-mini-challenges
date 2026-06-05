# Challenge 003 — Customer retention (consecutive months)

**Goal:** Find customers who purchased in **consecutive months**.

## Files
- `schema.sql` — creates the `orders` table and inserts sample data
- `solution.sql` — query that returns customers with back-to-back months

## Expected result (from the sample data)
You should see customers with consecutive month pairs like:

- 101: 2024-01 → 2024-02  
- 103: 2024-02 → 2024-03  
- 104: 2024-01 → 2024-02  

## Run (SQLite)
```bash
cat challenges/003_customer_retention/schema.sql challenges/003_customer_retention/solution.sql | sqlite3 -header -column :memory:
```

Windows Command Prompt:
```bat
type challenges\003_customer_retention\schema.sql challenges\003_customer_retention\solution.sql | sqlite3 -header -column :memory:
```
