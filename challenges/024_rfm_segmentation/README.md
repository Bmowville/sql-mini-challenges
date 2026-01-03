# Challenge 024: RFM segmentation

Goal: compute Recency / Frequency / Monetary per customer, then score each into quartiles (1–4) using window functions.

## Files

- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns RFM metrics + quartile scores + a combined segment code

## Run (SQLite)

Windows CMD:

```bat
type challenges\024_rfm_segmentation\schema.sql challenges\024_rfm_segmentation\solution.sql | sqlite3
```

## Output

Columns:
- customer_id
- customer_name
- recency_days
- frequency
- monetary_usd
- r_score
- f_score
- m_score
- rfm_segment (example: 443)