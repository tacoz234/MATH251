-- =====================================================================
-- MATH 251 — Class Assignment : Keys, Relationships, and Time
-- Topic coverage: PK, FK (REFERENCES), 1-to-many, many-to-many, time in PK
--
-- IMPORTANT:
-- 1) Do NOT use JOIN, GROUP BY, HAVING, subqueries, views, triggers, etc.
-- 2) Use ONLY: CREATE TABLE, INSERT INTO, and (when asked) UPDATE / DELETE.
-- 3) Write your answers ONLY inside the ANSWER BLOCKS.
-- 4) All IDs and values are provided below — no computation needed.
-- =====================================================================

-- ---------------------------------------------------------------------
-- NOTE: This simplified version PROVIDES exact IDs and values.
--       Students should copy these exact values into their INSERT statements.
-- ---------------------------------------------------------------------


-- =====================================================================
-- PART 3 — Incorporating Time: LAB → PARTICIPANT → MEASUREMENTS
-- =====================================================================

/* Q9) Create tables LAB_PARTICIPANT and MEASUREMENTS.

   Requirements:
   - LAB_PARTICIPANT(
        PId INT PRIMARY KEY,
        LabID INT FOREIGN KEY REFERENCES LAB(LabID),
        PName VARCHAR(40)
     )

   - MEASUREMENTS(
        PId  INT FOREIGN KEY REFERENCES LAB_PARTICIPANT(PId),
        Date DATE,
        Time TIME,
        heart_rate INT,
        temperature FLOAT,
        PRIMARY KEY (PId, Date, Time)
     )
*/

-- ===== ANSWER BLOCK Q9 (DDL) START =====
/* Write your CREATE TABLE statements here (LAB_PARTICIPANT, MEASUREMENTS) */


-- ===== ANSWER BLOCK Q9 (DDL) END =====


/* Q10) Insert 4 participants (exact rows):

   Participant rows (PId, LabID, PName):
   (3171, 3171, 'Participant A')
   (3172, 3171, 'Participant B')
   (3173, 3172, 'Participant C')
   (3174, 3173, 'Participant D')
*/

-- ===== ANSWER BLOCK Q10 (INSERT participants) START =====
/* Write INSERT INTO LAB_PARTICIPANT using the exact rows above */


-- ===== ANSWER BLOCK Q10 (INSERT participants) END =====


/* Q11) Insert measurements (exact 16 rows).
   Use dates: '2026-02-21' and '2026-02-22'
   Times: '09:00' and '18:00'

   For participant PId = 3171 (p=1):
     ('2026-02-21','09:00') -> heart_rate 61, temp 98.1
     ('2026-02-21','18:00') -> heart_rate 71, temp 98.6
     ('2026-02-22','09:00') -> heart_rate 66, temp 98.1
     ('2026-02-22','18:00') -> heart_rate 76, temp 98.6

   For participant PId = 3172 (p=2):
     ('2026-02-21','09:00') -> heart_rate 62, temp 98.2
     ('2026-02-21','18:00') -> heart_rate 72, temp 98.7
     ('2026-02-22','09:00') -> heart_rate 67, temp 98.2
     ('2026-02-22','18:00') -> heart_rate 77, temp 98.7

   For participant PId = 3173 (p=3):
     ('2026-02-21','09:00') -> heart_rate 63, temp 98.3
     ('2026-02-21','18:00') -> heart_rate 73, temp 98.8
     ('2026-02-22','09:00') -> heart_rate 68, temp 98.3
     ('2026-02-22','18:00') -> heart_rate 78, temp 98.8

   For participant PId = 3174 (p=4):
     ('2026-02-21','09:00') -> heart_rate 64, temp 98.4
     ('2026-02-21','18:00') -> heart_rate 74, temp 98.9
     ('2026-02-22','09:00') -> heart_rate 69, temp 98.4
     ('2026-02-22','18:00') -> heart_rate 79, temp 98.9
*/

-- ===== ANSWER BLOCK Q11 (INSERT measurements) START =====
/* Write INSERT INTO MEASUREMENTS using the exact 16 rows above */


-- ===== ANSWER BLOCK Q11 (INSERT measurements) END =====


/* Q12) Composite PK enforcement (do NOT execute).
   A failing duplicate insert (commented):
   -- INSERT INTO MEASUREMENTS VALUES (3171, '2026-02-21', '09:00', 999, 99.9);
*/

-- ===== ANSWER BLOCK Q12 (commented failing insert) START =====
/* (Keep as a comment) Paste the example duplicate INSERT here if desired */


-- ===== ANSWER BLOCK Q12 (commented failing insert) END =====


