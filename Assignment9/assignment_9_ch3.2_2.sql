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

\copy flights FROM 'nycflights-3.csv' WITH (FORMAT csv, HEADER true);

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

\copy london_weather FROM 'london_weather-3.csv' WITH (FORMAT csv, HEADER true);

-- Quick check: preview the data.
SELECT * FROM flights LIMIT 10;
SELECT * FROM london_weather LIMIT 10;

-- Question 1. Basic schema-oriented EDA for the flights dataset.
-- Find the number of non-missing values, number of distinct values, minimum,
-- maximum, range, mean, and standard deviation for dep_delay.
SELECT 
    COUNT(dep_delay) AS number_values,
    COUNT(DISTINCT dep_delay) AS cardinality,
    MIN(dep_delay) AS minimum,
    MAX(dep_delay) AS maximum,
    MAX(dep_delay) - MIN(dep_delay) AS range,
    AVG(dep_delay) AS mean,
    STDDEV(dep_delay) AS standard_deviation
FROM flights;


-- Question 2. Trimmed mean for arrival delay.
-- Compute the ordinary mean and the trimmed mean of arr_delay.
-- For the trimmed mean, remove only the smallest and largest arr_delay values.
-- Add a one-line comment explaining whether the trimmed mean changed much.
SELECT 
    (SELECT AVG(arr_delay) FROM flights) AS ordinary_mean,
    AVG(arr_delay) AS trimmed_mean
FROM flights,
     (SELECT MAX(arr_delay) AS Amax FROM flights) AS T1,
     (SELECT MIN(arr_delay) AS Amin FROM flights) AS T2
WHERE arr_delay < Amax AND arr_delay > Amin;

-- Brief comment:
-- The trimmed mean changed very little (7.10 to 7.06), suggesting the extremes 
-- don't heavily bias the average in this large dataset.


-- Question 3. Shape of a numerical distribution: skewness and kurtosis.
-- Use dep_delay in flights. Compute the skewness and kurtosis using the formulas
-- from the slides. Use dep_delay as the data value.
SELECT 
    -- Skewness formula from slide 34
    SUM(POWER(dep_delay - mean, 3)) / COUNT(*) / 
    POWER(SUM(POWER(dep_delay - mean, 2)) / (COUNT(*) - 1), 3.0/2.0) AS skewness,
    -- Kurtosis formula from slide 35 (Excess Kurtosis)
    SUM(POWER(dep_delay - mean, 4)) / COUNT(*) / 
    POWER(SUM(POWER(dep_delay - mean, 2)) / (COUNT(*) - 1), 2) AS kurtosis
FROM flights, (SELECT AVG(dep_delay) AS mean FROM flights) AS T;


-- Question 4. Entropy of a categorical attribute.
-- Compute the entropy of carrier in flights.
-- Then compute the entropy of origin in flights.
-- Add a short comment: which attribute has larger entropy?
WITH CarrierEntropy AS (
    SELECT -SUM(Pa * LOG(2, Pa)) AS entropy
    FROM (
        SELECT carrier, COUNT(*) * 1.0 / total AS Pa
        FROM flights
        CROSS JOIN (SELECT COUNT(*) AS total FROM flights) AS T
        WHERE carrier IS NOT NULL
        GROUP BY carrier, total
    ) AS S
),
OriginEntropy AS (
    SELECT -SUM(Pa * LOG(2, Pa)) AS entropy
    FROM (
        SELECT origin, COUNT(*) * 1.0 / total AS Pa
        FROM flights
        CROSS JOIN (SELECT COUNT(*) AS total FROM flights) AS T
        WHERE origin IS NOT NULL
        GROUP BY origin, total
    ) AS S
)
SELECT 'carrier' AS attribute, entropy FROM CarrierEntropy
UNION ALL
SELECT 'origin' AS attribute, entropy FROM OriginEntropy;

-- Brief comment:
-- The carrier attribute has a larger entropy (3.17) than origin (1.58),
-- indicating more uncertainty and a wider distribution of flights across 
-- the various airlines compared to the three origin airports.


-- Question 5. Joint probability table.
-- Build a joint probability table for origin and dest in flights.
-- Show origin, dest, and JointProb. Order the result by JointProb descending
-- and show only the first 10 rows.
SELECT origin, dest, SUM(1.0/total) AS JointProb
FROM flights, (SELECT COUNT(*) AS total FROM flights) AS T
WHERE origin IS NOT NULL AND dest IS NOT NULL
GROUP BY origin, dest, total
ORDER BY JointProb DESC
LIMIT 10;


-- Question 6. PMI for two categorical attributes.
-- Compute PMI for carrier and dest in flights using the SQL pattern from the slides.
-- Show carrier, dest, and PMI. Order by PMI descending and show the first 15 rows.
-- Add a short comment: what does a positive PMI mean here?
WITH ProbA AS (
    SELECT carrier AS A, SUM(1.0/total) AS PrA
    FROM flights, (SELECT COUNT(*) AS total FROM flights) AS T
    GROUP BY carrier
),
ProbB AS (
    SELECT dest AS B, SUM(1.0/total) AS PrB
    FROM flights, (SELECT COUNT(*) AS total FROM flights) AS T
    GROUP BY dest
),
ProbAB AS (
    SELECT carrier AS A, dest AS B, SUM(1.0/total) AS PrAB
    FROM flights, (SELECT COUNT(*) AS total FROM flights) AS T
    GROUP BY carrier, dest
)
SELECT A AS carrier, B AS dest, LOG(2, PrAB / (PrA * PrB)) AS pmi
FROM (
    SELECT ProbA.A, ProbB.B, PrA, PrB, PrAB
    FROM ProbA, ProbB, ProbAB
    WHERE ProbA.A = ProbAB.A AND ProbB.B = ProbAB.B
) AS Probabilities
ORDER BY pmi DESC
LIMIT 15;

-- Brief comment:
-- A positive PMI means the carrier and destination occur together more frequently
-- than expected by chance, indicating a strong association or "hub" relationship.


-- Question 7. Mutual information for carrier and dest.
-- Mutual information is the average of PMI over all pairs, weighted by PrAB.
-- Compute MI for carrier and dest using the ProbA, ProbB, and ProbAB tables.
WITH ProbA AS (
    SELECT carrier AS A, SUM(1.0/total) AS PrA
    FROM flights, (SELECT COUNT(*) AS total FROM flights) AS T
    GROUP BY carrier
),
ProbB AS (
    SELECT dest AS B, SUM(1.0/total) AS PrB
    FROM flights, (SELECT COUNT(*) AS total FROM flights) AS T
    GROUP BY dest
),
ProbAB AS (
    SELECT carrier AS A, dest AS B, SUM(1.0/total) AS PrAB
    FROM flights, (SELECT COUNT(*) AS total FROM flights) AS T
    GROUP BY carrier, dest
)
SELECT SUM(PrAB * LOG(2, PrAB / (PrA * PrB))) AS mutual_information
FROM ProbA, ProbB, ProbAB
WHERE ProbA.A = ProbAB.A AND ProbB.B = ProbAB.B;


-- Question 8. Numerical-vs-numerical relationship: covariance.
-- Use london_weather. Compute the covariance between sunshine and mean_temp
-- using the equivalent formula from the slides: Cov(A,B) = E(AB) - E(A)E(B).
-- Then add a short comment saying whether the covariance is positive or negative.
SELECT AVG(sunshine * mean_temp) - (AVG(sunshine) * AVG(mean_temp)) AS covariance
FROM london_weather;

-- Brief comment:
-- The covariance is positive, indicating that as sunshine increases, 
-- the mean temperature also tends to increase.
