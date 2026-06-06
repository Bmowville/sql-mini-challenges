# SQL Mini Challenges

[![SQL validation](https://github.com/Bmowville/sql-mini-challenges/actions/workflows/sql-validation.yml/badge.svg)](https://github.com/Bmowville/sql-mini-challenges/actions/workflows/sql-validation.yml)

Short SQL case studies (SQLite/Postgres style): cleaning, aggregation, window functions, and analytics.

## Start here
| Goal | Where to go |
| --- | --- |
| Shareable project overview | [Project site](https://bmowville.github.io/sql-mini-challenges/) |
| Find a challenge by topic | [Challenge finder](https://bmowville.github.io/sql-mini-challenges/#challenge-finder) |
| Try one challenge quickly | [001 Passenger survival](challenges/001_passenger_survival) |
| Follow a structured path | [Learning paths](docs/learning-paths.md) |
| Suggest a new challenge | [Challenge roadmap](docs/challenge-roadmap.md) |
| Add or improve a challenge | [Contributing guide](CONTRIBUTING.md) |
| Report unclear output or a broken command | [Open an issue](https://github.com/Bmowville/sql-mini-challenges/issues/new/choose) |

## What’s inside
- Each challenge has a small dataset schema + a question
- Solutions are written in plain SQL
- Focus is on readable queries you could use in real work
  
Tip: Each challenge folder includes its own README with the question, expected output, and run command.

## Skill map
| Skill area | Good starting points |
| --- | --- |
| Aggregation and ranking | 001, 002, 009, 010 |
| Retention and cohorts | 003, 004, 019, 020, 027, 029 |
| Revenue analytics | 005, 007, 011, 013, 014, 030 |
| Date spines and rolling windows | 008, 016, 028 |
| Product and customer behavior | 012, 015, 017, 018, 021, 022, 023, 024, 025, 026 |
| Data engineering SQL patterns | 035, 036, 037 |

For ordered study plans, see [Learning paths](docs/learning-paths.md).

## Challenge index
1. Passenger survival by class (Titanic-style aggregation) — [challenges/001_passenger_survival](challenges/001_passenger_survival)
2. Top customers by total spend (window function) — [challenges/002_top_customers](challenges/002_top_customers)
3. Customer retention (repeat customers by month) — [challenges/003_customer_retention](challenges/003_customer_retention)
4. Cohort retention (active users by months after signup) — [challenges/004_cohort_retention](challenges/004_cohort_retention)
5. Daily revenue (7-day rolling) — [challenges/005_daily_revenue](challenges/005_daily_revenue)
6. Funnel conversion rates (view → cart → purchase) — [challenges/006_funnel_conversion](challenges/006_funnel_conversion)
7. Category revenue share (% of total) — [challenges/007_category_revenue_share](challenges/007_category_revenue_share)
8. Daily revenue with missing dates (date spine + rolling 7 day) — [challenges/008_daily_revenue_date_spine](challenges/008_daily_revenue_date_spine)
9. Top products per category (top 3 per category) — [challenges/009_top_products_per_category](challenges/009_top_products_per_category)
10. Customer LTV (total spend + order count + rank) — [challenges/010_customer_ltv](challenges/010_customer_ltv)
11. Pareto customers (top ~80% revenue) — [challenges/011_pareto_customers](challenges/011_pareto_customers)
12. Product return rate (returns / orders) — [challenges/012_product_return_rate](challenges/012_product_return_rate)
13. Monthly revenue growth (MoM %) — [challenges/013_monthly_revenue_growth](challenges/013_monthly_revenue_growth)
14. Category monthly growth (MoM by category) — [challenges/014_category_monthly_growth](challenges/014_category_monthly_growth)
15. Sessionization (30-min inactivity rule) — [challenges/015_sessionization](challenges/015_sessionization)
16. Monthly median order value (window median in SQLite) — [challenges/016_monthly_median_order_value](challenges/016_monthly_median_order_value)
17. Longest purchase streak (consecutive months) — [challenges/017_longest_purchase_streak](challenges/017_longest_purchase_streak)
18. Time to repeat purchase (1st → 2nd order + days) — [challenges/018_time_to_repeat](challenges/018_time_to_repeat)
19. Repeat purchase within 30 days (cohort month + rate) — [challenges/019_repeat_within_30d_cohort](challenges/019_repeat_within_30d_cohort)
20. Retention matrix (cohort month x month number) — [challenges/020_retention_matrix](challenges/020_retention_matrix)
21. Churned customers (no orders in last 30 days) — [challenges/021_churned_customers](challenges/021_churned_customers)
22. Customer reactivation (returned after inactivity) — [challenges/022_customer_reactivation](challenges/022_customer_reactivation)
23. Weekly active users (WAU) — [challenges/023_weekly_active_users](challenges/023_weekly_active_users)
24. RFM segmentation (recency + frequency + monetary quartiles) — [challenges/024_rfm_segmentation](challenges/024_rfm_segmentation)
25. Signup → first purchase lag (avg + median) — [challenges/025_signup_to_first_purchase](challenges/025_signup_to_first_purchase)
26. Repeat purchase within 30 days (cohort repeat rate) — [challenges/026_repeat_purchase_30d](challenges/026_repeat_purchase_30d)
27. Weekly retention (active customers + WoW retention rate) — [challenges/027_weekly_retention](challenges/027_weekly_retention)
28. Rolling 7-day active users (date spine + region + rolling window) — [challenges/028_rolling_7d_active_users](challenges/028_rolling_7d_active_users)
29. Cohort weekly retention (rolling 4-week avg) — [challenges/029_cohort_weekly_retention_rolling](challenges/029_cohort_weekly_retention_rolling)
30. Top customers per month (ties + MoM change + share of month) — [challenges/030_top_customers_monthly_ties](challenges/030_top_customers_monthly_ties)
31. Longest consecutive activity streak (gap & islands) — [challenges/031_longest_activity_streak](challenges/031_longest_activity_streak)
32. Sessionization (30-minute inactivity gap) — [challenges/032_sessionization_30min](challenges/032_sessionization_30min)
33. Session funnel conversion (view → cart → purchase) — [challenges/033_session_funnel_conversion](challenges/033_session_funnel_conversion)
34. Reactivation cohorts (gap > 14 days) + next-month retention — [challenges/034_reactivation_cohorts](challenges/034_reactivation_cohorts)
35. Subscription renewals + missed renewals + winback (30 days) — [challenges/035_subscription_renewal_winback](challenges/035_subscription_renewal_winback)
36. SCD Type 2 customer dimension (history table) — [challenges/036_scd2_customer_dimension](challenges/036_scd2_customer_dimension)
37. Incremental fact upsert (staging → fact, insert + update) — [challenges/037_incremental_fact_upsert](challenges/037_incremental_fact_upsert)

## How to use
You can copy/paste the SQL into SQLite, Postgres, or any SQL runner with minor tweaks.

## How to run (SQLite)
Each challenge includes:
- `schema.sql` (creates tables + sample data)
- `solution.sql` (the query)
- `expected.json` (the expected columns and rows)

Quick run with SQLite:

```bash
cat challenges/001_passenger_survival/schema.sql challenges/001_passenger_survival/solution.sql | sqlite3 -header -column :memory:
```

Run another challenge by changing the folder name:

```bash
cat challenges/010_customer_ltv/schema.sql challenges/010_customer_ltv/solution.sql | sqlite3 -header -column :memory:
```

### Windows (Command Prompt)

```bat
type challenges\003_customer_retention\schema.sql challenges\003_customer_retention\solution.sql | sqlite3 -header -column :memory:
```

## Validation
The GitHub Actions workflow runs every `schema.sql` + `solution.sql` pair against SQLite and compares the actual query output with each challenge's `expected.json` snapshot. This catches both broken SQL and accidental answer changes.

Run the full validation locally:

```bash
python scripts/validate_challenges.py
```

Regenerate snapshots after intentionally changing a challenge answer:

```bash
python scripts/validate_challenges.py --write-expected
```

## Contributions
New challenge ideas and fixes are welcome. Start with the [challenge roadmap](docs/challenge-roadmap.md) for candidate ideas, then see [CONTRIBUTING.md](CONTRIBUTING.md) for the challenge format, SQL style, and validation checklist.

Last updated: 2026-06-05

