-- MATH 251 - Assignment 9, Chapter 3.2, Part 2
-- Data Cleaning and Preparation: EDA with SQL
-- Estimated time: about 2 hours
--
-- Instructions:
-- 1. Run the setup section first. It creates the tables and loads the data.
-- 2. For each question, write your SQL query under the placeholder.
-- 3. Use only the SQL patterns from the slides: SELECT, FROM, WHERE, GROUP BY,
--    ORDER BY, LIMIT, OFFSET, WITH, aggregate functions, and the mathematical
--    functions shown in class.
-- 4. Do not edit the CREATE TABLE or \copy commands.
-- 5. Focus on interpreting the output briefly in comments when asked.

DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS london_weather;

CREATE TABLE flights (
    year INTEGER,
    month INTEGER,
    day INTEGER,
    dep_time INTEGER,
    dep_delay INTEGER,
    arr_time INTEGER,
    arr_delay INTEGER,
    carrier TEXT,
    tailnum TEXT,
    flight INTEGER,
    origin TEXT,
    dest TEXT,
    air_time INTEGER,
    distance INTEGER,
    hour INTEGER,
    minute INTEGER
);

\copy flights FROM 'nycflights.csv' WITH (FORMAT csv, HEADER true);

CREATE TABLE london_weather (
    date INTEGER,
    cloud_cover NUMERIC,
    sunshine NUMERIC,
    global_radiation NUMERIC,
    max_temp NUMERIC,
    mean_temp NUMERIC,
    min_temp NUMERIC,
    precipitation NUMERIC,
    pressure NUMERIC,
    snow_depth NUMERIC
);

\copy london_weather FROM 'london_weather.csv' WITH (FORMAT csv, HEADER true);

-- Quick check: preview the data.
SELECT * FROM flights LIMIT 10;
SELECT * FROM london_weather LIMIT 10;

-- Question 1. Basic schema-oriented EDA for the flights dataset.
-- Find the number of non-missing values, number of distinct values, minimum,
-- maximum, range, mean, and standard deviation for dep_delay.
-- This is a warm-up question.
-- Write your query here.

-- Question 2. Trimmed mean for arrival delay.
-- Compute the ordinary mean and the trimmed mean of arr_delay.
-- For the trimmed mean, remove only the smallest and largest arr_delay values.
-- Add a one-line comment explaining whether the trimmed mean changed much.
-- Write your query here.

-- Brief comment:
--

-- Question 3. Shape of a numerical distribution: skewness and kurtosis.
-- Use dep_delay in flights. Compute the skewness and kurtosis using the formulas
-- from the slides. Use dep_delay as the data value.
-- Hint: use AVG(dep_delay) in a subquery and POWER(...).
-- Write your skewness query here.

-- Write your kurtosis query here.

-- Question 4. Entropy of a categorical attribute.
-- Compute the entropy of carrier in flights.
-- Then compute the entropy of origin in flights.
-- Add a short comment: which attribute has larger entropy?
-- Write your carrier entropy query here.

-- Write your origin entropy query here.

-- Brief comment:
--

-- Question 5. Joint probability table.
-- Build a joint probability table for origin and dest in flights.
-- Show origin, dest, and JointProb. Order the result by JointProb descending
-- and show only the first 10 rows.
-- Write your query here.

-- Question 6. PMI for two categorical attributes.
-- Compute PMI for carrier and dest in flights using the SQL pattern from the slides.
-- Show carrier, dest, and PMI. Order by PMI descending and show the first 15 rows.
-- Add a short comment: what does a positive PMI mean here?
-- Write your query here.

-- Brief comment:
--

-- Question 7. Mutual information for carrier and dest.
-- Mutual information is the average of PMI over all pairs, weighted by PrAB.
-- Compute MI for carrier and dest using the ProbA, ProbB, and ProbAB tables.
-- This question extends Question 6 but still uses the same SQL pattern.
-- Write your query here.

-- Question 8. Numerical-vs-numerical relationship: covariance.
-- Use london_weather. Compute the covariance between sunshine and mean_temp
-- using the equivalent formula from the slides:
-- Cov(A,B) = E(AB) - E(A)E(B).
-- Then add a short comment saying whether the covariance is positive or negative.
-- Write your query here.

-- Brief comment:
--

