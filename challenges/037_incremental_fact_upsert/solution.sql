-- Challenge 037: Incremental fact upsert (without ON CONFLICT)
-- Works on older SQLite builds by doing: (1) dedupe staging (2) insert new (3) update existing

-- 1) Build a reusable "latest per event_id" view from staging
DROP VIEW IF EXISTS staging_latest;

CREATE TEMP VIEW staging_latest AS
SELECT
  event_id,
  user_id,
  event_ts,
  event_name,
  ingested_at
FROM (
  SELECT
    s.*,
    ROW_NUMBER() OVER (
      PARTITION BY s.event_id
      ORDER BY datetime(s.ingested_at) DESC, s.batch_id DESC
    ) AS rn
  FROM staging_events s
)
WHERE rn = 1;

-- 2) Insert brand-new event_ids into fact
INSERT INTO fact_events (event_id, user_id, event_ts, event_name, first_seen_at, last_seen_at)
SELECT
  sl.event_id,
  sl.user_id,
  sl.event_ts,
  sl.event_name,
  sl.ingested_at AS first_seen_at,
  sl.ingested_at AS last_seen_at
FROM staging_latest sl
WHERE NOT EXISTS (
  SELECT 1
  FROM fact_events f
  WHERE f.event_id = sl.event_id
);

-- 3) Update existing event_ids when we have a newer ingested_at
UPDATE fact_events
SET
  user_id = (SELECT sl.user_id FROM staging_latest sl WHERE sl.event_id = fact_events.event_id),
  event_ts = (SELECT sl.event_ts FROM staging_latest sl WHERE sl.event_id = fact_events.event_id),
  event_name = (SELECT sl.event_name FROM staging_latest sl WHERE sl.event_id = fact_events.event_id),
  last_seen_at = (SELECT sl.ingested_at FROM staging_latest sl WHERE sl.event_id = fact_events.event_id),
  first_seen_at = CASE
    WHEN datetime((SELECT sl.ingested_at FROM staging_latest sl WHERE sl.event_id = fact_events.event_id))
         < datetime(fact_events.first_seen_at)
    THEN (SELECT sl.ingested_at FROM staging_latest sl WHERE sl.event_id = fact_events.event_id)
    ELSE fact_events.first_seen_at
  END
WHERE EXISTS (
  SELECT 1
  FROM staging_latest sl
  WHERE sl.event_id = fact_events.event_id
    AND datetime(sl.ingested_at) > datetime(fact_events.last_seen_at)
);

-- Final output
SELECT
  event_id,
  user_id,
  event_ts,
  event_name,
  first_seen_at,
  last_seen_at
FROM fact_events
ORDER BY event_id;
