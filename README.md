# SQL Mini Challenges

Short SQL case studies (SQLite/Postgres style): cleaning, aggregation, window functions, and analytics.

## What’s inside
- Each challenge has a small dataset schema + a question
- Solutions are written in plain SQL
- Focus is on readable queries you could use in real work
  
Tip: each challenge folder includes its own README with the question, expected output, and run command.

## Challenge index
1. Passenger survival by class (Titanic-style aggregation) — [challenges/001_passenger_survival](challenges/001_passenger_survival)
2. Top customers by total spend (window function) — [challenges/002_top_customers](challenges/002_top_customers)
3. Customer retention (repeat customers by month) — [challenges/003_customer_retention](challenges/003_customer_retention)
4. Cohort retention (active users by months after signup) — [challenges/004_cohort_retention](challenges/004_cohort_retention)
5. Daily revenue (7-day rolling) — [challenges/005_daily_revenue](challenges/005_daily_revenue)
6. Funnel conversion rates (view → cart → purchase) — [challenges/006_funnel_conversion](challenges/006_funnel_conversion)
7. Category revenue share (% of total) — [challenges/007_category_revenue_share](challenges/007_category_revenue_share)
8. Daily revenue with missing dates (date spine + rolling 7 day) — [challenges/008_daily_revenue_date_spine](challenges/008_daily_revenue_date_spine)

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

Last updated: 2026-01-02

