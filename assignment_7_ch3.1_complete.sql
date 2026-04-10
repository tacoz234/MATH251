-- Assignment 7: Chapter 3.1 Complete
-- Homework Assignment
-- Time: about 60 minutes
-- Use only SQL ideas covered in Chapter 3.1 / the class slides.
--
-- Important:
-- 1) Keep each answer as a single query.
-- 2) Every query must include LIMIT 10 unless the question naturally returns a single number.
-- 3) Put the CSV files in the same folder as this SQL file before running it in psql.
-- 4) Do not change the table definitions or the \copy commands.
-- 5) For the two short interpretation questions at the end, write your answer in comments.

DROP TABLE IF EXISTS nycflights;
DROP TABLE IF EXISTS londonweather;
DROP TABLE IF EXISTS chicagoemployees;
DROP TABLE IF EXISTS chicagoschools;

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
    air_time INTEGER,
    distance INTEGER,
    hour INTEGER,
    minute INTEGER
);

\copy nycflights FROM 'nycflights.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE londonweather (
    date BIGINT,
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

\copy londonweather FROM 'london_weather.csv' DELIMITER ',' CSV HEADER;

-- Keep employee columns as TEXT because some values include formatting such as $ and commas.
CREATE TABLE chicagoemployees (
    name TEXT,
    job_titles TEXT,
    department TEXT,
    full_or_part_time TEXT,
    salary_or_hourly TEXT,
    typical_hours TEXT,
    annual_salary TEXT,
    hourly_rate TEXT
);

\copy chicagoemployees FROM 'Chicago_Current_Employee.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE chicagoschools (
    school_id TEXT,
    legacy_unit_id TEXT,
    finance_id TEXT,
    short_name TEXT,
    long_name TEXT,
    school_type TEXT,
    primary_category TEXT,
    is_high_school TEXT,
    is_middle_school TEXT,
    is_elementary_school TEXT,
    is_pre_school TEXT,
    summary TEXT,
    administrator_title TEXT,
    administrator TEXT,
    secondary_contact_title TEXT,
    secondary_contact TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    phone TEXT,
    fax TEXT,
    cps_school_profile TEXT,
    website TEXT,
    facebook TEXT,
    twitter TEXT,
    youtube TEXT,
    pinterest TEXT,
    attendance_boundaries TEXT,
    grades_offered_all TEXT,
    grades_offered TEXT,
    student_count_total TEXT,
    student_count_low_income TEXT,
    student_count_special_ed TEXT,
    student_count_english_learners TEXT,
    student_count_black TEXT,
    student_count_hispanic TEXT,
    student_count_white TEXT,
    student_count_asian TEXT,
    student_count_native_american TEXT,
    student_count_other_ethnicity TEXT,
    student_count_asian_pacific_islander TEXT,
    student_count_multi TEXT,
    student_count_hawaiian_pacific_islander TEXT,
    student_count_ethnicity_not_available TEXT,
    statistics_description TEXT,
    demographic_description TEXT,
    ada_accessible TEXT,
    dress_code TEXT,
    prek_school_day TEXT,
    kindergarten_school_day TEXT,
    school_hours TEXT,
    freshman_start_end_time TEXT,
    after_school_hours TEXT,
    earliest_drop_off_time TEXT,
    classroom_languages TEXT,
    bilingual_services TEXT,
    refugee_services TEXT,
    title_1_eligible TEXT,
    preschool_inclusive TEXT,
    preschool_instructional TEXT,
    significantly_modified TEXT,
    hard_of_hearing TEXT,
    visual_impairments TEXT,
    transportation_bus TEXT,
    transportation_el TEXT,
    transportation_metra TEXT,
    school_latitude TEXT,
    school_longitude TEXT,
    average_act_school TEXT,
    mean_act TEXT,
    college_enrollment_rate_school TEXT,
    college_enrollment_rate_mean TEXT,
    graduation_rate_school TEXT,
    graduation_rate_mean TEXT,
    overall_rating TEXT,
    rating_status TEXT,
    rating_statement TEXT,
    classification_description TEXT,
    school_year TEXT,
    third_contact_title TEXT,
    third_contact_name TEXT,
    fourth_contact_title TEXT,
    fourth_contact_name TEXT,
    fifth_contact_title TEXT,
    fifth_contact_name TEXT,
    sixth_contact_title TEXT,
    sixth_contact_name TEXT,
    seventh_contact_title TEXT,
    seventh_contact_name TEXT,
    location TEXT
);

