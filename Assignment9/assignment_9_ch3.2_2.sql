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
-- This is a warm-up question.
WITH dep_delay_stats AS (
  SELECT
    COUNT(dep_delay) AS n,
    COUNT(DISTINCT dep_delay) AS distinct_count,
    MIN(dep_delay) AS min_val,
    MAX(dep_delay) AS max_val,
    MAX(dep_delay) - MIN(dep_delay) AS range_val,
    AVG(dep_delay) AS mean_val,
    STDDEV(dep_delay) AS stddev_val
  FROM flights
)
SELECT * FROM dep_delay_stats;


-- Question 2. Trimmed mean for arrival delay.
-- Compute the ordinary mean and the trimmed mean of arr_delay.
-- For the trimmed mean, remove only the smallest and largest arr_delay values.
-- Add a one-line comment explaining whether the trimmed mean changed much.
WITH sorted_delays AS (
  SELECT
    arr_delay,
    ROW_NUMBER() OVER (ORDER BY arr_delay ASC) as rn_asc,
    ROW_NUMBER() OVER (ORDER BY arr_delay DESC) as rn_desc
  FROM flights
),
trimmed_delays AS (
  SELECT arr_delay
  FROM sorted_delays
  WHERE rn_asc > 1 AND rn_desc > 1
)
SELECT
  (SELECT AVG(arr_delay) FROM flights) AS ordinary_mean,
  (SELECT AVG(arr_delay) FROM trimmed_delays) AS trimmed_mean;

-- Brief comment:
-- The trimmed mean changed little compared to the ordinary mean.

-- Question 3. Shape of a numerical distribution: skewness and kurtosis.
-- Use dep_delay in flights. Compute the skewness and kurtosis using the formulas
-- from the slides. Use dep_delay as the data value.
-- Hint: use AVG(dep_delay) in a subquery and POWER(...).
WITH dep_delay_stats AS (
  SELECT
    AVG(dep_delay) AS mu
  FROM flights
),
moment2_calc AS (
  SELECT AVG(POWER(dep_delay - mu, 2)) AS m2
  FROM flights, dep_delay_stats
),
moment3_calc AS (
  SELECT AVG(POWER(dep_delay - mu, 3)) AS m3
  FROM flights, dep_delay_stats
),
moment4_calc AS (
  SELECT AVG(POWER(dep_delay - mu, 4)) AS m4
  FROM flights, dep_delay_stats
),
variance_stddev AS (
  SELECT
    m2 AS variance,
    SQRT(m2) AS stddev
  FROM moment2_calc
)
SELECT
  (SELECT m3 / POWER(stddev, 3) FROM moment3_calc, variance_stddev) AS skewness,
  (SELECT m4 / POWER(stddev, 4) - 3 FROM moment4_calc, variance_stddev) AS kurtosis;


-- Question 4. Entropy of a categorical attribute.
-- Compute the entropy of carrier in flights.
-- Then compute the entropy of origin in flights.
-- Add a short comment: which attribute has larger entropy?
WITH carrier_counts AS (
  SELECT
    carrier,
    COUNT(*) AS count,
    (SELECT COUNT(*) FROM flights) AS total_count
  FROM flights
  WHERE carrier IS NOT NULL
  GROUP BY carrier
),
carrier_probs AS (
  SELECT
    carrier,
    count::NUMERIC / total_count AS prob
  FROM carrier_counts
),
carrier_entropy AS (
  SELECT
    -SUM(prob * LOG(prob, 2)) AS entropy
  FROM carrier_probs
),
origin_counts AS (
  SELECT
    origin,
    COUNT(*) AS count,
    (SELECT COUNT(*) FROM flights) AS total_count
  FROM flights
  WHERE origin IS NOT NULL
  GROUP BY origin
),
origin_probs AS (
  SELECT
    origin,
    count::NUMERIC / total_count AS prob
  FROM origin_counts
),
origin_entropy AS (
  SELECT
    -SUM(prob * LOG(prob, 2)) AS entropy
  FROM origin_probs
)
SELECT 'carrier' AS attribute, (SELECT entropy FROM carrier_entropy) AS entropy
UNION ALL
SELECT 'origin' AS attribute, (SELECT entropy FROM origin_entropy) AS entropy;

-- Brief comment:
-- The origin attribute has a larger entropy in this dataset, indicating that
-- flights are more evenly distributed across the three airports than they are 
-- across the various carriers.
-- Question 5. Joint probability table.
-- Build a joint probability table for origin and dest in flights.
-- Show origin, dest, and JointProb. Order the result by JointProb descending
-- and show only the first 10 rows.
WITH total_flights AS (
  SELECT COUNT(*) AS total
  FROM flights
),
joint_counts AS (
  SELECT
    origin,
    dest,
    COUNT(*) AS count
  FROM flights
  WHERE origin IS NOT NULL AND dest IS NOT NULL
  GROUP BY origin, dest
),
joint_probs AS (
  SELECT
    origin,
    dest,
    count::NUMERIC / (SELECT total FROM total_flights) AS joint_prob
  FROM joint_counts
)
SELECT
  origin,
  dest,
  joint_prob AS JointProb
FROM joint_probs
ORDER BY JointProb DESC
LIMIT 10;

