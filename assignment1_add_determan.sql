-- Note: Run "\i your_sql_file.sql" to execute all SQL commands in that file.
-- ========================================================
-- MATH 251 – Data Queries
-- Assignment 1 (Part 2): Inserting Data (DML)
-- ========================================================
-- Name: Cole Determan
-- JMU ID: 113893504
--
-- Instructions:
-- 1) Write your answers directly under each question.
-- 2) Your file must run TOP-to-BOTTOM with NO errors.
-- 3) Do NOT delete questions/headings.
-- 4) Insert EXACTLY the data provided below (do not modify values).
-- 5) Run Part 1 first (tables must already exist).
-- ========================================================

-- --------------------------------------------------------
-- (Optional) Clean re-run section (UNCOMMENT if needed)
-- --------------------------------------------------------
TRUNCATE TABLE sensor_reading;
TRUNCATE TABLE appointment;
TRUNCATE TABLE airport;
TRUNCATE TABLE student;

-- --------------------------------------------------------
-- Q1. Insert into student
-- --------------------------------------------------------
-- Insert the following 10 students EXACTLY as written.

-- YOUR ANSWER (replace placeholder):
INSERT INTO student (student_id, full_name, class_year, tuition_usd)
VALUES
(1, 'Alice Johnson', 2026, 15000.00),
(2, 'Bob Smith', 2025, 15200.00),
(3, 'Carol Lee', 2024, 14800.00),
(4, 'David Kim', 2026, 15100.00),
(5, 'Ella Brown', 2025, 14950.00),
(6, 'Frank Adams', 2024, 15050.00),
(7, 'Grace Nguyen', 2026, 14850.00),
(8, 'Hank Patel', 2025, 15075.00),
(9, 'Ivy Martinez', 2024, 14900.00),
(10, 'Jack O’Neil', 2026, 15150.00);


-- Data to insert:
-- (1, 'Alice Johnson', 2026, 15000.00)
-- (2, 'Bob Smith', 2025, 15200.00)
-- (3, 'Carol Lee', 2024, 14800.00)
-- (4, 'David Kim', 2026, 15100.00)
-- (5, 'Ella Brown', 2025, 14950.00)
-- (6, 'Frank Adams', 2024, 15050.00)
-- (7, 'Grace Nguyen', 2026, 14850.00)
-- (8, 'Hank Patel', 2025, 15075.00)
-- (9, 'Ivy Martinez', 2024, 14900.00)
-- (10, 'Jack O’Neil', 2026, 15150.00)

-- --------------------------------------------------------
-- Q2. Insert into airport
-- --------------------------------------------------------
-- Insert the following 10 airports EXACTLY as written.

-- YOUR ANSWER (replace placeholder):
INSERT INTO airport (code, name, country)
VALUES
('JFK', 'John F. Kennedy International', 'USA'),
('LHR', 'Heathrow Airport', 'UK'),
('NRT', 'Narita International', 'Japan'),
('DXB', 'Dubai International', 'UAE'),
('LAX', 'Los Angeles International', 'USA'),
('CDG', 'Charles de Gaulle', 'France'),
('HND', 'Tokyo Haneda', 'Japan'),
('FRA', 'Frankfurt Airport', 'Germany'),
('SYD', 'Sydney Kingsford Smith', 'Australia'),
('SFO', 'San Francisco International', 'USA');


-- Data to insert:
-- ('JFK', 'John F. Kennedy International', 'USA')
-- ('LHR', 'Heathrow Airport', 'UK')
-- ('NRT', 'Narita International', 'Japan')
-- ('DXB', 'Dubai International', 'UAE')
-- ('LAX', 'Los Angeles International', 'USA')
-- ('CDG', 'Charles de Gaulle', 'France')
-- ('HND', 'Tokyo Haneda', 'Japan')
-- ('FRA', 'Frankfurt Airport', 'Germany')
-- ('SYD', 'Sydney Kingsford Smith', 'Australia')
-- ('SFO', 'San Francisco International', 'USA')

-- --------------------------------------------------------
-- Q3. Insert into appointment
-- --------------------------------------------------------
-- Insert the following 10 appointments EXACTLY as written.
-- Do NOT insert created_at manually (use DEFAULT if defined).