\copy chicagoschools FROM 'Chicago_Public_Schools.csv' DELIMITER ',' CSV HEADER;

-- =====================================================================================
-- Question 1
-- From nycflights, show 10 flights from JFK to LAX with departure delay greater than 60 minutes.
-- Show: carrier, flight, origin, dest, dep_delay
-- Write your query below.



-- =====================================================================================
-- Question 2
-- From nycflights, show 10 distinct (carrier, origin) pairs.
-- Show: carrier, origin
-- Write your query below.



-- =====================================================================================
-- Question 3
-- From nycflights, find destinations that start with 'S' and have exactly 3 letters.
-- Show each destination only once.
-- Show: dest
-- Write your query below.



-- =====================================================================================
-- Question 4
-- From nycflights, count how many flights go to each destination.
-- Show: dest, frequency
-- Order from highest frequency to lowest frequency.
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 5
-- From nycflights, for each origin, count how many flights are:
--   Short  : distance < 500
--   Medium : 500 <= distance <= 1000
--   Long   : distance > 1000
-- Show: origin, short_flights, medium_flights, long_flights
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 6
-- From chicagoemployees, count how many employees are in each salary_or_hourly category.
-- Show: salary_or_hourly, frequency
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 7
-- Compute the probability that a randomly chosen employee is HOURLY.
-- Show: probability
-- This question naturally returns a single number, so LIMIT is not required.
-- Write your query below.



-- =====================================================================================
-- Question 8
-- From chicagoemployees, show 10 full-time employees whose job title contains the word 'POLICE'.
-- Show: name, job_titles, department
-- Write your query below.



-- =====================================================================================
-- Question 9
-- From londonweather, show the 10 hottest days.
-- Ignore rows where max_temp is NULL.
-- Show: date, max_temp, sunshine
-- Write your query below.



-- =====================================================================================
-- Question 10
-- From londonweather, group the days into three categories based on max_temp:
--   Cold : max_temp < 10
--   Mild : 10 <= max_temp < 20
--   Hot  : max_temp >= 20
-- Show: temp_category, days_count
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 11
-- From londonweather, find the days whose max_temp is above the average max_temp.
-- Ignore rows where max_temp is NULL.
-- Show: date, max_temp
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 12
-- From londonweather, show 10 rows with these derived columns:
--   date,
--   rounded_up_max_temp using CEIL(max_temp),
--   radiation_root using SQRT(global_radiation)
-- Ignore rows where max_temp or global_radiation is NULL.
-- Write your query below.



-- =====================================================================================
-- Question 13
-- From chicagoschools, count how many schools are in each primary_category.
-- Ignore rows where primary_category is empty.
-- Show: primary_category, frequency
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 14
-- From chicagoschools, show 10 schools whose short_name starts with 'A'.
-- Ignore rows where short_name is empty.
-- Show: short_name, primary_category
-- Write your query below.



-- =====================================================================================
-- Question 15
-- Short interpretation question.
-- Based on your answers to Question 6 and Question 7, what does the distribution of
-- salary vs hourly employees suggest?
-- Write your answer below as SQL comments.



-- =====================================================================================
-- Question 16
-- Short interpretation question.
-- Based on your answer to Question 4, are flights spread fairly evenly across destinations,
-- or concentrated in some destinations? Explain briefly.
-- Write your answer below as SQL comments.


