-- Challenge 015: Sessionization (30-min inactivity rule)
-- Goal: build sessions from event stream per user

DROP TABLE IF EXISTS events;

CREATE TABLE events (
  event_id    INTEGER PRIMARY KEY,
  user_id     INTEGER NOT NULL,
  event_time  TEXT    NOT NULL,   -- ISO: YYYY-MM-DD HH:MM:SS
  event_type  TEXT    NOT NULL,   -- page_view, add_to_cart, purchase, etc.
  page        TEXT                -- optional label
);

-- Sample event stream (gaps > 30 min start a new session)
INSERT INTO events (event_id, user_id, event_time, event_type, page) VALUES
(1,  101, '2024-01-01 09:00:00', 'page_view',    '/home'),
(2,  101, '2024-01-01 09:05:00', 'page_view',    '/product/1'),
(3,  101, '2024-01-01 09:20:00', 'add_to_cart',  '/cart'),
(4,  101, '2024-01-01 10:10:00', 'page_view',    '/home'),
(5,  101, '2024-01-01 10:25:00', 'purchase',     '/checkout'),

(6,  102, '2024-01-02 12:00:00', 'page_view',    '/home'),
(7,  102, '2024-01-02 12:10:00', 'page_view',    '/category/electronics'),
(8,  102, '2024-01-02 12:50:01', 'page_view',    '/product/9'),
(9,  102, '2024-01-02 13:10:00', 'add_to_cart',  '/cart'),
(10, 102, '2024-01-02 13:20:00', 'purchase',     '/checkout'),

(11, 103, '2024-01-03 08:00:00', 'page_view',    '/home'),
(12, 103, '2024-01-03 08:40:00', 'page_view',    '/product/2'),
(13, 103, '2024-01-03 08:45:00', 'page_view',    '/product/3');