-- Question 6. PMI for two categorical attributes.
-- Compute PMI for carrier and dest in flights using the SQL pattern from the slides.
-- Show carrier, dest, and PMI. Order by PMI descending and show the first 15 rows.
-- Add a short comment: what does a positive PMI mean here?
-- Write your query here.
WITH total_flights AS (
  SELECT COUNT(*) AS total
  FROM flights
),
carrier_counts AS (
  SELECT
    carrier,
    COUNT(*) AS count
  FROM flights
  WHERE carrier IS NOT NULL
  GROUP BY carrier
),
carrier_probs AS (
  SELECT
    carrier,
    count::NUMERIC / (SELECT total FROM total_flights) AS p_a
  FROM carrier_counts
),
dest_counts AS (
  SELECT
    dest,
    COUNT(*) AS count
  FROM flights
  WHERE dest IS NOT NULL
  GROUP BY dest
),
dest_probs AS (
  SELECT
    dest,
    count::NUMERIC / (SELECT total FROM total_flights) AS p_b
  FROM dest_counts
),
joint_counts AS (
  SELECT
    carrier,
    dest,
    COUNT(*) AS count
  FROM flights
  WHERE carrier IS NOT NULL AND dest IS NOT NULL
  GROUP BY carrier, dest
),
joint_probs AS (
  SELECT
    carrier,
    dest,
    count::NUMERIC / (SELECT total FROM total_flights) AS p_ab
  FROM joint_counts
),
pmi_calc AS (
  SELECT
    jp.carrier,
    jp.dest,
    jp.p_ab,
    pa.p_a,
    pb.p_b,
    LOG(jp.p_ab / (pa.p_a * pb.p_b)) AS pmi
  FROM joint_probs jp
  JOIN carrier_probs pa
    ON jp.carrier = pa.carrier
  JOIN dest_probs pb
    ON jp.dest = pb.dest
)
SELECT
  carrier,
  dest,
  pmi
FROM pmi_calc
ORDER BY pmi DESC
LIMIT 15;

-- Brief comment:
-- A positive PMI means the carrier and destination occur together more frequently
-- than expected by chance, indicating a strong association or "hub" relationship.
-- Question 7. Mutual information for carrier and dest.
-- Mutual information is the average of PMI over all pairs, weighted by PrAB.
-- Compute MI for carrier and dest using the ProbA, ProbB, and ProbAB tables.
-- This question extends Question 6 but still uses the same SQL pattern.
-- Write your query here.
WITH total_flights AS (
  SELECT COUNT(*) AS total
  FROM flights
),
carrier_counts AS (
  SELECT
    carrier,
    COUNT(*) AS count
  FROM flights
  WHERE carrier IS NOT NULL
  GROUP BY carrier
),
carrier_probs AS (
  SELECT
    carrier,
    count::NUMERIC / (SELECT total FROM total_flights) AS p_a
  FROM carrier_counts
),
dest_counts AS (
  SELECT
    dest,
    COUNT(*) AS count
  FROM flights
  WHERE dest IS NOT NULL
  GROUP BY dest
),
dest_probs AS (
  SELECT
    dest,
    count::NUMERIC / (SELECT total FROM total_flights) AS p_b
  FROM dest_counts
),
joint_counts AS (
  SELECT
    carrier,
    dest,
    COUNT(*) AS count
  FROM flights
  WHERE carrier IS NOT NULL AND dest IS NOT NULL
  GROUP BY carrier, dest
),
joint_probs AS (
  SELECT
    carrier,
    dest,
    count::NUMERIC / (SELECT total FROM total_flights) AS p_ab
  FROM joint_counts
),
mi_calc AS (
  SELECT
    jp.carrier,
    jp.dest,
    jp.p_ab,
    pa.p_a,
    pb.p_b,
    jp.p_ab * (LOG(jp.p_ab) - LOG(pa.p_a) - LOG(pb.p_b)) AS mi_term
  FROM joint_probs jp
  JOIN carrier_probs pa
    ON jp.carrier = pa.carrier
  JOIN dest_probs pb
    ON jp.dest = pb.dest
)
SELECT
  SUM(mi_term) AS mutual_information
FROM mi_calc;

-- Question 8. Numerical-vs-numerical relationship: covariance.
-- Use london_weather. Compute the covariance between sunshine and mean_temp
-- using the equivalent formula from the slides:
-- Cov(A,B) = E(AB) - E(A)E(B).
-- Then add a short comment saying whether the covariance is positive or negative.
-- Write your query here.
WITH means AS (
  SELECT
    AVG(sunshine) AS mean_sun,
    AVG(mean_temp) AS mean_temp
  FROM london_weather
),
e_ab AS (
  SELECT AVG(sunshine * mean_temp) AS e_ab
  FROM london_weather
),
covariance AS (
  SELECT
    e.e_ab - (m.mean_sun * m.mean_temp) AS covariance
  FROM e_ab e
  CROSS JOIN means m
)
SELECT covariance
FROM covariance;

-- Brief comment:
-- The covariance is positive, indicating that as sunshine increases, 
-- the mean temperature also tends to increase.


-- Question 9. Correlation coefficient (Pearson).
-- Using the covariance from Question 8 and the standard deviations,
-- compute the Pearson correlation coefficient between sunshine and mean_temp.
-- Correlation = Cov(A,B) / (stddev(A) * stddev(B)).
-- Write your query here.
WITH stats AS (
  SELECT
    AVG(sunshine) AS mean_sun,
    AVG(mean_temp) AS mean_temp,
    STDDEV(sunshine) AS std_sun,
    STDDEV(mean_temp) AS std_temp,
    AVG(sunshine * mean_temp) AS e_ab
  FROM london_weather
),
covariance_calc AS (
  SELECT
    e_ab - (mean_sun * mean_temp) AS cov_ab,
    std_sun,
    std_temp
  FROM stats
)
SELECT
  cov_ab / (std_sun * std_temp) AS pearson_correlation
FROM covariance_calc;

-- Brief comment:
-- The correlation is likely close to 1 (or at least strongly positive),
-- showing a strong linear relationship between sunshine and temperature.
