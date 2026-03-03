-- =====================================================================
-- MATH 251 — Class Assignment : Keys, Relationships, and Time
-- Topic coverage: PK, FK (REFERENCES), 1-to-many, many-to-many, time in PK
--
-- IMPORTANT:
-- 1) Write your answers ONLY inside the ANSWER BLOCKS.
-- 2) Your file must run TOP-to-BOTTOM with NO errors.
-- 3) Do NOT delete questions/headings.



-- =====================================================================
-- PART 2 — Many-to-Many: LABS ↔ SUPPLIERS (via junction table)
-- =====================================================================

/* Q5) Create three tables: LAB, SUPPLIER, and LAB_SUPPLIER.

   Requirements:
   - LAB(LabID PK, LabName, City)
   - SUPPLIER(SupplierID PK, SupplierName)
   - LAB_SUPPLIER(LabID FK REFERENCES LAB(LabID),
                  SupplierID FK REFERENCES SUPPLIER(SupplierID),
                  PRIMARY KEY (LabID, SupplierID))
*/

-- ===== ANSWER BLOCK Q5 (DDL) START =====

CREATE TABLE LAB (
    LabID   INT PRIMARY KEY,
    LabName VARCHAR(50),
    City    VARCHAR(50)
);

CREATE TABLE SUPPLIER (
    SupplierID   INT PRIMARY KEY,
    SupplierName VARCHAR(50)
);

CREATE TABLE LAB_SUPPLIER (
    LabID      INT REFERENCES LAB(LabID),
    SupplierID INT REFERENCES SUPPLIER(SupplierID),
    PRIMARY KEY (LabID, SupplierID)
);

-- ===== ANSWER BLOCK Q5 (DDL) END =====


/* Q6) Insert 3 labs and 4 suppliers using these exact rows:

   LAB rows (LabID, LabName, City):
   (3171, 'Blue Ridge Lab', 'Harrisonburg')
   (3172, 'Piedmont Lab',   'Charlottesville')
   (3173, 'Tidewater Lab',  'Norfolk')

   SUPPLIER rows (SupplierID, SupplierName):
   (3171, 'SigmaChem')
   (3172, 'NovaReagents')
   (3173, 'Atlas Compounds')
   (3174, 'Pioneer Scientific')
*/

-- ===== ANSWER BLOCK Q6 (INSERT labs & suppliers) START =====

INSERT INTO LAB VALUES (3171, 'Blue Ridge Lab', 'Harrisonburg');
INSERT INTO LAB VALUES (3172, 'Piedmont Lab',   'Charlottesville');
INSERT INTO LAB VALUES (3173, 'Tidewater Lab',  'Norfolk');

INSERT INTO SUPPLIER VALUES (3171, 'SigmaChem');
INSERT INTO SUPPLIER VALUES (3172, 'NovaReagents');
INSERT INTO SUPPLIER VALUES (3173, 'Atlas Compounds');
INSERT INTO SUPPLIER VALUES (3174, 'Pioneer Scientific');

-- ===== ANSWER BLOCK Q6 (INSERT labs & suppliers) END =====


/* Q7) Insert relationships into LAB_SUPPLIER (exactly 7 rows):

   Use these exact pairs (LabID, SupplierID):
   (3171, 3171)
   (3171, 3172)
   (3171, 3173)
   (3172, 3172)
   (3172, 3174)
   (3173, 3171)
   (3173, 3174)

   (This satisfies: each lab >=2 suppliers, each supplier >=1 lab, and leaves one pair missing.)
*/

-- ===== ANSWER BLOCK Q7 (INSERT LAB_SUPPLIER pairs) START =====

INSERT INTO LAB_SUPPLIER VALUES (3171, 3171);
INSERT INTO LAB_SUPPLIER VALUES (3171, 3172);
INSERT INTO LAB_SUPPLIER VALUES (3171, 3173);
INSERT INTO LAB_SUPPLIER VALUES (3172, 3172);
INSERT INTO LAB_SUPPLIER VALUES (3172, 3174);
INSERT INTO LAB_SUPPLIER VALUES (3173, 3171);
INSERT INTO LAB_SUPPLIER VALUES (3173, 3174);

-- ===== ANSWER BLOCK Q7 (INSERT LAB_SUPPLIER pairs) END =====


/* Q8) Composite PK enforcement (do NOT execute).
   A failing duplicate insert (commented):
   -- INSERT INTO LAB_SUPPLIER VALUES (3171, 3171);
*/

-- ===== ANSWER BLOCK Q8 (commented failing insert) START =====

-- INSERT INTO LAB_SUPPLIER VALUES (3171, 3171);

-- ===== ANSWER BLOCK Q8 (commented failing insert) END =====


