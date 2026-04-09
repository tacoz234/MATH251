-- Assignment 6: Chapter 3.1-3.2
-- Basic SQL only: use only the ideas covered in class/slides.
-- Time: 25 minutes
-- Important:
-- 1) Keep each answer as a single query.
-- 2) Unless the question naturally returns fewer rows, limit the output to only 10 records.
-- 3) Put the CSV files in the same folder as this SQL file before running it in psql.
-- 4) Do not change the table definitions or the \copy commands.

--Note from my answers to this assignment: The Chicago employee file contains formatted values like $165,624.00, 
--so defining salary-related columns as numeric can interfere with import behavior. 
--I fixed that by making the employee columns text-based and also made the employee queries more robust with TRIM and UPPER.
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
-- From nycflights, show the 10 flights with the largest departure delay.
-- Show: carrier, flight, origin, dest, dep_delay
-- Write your query below.



-- =====================================================================================
-- Question 2
-- From nycflights, count how many flights depart from each origin airport.
-- Show: origin, frequency
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 3
-- From londonweather, show the 10 days with the highest recorded maximum temperature.
-- Ignore rows where max_temp is NULL.
-- Show: date, max_temp, sunshine
-- Write your query below.



-- =====================================================================================
-- Question 4
-- From londonweather, group the days into three categories:
--   Cold  : max_temp < 10
--   Mild  : 10 <= max_temp < 20
--   Hot   : max_temp >= 20
-- Count how many days fall in each category.
-- Show: temp_category, days_count
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 5
-- From chicagoemployees, show the first 10 full-time employees.
-- Show: name, job_titles, salary_or_hourly
-- Write your query below.



-- =====================================================================================
-- Question 6
-- From chicagoemployees, count how many employees are SALARY and how many are HOURLY.
-- Show: salary_or_hourly, frequency
-- Limit output to 10 records.
-- Write your query below.



-- =====================================================================================
-- Question 7
-- From chicagoschools, show the 10 schools with the largest student_count_total.
-- Ignore rows where student_count_total is empty.
-- Show: short_name, primary_category, student_count_total
-- Write your query below.



-- =====================================================================================
-- Question 8
-- From chicagoschools, count how many schools belong to each primary_category.
-- Ignore rows where primary_category is empty.
-- Show: primary_category, frequency
-- Limit output to 10 records.
-- Write your query below.


