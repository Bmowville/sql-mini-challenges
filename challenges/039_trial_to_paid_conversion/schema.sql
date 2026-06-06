-- Challenge 039: Trial to paid conversion
--
-- Scenario:
-- A SaaS team wants cohort conversion metrics by trial plan.
-- Use the first active paid subscription after signup for each user.
--
-- Output by signup cohort month and trial plan:
-- cohort_month | trial_plan | trials | converted_14d | converted_30d | conversion_30d_pct | avg_days_to_paid_30d | new_mrr_30d

DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS trial_signups;

CREATE TABLE trial_signups (
  user_id INTEGER PRIMARY KEY,
  signup_date TEXT NOT NULL,
  trial_plan TEXT NOT NULL,
  acquisition_channel TEXT NOT NULL
);

CREATE TABLE subscriptions (
  subscription_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  started_date TEXT NOT NULL,
  paid_plan TEXT NOT NULL,
  monthly_amount REAL NOT NULL,
  status TEXT NOT NULL
);

INSERT INTO trial_signups (user_id, signup_date, trial_plan, acquisition_channel) VALUES
  (1, '2024-01-03', 'basic', 'search'),
  (2, '2024-01-08', 'basic', 'partner'),
  (3, '2024-01-20', 'pro', 'search'),
  (4, '2024-01-28', 'pro', 'organic'),
  (5, '2024-02-02', 'basic', 'organic'),
  (6, '2024-02-09', 'basic', 'search'),
  (7, '2024-02-11', 'pro', 'partner'),
  (8, '2024-02-18', 'pro', 'search'),
  (9, '2024-03-01', 'basic', 'organic'),
  (10, '2024-03-05', 'pro', 'search');

INSERT INTO subscriptions (subscription_id, user_id, started_date, paid_plan, monthly_amount, status) VALUES
  (101, 1, '2024-01-10', 'basic_paid', 29.00, 'active'),
  (102, 2, '2024-02-12', 'basic_paid', 29.00, 'active'),
  (103, 3, '2024-02-01', 'pro_paid', 99.00, 'active'),
  (104, 5, '2024-02-18', 'basic_paid', 29.00, 'active'),
  (105, 6, '2024-03-15', 'basic_paid', 29.00, 'active'),
  (106, 7, '2024-02-20', 'pro_paid', 99.00, 'active'),
  (107, 8, '2024-03-17', 'pro_paid', 99.00, 'active'),
  (108, 9, '2024-03-04', 'basic_paid', 29.00, 'active'),
  (109, 10, '2024-04-10', 'pro_paid', 99.00, 'active'),
  (110, 7, '2024-03-20', 'pro_paid', 99.00, 'active');