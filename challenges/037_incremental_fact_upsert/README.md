# Challenge 037: Incremental fact upsert (dedupe + late arrivals)

Goal:
- Dedupe incoming staging rows by `event_id` (keep the latest `ingested_at`)
- Upsert into `fact_events`
- Keep `first_seen_at` (earliest) and `last_seen_at` (latest)
- Allow updates when a newer `ingested_at` arrives for an existing `event_id`

## Files
- `schema.sql` creates staging + fact tables and inserts sample batches
- `solution.sql` dedupes staging and upserts into the fact table

## Run (SQLite)

Windows CMD:
```bat
type challenges\037_incremental_fact_upsert\schema.sql challenges\037_incremental_fact_upsert\solution.sql | sqlite3
```

## Output

Final fact_events rows:
- event_id
- user_id
- event_ts
- event_name
- first_seen_at
- last_seen_at