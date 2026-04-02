-- =====================================================================
-- Assignment 5 - Chapter 3.1.1
-- Topic: Basic SQL Queries (SELECT, FROM, WHERE, DISTINCT, AS,
--        AND/OR/NOT, IN, BETWEEN, LIKE, simple subquery in FROM)
-- Time: about 25 minutes
-- Dataset tables: nyflights, london_weather
--
-- Directions:
-- 1) Run this file section by section in psql or pgAdmin.
-- 2) Complete each query in the placeholder area below the question.
-- 3) Keep your answers within the basic-query ideas from class.
-- 4) Do NOT use GROUP BY, ORDER BY, joins, aggregates, or advanced SQL.
-- 5) For every query you write in this assignment, end with LIMIT 10.
-- =====================================================================

-- =====================================================================
-- PART 0. LOAD THE DATA
-- =====================================================================
-- IMPORTANT:
-- In psql, the command that usually works best for importing a CSV file
-- from your own computer is \copy (with a backslash), not COPY.
--
-- Why?
-- COPY tries to read the file on the PostgreSQL server machine.
-- \copy reads the file from YOUR local machine through psql.
--
-- So if COPY gives a file/path/permission issue, use \copy.
-- =====================================================================

DROP TABLE IF EXISTS nyflights;
CREATE TABLE nyflights (
    year        integer,
    month       integer,
    day         integer,
    dep_time    integer,
    dep_delay   integer,
    arr_time    integer,
    arr_delay   integer,
    carrier     text,
    tailnum     text,
    flight      integer,
    origin      text,
    dest        text,
    air_time    integer,
    distance    integer,
    hour        integer,
    minute      integer
);

DROP TABLE IF EXISTS london_weather;
CREATE TABLE london_weather (
    date              text,
    cloud_cover       real,
    sunshine          real,
    global_radiation  real,
    max_temp          real,
    mean_temp         real,
    min_temp          real,
    precipitation     real,
    pressure          real,
    snow_depth        real
);

-- -------------------------------------------------
-- Replace the file paths below with YOUR own paths.
-- Examples:
--   Mac/Linux: /Users/yourname/Downloads/nycflights.csv
--   Windows:   C:/Users/yourname/Downloads/nycflights.csv
-- -------------------------------------------------

\copy nyflights FROM '/Users/coledeterman/Documents/trae_projects/MATH251/Assignment5/nycflights.csv' WITH (FORMAT csv, HEADER true);
\copy london_weather FROM '/Users/coledeterman/Documents/trae_projects/MATH251/Assignment5/london_weather.csv' WITH (FORMAT csv, HEADER true);

-- Quick check that the data loaded:
SELECT * FROM nyflights LIMIT 5;
SELECT * FROM london_weather LIMIT 5;


-- =====================================================================
-- PART 1. BASIC QUERIES ON NYFLIGHTS
-- =====================================================================

-- Q1. Show the flight number, origin, and destination for flights
-- that went to ORD on January 1, 2013.

  SELECT flight, origin, dest
  FROM nyflights
  WHERE dest = 'ORD' AND year = 2013 AND month = 1 AND day = 1
  LIMIT 10;

-- Your answer for Q1 (end with LIMIT 10):



-- =====================================================================

-- Q2. Show all columns for flights that started from JFK and had
-- distance between 500 and 1000 miles (inclusive).
SELECT *
FROM nyflights
WHERE origin = 'JFK' AND distance BETWEEN 500 AND 1000
LIMIT 10;

-- Your answer for Q2 (end with LIMIT 10):



-- =====================================================================

-- Q3. Show the distinct destinations reached from LGA.
-- Return only one column: dest.
SELECT DISTINCT dest
FROM nyflights
WHERE origin = 'LGA'
LIMIT 10;

-- Your answer for Q3 (end with LIMIT 10):



-- =====================================================================

-- Q4. Show the carrier, flight, and destination for flights whose
-- destination is ORD, MIA, or SFO.
-- Use IN.
SELECT carrier, flight, dest
FROM nyflights
WHERE dest IN ('ORD', 'MIA', 'SFO')
LIMIT 10;

-- Your answer for Q4 (end with LIMIT 10):



-- =====================================================================

-- Q5. Show the carrier, flight, and destination for flights whose
-- destination starts with the letter S.
-- Use LIKE.
SELECT carrier, flight, dest
FROM nyflights
WHERE dest LIKE 'S%'
LIMIT 10;

-- Your answer for Q5 (end with LIMIT 10):



-- =====================================================================

-- Q6. Show flight, origin, dest, and dep_delay for flights with
-- dep_delay > 60 and NOT going to ATL.
SELECT flight, origin, dest, dep_delay
FROM nyflights
WHERE dep_delay > 60 AND dest != 'ATL'
LIMIT 10;

-- Your answer for Q6 (end with LIMIT 10):



-- =====================================================================

-- Q7. Use AS to rename columns.
-- Show origin AS departure_airport and dest AS arrival_airport
-- for flights on July 4, 2013.
SELECT origin AS departure_airport, dest AS arrival_airport
FROM nyflights
WHERE year = 2013 AND month = 7 AND day = 4
LIMIT 10;

-- Your answer for Q7 (end with LIMIT 10):



-- =====================================================================

-- Q8. Subquery practice.
-- First find flights on January 1, 2013 going to ORD.
-- Then from that temporary table, show only flight and origin
-- for flights with distance > 700.
--
-- Hint: the inner query should return at least: flight, origin, distance
SELECT flight, origin
FROM (
    SELECT flight, origin, distance
    FROM nyflights
    WHERE dest = 'ORD' AND year = 2013 AND month = 1 AND day = 1
) AS temp
WHERE distance > 700
LIMIT 10;

-- Your answer for Q8 (end with LIMIT 10):



-- =====================================================================
-- PART 2. BASIC QUERIES ON LONDON_WEATHER
-- =====================================================================

-- Q9. Show date, max_temp, and min_temp for days with max_temp < 0.
SELECT date, max_temp, min_temp
FROM london_weather
WHERE max_temp < 0
LIMIT 10;

-- Your answer for Q9 (end with LIMIT 10):



-- =====================================================================

-- Q10. Show all columns for days with precipitation between 5 and 15.
SELECT *
FROM london_weather
WHERE precipitation BETWEEN 5 AND 15
LIMIT 10;

-- Your answer for Q10 (end with LIMIT 10):



-- =====================================================================

-- Q11. Show date, sunshine, and cloud_cover for days with
-- sunshine > 8 OR cloud_cover < 2.
SELECT date, sunshine, cloud_cover
FROM london_weather
WHERE sunshine > 8 OR cloud_cover < 2
LIMIT 10;

-- Your answer for Q11 (end with LIMIT 10):



-- =====================================================================

-- Q12. Show distinct snow_depth values from london_weather.
-- Return only one column.
SELECT DISTINCT snow_depth
FROM london_weather
LIMIT 10;

-- Your answer for Q12 (end with LIMIT 10):



-- =====================================================================
-- OPTIONAL FAST FINISHER (only if you finish early)
-- =====================================================================

-- Q13. Show date and mean_temp for days whose date starts with 197901.
-- (That means January 1979.) Use LIKE.
SELECT date, mean_temp
FROM london_weather
WHERE date LIKE '197901%'
LIMIT 10;

-- Your answer for Q13 (end with LIMIT 10):



-- =====================================================================
-- End of assignment
-- =====================================================================
