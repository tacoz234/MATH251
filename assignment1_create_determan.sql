-- Note: Run "\i your_sql_file.sql" command execute all SQL commands in the file your_sql_file.sql.
-- ========================================================
-- MATH 251 – Data Queries
-- Assignment 1 (part 1): Creating Tables (DDL)
-- ========================================================
-- Name: Cole Determan
-- JMU ID: 113893504
--
-- Instructions:
-- 1) Write your answers directly under each question.
-- 2) Your file must run TOP-to-BOTTOM with NO errors.
-- 3) Do not delete questions/headings.
-- 4) If you are stuck, keep a placeholder SELECT so the file still runs.
--
-- Optional: to avoid "table already exists" errors while testing, you may
--           uncomment the DROP TABLE statements below (in the given order).
-- ========================================================

-- --------------------------------------------------------
-- (Optional) Clean re-run section (UNCOMMENT if needed)
-- --------------------------------------------------------
DROP TABLE IF EXISTS sensor_reading;
DROP TABLE IF EXISTS appointment;
DROP TABLE IF EXISTS airport;
DROP TABLE IF EXISTS student;

-- --------------------------------------------------------
-- Q1. Create table: student
-- --------------------------------------------------------
-- Create a table student with:
--   - student_id   as an integer primary key
--   - full_name    as a variable-length string
--   - class_year   as an integer (e.g., 2026)
--   - tuition_usd  as DECIMAL(8,2)
-- Add NOT NULL where it makes sense.

-- YOUR ANSWER (replace placeholder):
CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    class_year INTEGER,
    tuition_usd DECIMAL(8,2)
);

-- --------------------------------------------------------
-- Q2. Create table: airport
-- --------------------------------------------------------
-- Create a table airport with:
--   - code     as a 3-character airport code (e.g., 'JFK')
--   - name     as a string
--   - country  as a string
-- Make code the primary key.
-- Add a constraint to enforce that code is exactly 3 characters.

-- YOUR ANSWER (replace placeholder):
CREATE TABLE airport (
    code VARCHAR(3) PRIMARY KEY,
    name VARCHAR(255),
    country VARCHAR(255)
);



-- --------------------------------------------------------
-- Q3. Create table: appointment
-- --------------------------------------------------------
-- Create a table appointment with:
--   - appt_id       as a primary key
--   - patient_name  as a string
--   - appt_date     as DATE
--   - appt_time     as TIME
--   - created_at    as TIMESTAMP with a DEFAULT value
--   - notes         as optional long text

-- YOUR ANSWER (replace placeholder):
CREATE TABLE appointment (
    appt_id INTEGER PRIMARY KEY,
    patient_name VARCHAR(255),
    appt_date DATE,
    appt_time TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);



-- --------------------------------------------------------
-- Q4. Create table: sensor_reading
-- --------------------------------------------------------
-- Create a table sensor_reading with:
--   - reading_id      as a primary key
--   - sensor_name     as a string
--   - measured_at     as a TIMESTAMP
--   - temperature_c   as FLOAT
--   - humidity_pct    as FLOAT, allow missing values (NULL allowed)
-- Add a CHECK constraint:
--   - humidity_pct must be between 0 and 100 WHEN it is present
--     (i.e., allow NULL, but if not NULL it must satisfy the range).

-- YOUR ANSWER (replace placeholder):
CREATE TABLE sensor_reading (
    reading_id INTEGER PRIMARY KEY,
    sensor_name VARCHAR(255),
    measured_at TIMESTAMP,
    temperature_c FLOAT,
    humidity_pct FLOAT CHECK (humidity_pct >= 0 AND humidity_pct <= 100 OR humidity_pct IS NULL)
);



-- --------------------------------------------------------
-- Quick self-check (do not modify)
-- --------------------------------------------------------
-- After you write your CREATE TABLE statements above, you can run:
--   \dt
-- in psql to list your tables.
--
-- These queries should run if your tables were created successfully:
SELECT 'Tables created successfully if these SELECTs run.' AS status;

