# SQL Mini Challenges

Short SQL case studies (SQLite/Postgres style): cleaning, aggregation, window functions, and analytics.

## What’s inside
- Each challenge has a small dataset schema + a question
- Solutions are written in plain SQL
- Focus is on readable queries you could use in real work

## Challenge index
1. Passenger survival by class (Titanic-style aggregation) — [challenges/001_passenger_survival](challenges/001_passenger_survival)
2. Top customers by total spend (window function) — [challenges/002_top_customers](challenges/002_top_customers)
3. Customer retention (repeat customers by month) — [challenges/003_customer_retention](challenges/003_customer_retention)

## How to use
You can copy/paste the SQL into SQLite, Postgres, or any SQL runner with minor tweaks.

## How to run (SQLite)
Each challenge includes:
- `schema.sql` (creates tables + sample data)
- `solution.sql` (the query)

Quick run with SQLite:

```bash
sqlite3 :memory: < challenges/001_passenger_survival/schema.sql
sqlite3 :memory: < challenges/001_passenger_survival/solution.sql
```
**Or run both in one go:**

```bash
cat challenges/001_passenger_survival/schema.sql challenges/001_passenger_survival/solution.sql | sqlite3
```

### Windows (Command Prompt)

```bat
type challenges\003_customer_retention\schema.sql challenges\003_customer_retention\solution.sql | sqlite3 -header -column :memory:
```