-- YOUR ANSWER (replace placeholder):
INSERT INTO appointment (appt_id, patient_name, appt_date, appt_time, notes)
VALUES
(1, 'Jane Doe', '2026-02-10', '09:00', 'Check-up'),
(2, 'John Smith', '2026-02-11', '10:30', 'Follow-up'),
(3, 'Mary Jones', '2026-02-12', '14:00', 'Consultation'),
(4, 'Paul Adams', '2026-02-13', '11:15', 'Routine check'),
(5, 'Lucy Wright', '2026-02-14', '13:45', 'Initial consult'),
(6, 'Steve Clark', '2026-02-15', '16:00', 'Check-up'),
(7, 'Nina Lopez', '2026-02-16', '09:30', 'Vaccination'),
(8, 'Tom Evans', '2026-02-17', '15:00', 'Follow-up'),
(9, 'Olivia Green', '2026-02-18', '11:00', 'Routine check'),
(10, 'Gary White', '2026-02-19', '10:00', 'Consultation');


-- Data to insert:
-- (1, 'Jane Doe', '2026-02-10', '09:00', 'Check-up')
-- (2, 'John Smith', '2026-02-11', '10:30', 'Follow-up')
-- (3, 'Mary Jones', '2026-02-12', '14:00', 'Consultation')
-- (4, 'Paul Adams', '2026-02-13', '11:15', 'Routine check')
-- (5, 'Lucy Wright', '2026-02-14', '13:45', 'Initial consult')
-- (6, 'Steve Clark', '2026-02-15', '16:00', 'Check-up')
-- (7, 'Nina Lopez', '2026-02-16', '09:30', 'Vaccination')
-- (8, 'Tom Evans', '2026-02-17', '15:00', 'Follow-up')
-- (9, 'Olivia Green', '2026-02-18', '11:00', 'Routine check')
-- (10, 'Gary White', '2026-02-19', '10:00', 'Consultation')

-- --------------------------------------------------------
-- Q4. Insert into sensor_reading
-- --------------------------------------------------------
-- Insert the following 10 readings EXACTLY as written.
-- Ensure humidity values satisfy the CHECK constraint.

-- YOUR ANSWER (replace placeholder):
INSERT INTO sensor_reading (reading_id, sensor_name, measured_at, temperature_c, humidity_pct)
VALUES
(1, 'Sensor A', '2026-02-01 08:00:00', 22.5, 45.0),
(2, 'Sensor B', '2026-02-01 09:00:00', 21.8, 50.0),
(3, 'Sensor C', '2026-02-01 10:00:00', 23.0, 42.0),
(4, 'Sensor D', '2026-02-01 11:00:00', 22.3, 47.0),
(5, 'Sensor E', '2026-02-01 12:00:00', 22.9, 44.0),
(6, 'Sensor F', '2026-02-01 13:00:00', 23.2, 46.0),
(7, 'Sensor G', '2026-02-01 14:00:00', 21.5, 49.0),
(8, 'Sensor H', '2026-02-01 15:00:00', 22.0, 43.0),
(9, 'Sensor I', '2026-02-01 16:00:00', 21.9, 48.0),
(10, 'Sensor J', '2026-02-01 17:00:00', 22.7, 47.0);



-- Data to insert:
-- (1, 'Sensor A', '2026-02-01 08:00:00', 22.5, 45.0)
-- (2, 'Sensor B', '2026-02-01 09:00:00', 21.8, 50.0)
-- (3, 'Sensor C', '2026-02-01 10:00:00', 23.0, 42.0)
-- (4, 'Sensor D', '2026-02-01 11:00:00', 22.3, 47.0)
-- (5, 'Sensor E', '2026-02-01 12:00:00', 22.9, 44.0)
-- (6, 'Sensor F', '2026-02-01 13:00:00', 23.2, 46.0)
-- (7, 'Sensor G', '2026-02-01 14:00:00', 21.5, 49.0)
-- (8, 'Sensor H', '2026-02-01 15:00:00', 22.0, 43.0)
-- (9, 'Sensor I', '2026-02-01 16:00:00', 21.9, 48.0)
-- (10, 'Sensor J', '2026-02-01 17:00:00', 22.7, 47.0)

-- --------------------------------------------------------
-- Self-check (do not modify)
-- --------------------------------------------------------
SELECT COUNT(*) AS student_count FROM student;
SELECT COUNT(*) AS airport_count FROM airport;
SELECT COUNT(*) AS appointment_count FROM appointment;
SELECT COUNT(*) AS sensor_reading_count FROM sensor_reading;

SELECT 'Part 2 completed if all counts are 10.' AS status;
