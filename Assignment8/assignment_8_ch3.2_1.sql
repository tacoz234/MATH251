-- assignment_8_ch3.2_1.sql
-- MATH 251 – Database Queries
-- Assignment 8 (Chapter 3.2.1 style topics from the slide)
--
-- Goal:
-- Practice very basic exploratory data analysis (EDA) queries in SQL.
-- Stay within the query styles from class slides:
--   * simple SELECT
--   * COUNT, DISTINCT, MIN, MAX, AVG, STDDEV
--   * GROUP BY
--   * WITH
--   * simple arithmetic in SELECT
--   * simple WHERE (only when needed, as in trimmed mean)
--
-- Instructions:
-- 1. Run this file in psql.
-- 2. Fill in each placeholder marked TODO.
-- 3. Do not change table names or column names.
-- 4. When a query can return many rows, keep the output to at most 10 rows.
-- 5. Submit your completed SQL file.
--
-- Notes:
-- * The setup and \copy commands are already written for you.
-- * You do NOT need to write any import commands yourself.
-- * Use the exact schemas below.

DROP TABLE IF EXISTS london_weather;
DROP TABLE IF EXISTS nycflights;

CREATE TABLE london_weather (
    date INTEGER,
    cloud_cover REAL,
    sunshine REAL,
    global_radiation REAL,
    max_temp REAL,
    mean_temp REAL,
    min_temp REAL,
    precipitation REAL,
    pressure REAL,
    snow_depth REAL
);

CREATE TABLE nycflights (
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
    air_time REAL,
    distance REAL,
    hour INTEGER,
    minute INTEGER
);

-- Load the data.
\copy london_weather FROM 'london_weather-2.csv' DELIMITER ',' CSV HEADER;
\copy nycflights FROM 'nycflights-2.csv' DELIMITER ',' CSV HEADER;

-- =========================================================
-- Question 1
-- Show the first 10 rows of london_weather.
-- =========================================================

-- TODO: Write your query below.
SELECT * FROM london_weather LIMIT 10;


-- =========================================================
-- Question 2
-- For the numerical attribute max_temp in london_weather,
-- report the following exactly as shown in the slides:
--   number_values
--   cardinality
--   minimum
--   maximum
--   range
--   mean
--   standard_deviation
-- =========================================================

-- TODO: Write your query below.
SELECT 
    COUNT(*) AS number_values,
    COUNT(DISTINCT max_temp) AS cardinality,
    MIN(max_temp) AS minimum,
    MAX(max_temp) AS maximum,
    MAX(max_temp) - MIN(max_temp) AS range,
    AVG(max_temp) AS mean,
    STDDEV(max_temp) AS standard_deviation
FROM london_weather;


-- =========================================================
-- Question 3
-- Build a histogram-style frequency table for cloud_cover
-- in london_weather.
--
-- Output columns:
--   value
--   frequency
--
-- Sort by value from small to large.
-- Limit the output to 10 rows.
-- =========================================================

-- TODO: Write your query below.
SELECT 
    cloud_cover AS value,
    COUNT(*) AS frequency
FROM london_weather
GROUP BY cloud_cover
ORDER BY cloud_cover ASC
LIMIT 10;


-- =========================================================
-- Question 4
-- Compute the mean of max_temp using the histogram idea
-- from the slide:
--
--   WITH Histogram(Value, Frequency) AS (...)
--   SELECT (1.0 * SUM(Value * Frequency)) / SUM(Frequency) AS mean
--
-- Use:
--   Value = max_temp
-- =========================================================

-- TODO: Write your query below.
WITH Histogram(Value, Frequency) AS (
    SELECT max_temp, COUNT(*) AS frequency
    FROM london_weather
    GROUP BY max_temp
)
SELECT (1.0 * SUM(Value * Frequency)) / SUM(Frequency) AS mean
FROM Histogram;


-- =========================================================
-- Question 5
-- Compute the trimmed mean of mean_temp in london_weather
-- by removing the minimum and maximum values first.
--
-- Use the same query pattern shown in the slide.
-- =========================================================

-- TODO: Write your query below.
WITH Trimmed AS (
    SELECT mean_temp
    FROM london_weather
    WHERE mean_temp NOT IN (
        SELECT MIN(mean_temp) FROM london_weather
        UNION
        SELECT MAX(mean_temp) FROM london_weather
    )
)
SELECT (1.0 * SUM(Value * Frequency)) / SUM(Frequency) AS trimmed_mean
FROM (
    SELECT mean_temp AS Value, COUNT(*) AS Frequency
    FROM Trimmed
    GROUP BY mean_temp
) AS Histogram;


-- =========================================================
-- Question 6
-- Compute the geometric mean of pressure in london_weather
-- using the SQL idea from the slide.
--
-- Hint from class:
--   EXP(AVG(LN(Attr)))
-- =========================================================

-- TODO: Write your query below.
SELECT EXP(AVG(LN(pressure))) AS geometric_mean
FROM london_weather;


-- =========================================================
-- Question 7
-- Use nycflights to create a simple frequency table for origin.
--
-- Output columns:
--   origin
--   frequency
--
-- Sort by frequency from large to small.
-- Limit the output to 10 rows.
-- =========================================================

-- TODO: Write your query below.
SELECT 
    origin,
    COUNT(*) AS frequency
FROM nycflights
GROUP BY origin
ORDER BY frequency DESC
LIMIT 10;


-- =========================================================
-- Question 8
-- For the numerical attribute distance in nycflights,
-- compute the harmonic mean using the formula from the slide.
-- =========================================================

-- TODO: Write your query below.
SELECT (1.0 * COUNT(*)) / SUM(1.0 / distance) AS harmonic_mean
FROM nycflights;

-- =========================================================
-- Question 9
-- In nycflights, build a frequency table for carrier.
--
-- Output columns:
--   carrier
--   frequency
--
-- Sort by frequency from large to small.
-- Limit the output to 10 rows.
-- =========================================================

-- TODO: Write your query below.
SELECT 
    carrier,
    COUNT(*) AS frequency
FROM nycflights
GROUP BY carrier
ORDER BY frequency DESC
LIMIT 10;


-- =========================================================
-- Question 10
-- For each origin in nycflights, compute the average distance.
--
-- Output columns:
--   origin
--   average_distance
--
-- Sort by average_distance from large to small.
-- Limit the output to 10 rows.
-- =========================================================

-- TODO: Write your query below.
SELECT 
    origin,
    AVG(distance) AS average_distance
FROM nycflights
GROUP BY origin
ORDER BY average_distance DESC
LIMIT 10;


-- =========================================================
-- Question 11
-- Compute the mean of dep_delay in nycflights using the histogram idea
-- from the slide:
--
--   WITH Histogram(Value, Frequency) AS (...)
--   SELECT (1.0 * SUM(Value * Frequency)) / SUM(Frequency) AS mean
--
-- Use:
--   Value = dep_delay
--
-- Ignore rows where dep_delay is NULL.
-- =========================================================

-- TODO: Write your query below.
WITH Histogram(Value, Frequency) AS (
    SELECT dep_delay, COUNT(*) AS frequency
    FROM nycflights
    WHERE dep_delay IS NOT NULL
    GROUP BY dep_delay
)
SELECT (1.0 * SUM(Value * Frequency)) / SUM(Frequency) AS mean
FROM Histogram;
