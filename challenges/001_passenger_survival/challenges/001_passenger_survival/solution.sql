-- Goal: survival rate by sex + passenger_class

SELECT
  sex,
  passenger_class,
  COUNT(*) AS total_passengers,
  ROUND(AVG(age), 2) AS avg_age,
  ROUND(100.0 * AVG(survived), 2) AS survival_rate_pct
FROM passengers
GROUP BY sex, passenger_class
ORDER BY sex, passenger_class;
