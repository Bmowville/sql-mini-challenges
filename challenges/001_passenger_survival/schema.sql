-- Challenge 001: Passenger survival by class (Titanic-style)

DROP TABLE IF EXISTS passengers;

CREATE TABLE passengers (
  passenger_id INTEGER PRIMARY KEY,
  sex TEXT NOT NULL,
  passenger_class INTEGER NOT NULL,   -- 1, 2, 3
  age REAL,
  survived INTEGER NOT NULL           -- 0/1
);

INSERT INTO passengers (passenger_id, sex, passenger_class, age, survived) VALUES
  (1, 'female', 1, 29, 1),
  (2, 'female', 1, 35, 1),
  (3, 'female', 2, 28, 1),
  (4, 'female', 3, 20, 1),
  (5, 'male',   1, 42, 0),
  (6, 'male',   2, 30, 0),
  (7, 'male',   3, 25, 0),
  (8, 'male',   3, 27, 0);
