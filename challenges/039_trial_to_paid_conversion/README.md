# Challenge 039: Trial to paid conversion

Goal: measure trial conversion by signup cohort and trial plan using 14-day and 30-day conversion windows.

For each signup cohort month and trial plan, calculate:
- number of trials
- users who converted to paid within 14 days
- users who converted to paid within 30 days
- 30-day conversion rate
- average days to paid conversion within 30 days
- new monthly recurring revenue from 30-day conversions

## Files
- `schema.sql` creates trial signup and paid subscription tables
- `solution.sql` finds each user's first paid subscription and rolls conversion metrics up by cohort

## Run (SQLite)

Windows CMD:
```bat
type challenges\039_trial_to_paid_conversion\schema.sql challenges\039_trial_to_paid_conversion\solution.sql | sqlite3
```

## Output

Columns:
- cohort_month
- trial_plan
- trials
- converted_14d
- converted_30d
- conversion_30d_pct
- avg_days_to_paid_30d
- new_mrr_30d