-- =====================================================================
-- MATH 251 — Class Assignment : Keys, Relationships, and Time
-- Topic coverage: PK, FK (REFERENCES), 1-to-many, many-to-many, time in PK
--
-- IMPORTANT:
-- 1) Write your answers ONLY inside the ANSWER BLOCKS.
-- 2) Your file must run TOP-to-BOTTOM with NO errors.
-- 3) Do NOT delete questions/headings.

DROP TABLE IF EXISTS
    CUSTOMER,
    ORDERS,
    LAB,
    SUPPLIER,
    LAB_SUPPLIER,
    LAB_PARTICIPANT,
    MEASUREMENTS;

-- =====================================================================
-- PART 1 — One-to-Many: CUSTOMERS → ORDERS
-- =====================================================================

/* Q1) Create tables CUSTOMER and ORDERS (one-to-many)

   Requirements:
   - CUSTOMER(CustomerID PK, Name, City)
   - ORDERS(OrderID PK, CustID FK REFERENCES CUSTOMER(CustomerID),
            OrderDate DATE, Amount DECIMAL(8,2))

   Notes:
   - FK must be declared with REFERENCES.
*/

-- ===== ANSWER BLOCK Q1 (DDL) START =====

CREATE TABLE CUSTOMER (
    CustomerID INT PRIMARY KEY,
    Name       VARCHAR(50),
    City       VARCHAR(50)
);

CREATE TABLE ORDERS (
    OrderID   INT PRIMARY KEY,
    CustID    INT REFERENCES CUSTOMER(CustomerID),
    OrderDate DATE,
    Amount    DECIMAL(8,2)
);

-- ===== ANSWER BLOCK Q1 (DDL) END =====


/* Q2) Insert 5 customers using these exact rows:

   CustomerID | Name         | City
   --------------------------------------
   3171       | 'Ava Stone'  | 'Harrisonburg'
   3172       | 'Noah Patel' | 'Charlottesville'
   3173       | 'Mina Chen'  | 'Richmond'
   3174       | 'Omar Davis' | 'Roanoke'
   3175       | 'Lia Gomez'  | 'Norfolk'
*/

-- ===== ANSWER BLOCK Q2 (INSERT customers) START =====

INSERT INTO CUSTOMER VALUES (3171, 'Ava Stone',  'Harrisonburg');
INSERT INTO CUSTOMER VALUES (3172, 'Noah Patel', 'Charlottesville');
INSERT INTO CUSTOMER VALUES (3173, 'Mina Chen',  'Richmond');
INSERT INTO CUSTOMER VALUES (3174, 'Omar Davis', 'Roanoke');
INSERT INTO CUSTOMER VALUES (3175, 'Lia Gomez',  'Norfolk');

-- ===== ANSWER BLOCK Q2 (INSERT customers) END =====


/* Q3) Insert exactly 10 orders (use these exact rows).
   Distribution:
     - Customer 3171: 3 orders
     - Customer 3172: 1 order
     - Customer 3173: 2 orders
     - Customer 3174: 1 order
     - Customer 3175: 3 orders

   Order rows (OrderID, CustID, OrderDate, Amount):
   (31711, 3171, '2026-02-03',  19.99)
   (31712, 3171, '2026-02-05',  25.00)
   (31713, 3171, '2026-02-07',  37.50)
   (31714, 3172, '2026-02-10',  40.00)
   (31715, 3173, '2026-02-12',  55.25)
   (31716, 3173, '2026-02-14',  60.00)
   (31717, 3174, '2026-02-16',  75.75)
   (31718, 3175, '2026-02-18',  89.90)
   (31719, 3175, '2026-02-20', 120.00)
   (31720, 3175, '2026-02-22', 210.10
   )
*/

-- ===== ANSWER BLOCK Q3 (INSERT orders) START =====

INSERT INTO ORDERS VALUES (31711, 3171, '2026-02-03',  19.99);
INSERT INTO ORDERS VALUES (31712, 3171, '2026-02-05',  25.00);
INSERT INTO ORDERS VALUES (31713, 3171, '2026-02-07',  37.50);
INSERT INTO ORDERS VALUES (31714, 3172, '2026-02-10',  40.00);
INSERT INTO ORDERS VALUES (31715, 3173, '2026-02-12',  55.25);
INSERT INTO ORDERS VALUES (31716, 3173, '2026-02-14',  60.00);
INSERT INTO ORDERS VALUES (31717, 3174, '2026-02-16',  75.75);
INSERT INTO ORDERS VALUES (31718, 3175, '2026-02-18',  89.90);
INSERT INTO ORDERS VALUES (31719, 3175, '2026-02-20', 120.00);
INSERT INTO ORDERS VALUES (31720, 3175, '2026-02-22', 210.10);

-- ===== ANSWER BLOCK Q3 (INSERT orders) END =====


/* Q4) FK enforcement (do NOT execute).
   A failing insert example (commented) that should be rejected by the DB:
   -- INSERT INTO ORDERS VALUES (31999, 9999, '2026-02-03', 19.99);
*/

-- ===== ANSWER BLOCK Q4 (commented failing insert) START =====

-- INSERT INTO ORDERS VALUES (31999, 9999, '2026-02-03', 19.99);
-- ===== ANSWER BLOCK Q4 (commented failing insert) END =====
