-- Challenge 037: Incremental fact load (dedupe + late arrivals + upsert)
--
-- Scenario:
-- You receive event batches over time. Batches can include:
-- - duplicates (same event_id more than once)
-- - late-arriving events (older event_ts arriving later)
-- - updates to an existing event (same event_id with newer ingested_at)
--
-- Goal:
-- Upsert from staging into fact_events, keeping the latest version per event_id
-- based on ingested_at.

DROP TABLE IF EXISTS staging_events;
DROP TABLE IF EXISTS fact_events;

CREATE TABLE staging_events (
  event_id     INTEGER NOT NULL,
  user_id      INTEGER NOT NULL,
  event_ts     TEXT NOT NULL,      -- YYYY-MM-DD HH:MM:SS (when it happened)
  event_name   TEXT NOT NULL,
  ingested_at  TEXT NOT NULL,      -- YYYY-MM-DD HH:MM:SS (when we received it)
  batch_id     INTEGER NOT NULL
);

CREATE TABLE fact_events (
  event_id     INTEGER PRIMARY KEY,
  user_id      INTEGER NOT NULL,
  event_ts     TEXT NOT NULL,
  event_name   TEXT NOT NULL,
  first_seen_at TEXT NOT NULL,
  last_seen_at  TEXT NOT NULL
);

-- Batch 1 (initial load; includes a duplicate of event_id=2 with different ingested_at)
INSERT INTO staging_events (event_id, user_id, event_ts, event_name, ingested_at, batch_id) VALUES
  (1, 101, '2024-01-01 09:00:00', 'view',       '2024-01-01 09:01:00', 1),
  (2, 101, '2024-01-01 09:05:00', 'add_to_cart','2024-01-01 09:06:00', 1),
  (2, 101, '2024-01-01 09:05:00', 'add_to_cart','2024-01-01 09:08:00', 1), -- duplicate (later ingested)
  (3, 102, '2024-01-01 10:00:00', 'view',       '2024-01-01 10:00:30', 1);

-- Batch 2 (late arrival event_id=4, and an update for event_id=3, plus a duplicate)
INSERT INTO staging_events (event_id, user_id, event_ts, event_name, ingested_at, batch_id) VALUES
  (4, 103, '2023-12-20 12:00:00', 'view',       '2024-01-02 08:00:00', 2), -- late arriving (old event_ts)
  (3, 102, '2024-01-01 10:00:00', 'purchase',   '2024-01-02 08:10:00', 2), -- updated event_name, newer ingested
  (3, 102, '2024-01-01 10:00:00', 'purchase',   '2024-01-02 08:10:00', 2), -- duplicate exact
  (5, 101, '2024-01-02 09:00:00', 'view',       '2024-01-02 09:01:00', 2);
