/*
================================================================================
MATH 251 - SQL Assignment
Dataset: NYC Flights 2013 (flights.csv)
================================================================================

NOTE ON QUERY TYPES USED IN THIS ASSIGNMENT
================================================================================

This assignment uses only the SQL concepts covered in class:

    SELECT, FROM, WHERE, ORDER BY, LIMIT, DISTINCT

However, some queries combine these ideas in standard ways.

1. Top-k and Bottom-k Queries
-----------------------------
Some questions ask for:
    - "top 10", "largest", or "most delayed"
    - "smallest", "earliest", etc.

These are implemented using:

    ORDER BY column DESC   -- for largest values (Top-k)
    ORDER BY column ASC    -- for smallest values (Bottom-k)
    LIMIT k                -- to return only k rows

Example:
    SELECT *
    FROM flights
    ORDER BY dep_delay DESC
    LIMIT 10;

This is called a "top-k query".

2. Combining WHERE, ORDER BY, and LIMIT
----------------------------------------
Some queries use multiple clauses together:

    WHERE    -> filter rows
    ORDER BY -> sort rows
    LIMIT    -> return only a small number of rows

This is a natural combination of concepts already covered in class.

3. Visualization-Ready Subsets
------------------------------
The dataset is large, so some queries are designed to return a small number
of rows that can later be visualized (e.g., in Excel or Python).

These queries are still based only on:
    SELECT, WHERE, ORDER BY, LIMIT

No new SQL concepts are introduced.

/*
================================================================================
NOTE ON DISTINCT (NEW KEYWORD IN THIS ASSIGNMENT)
================================================================================

In this assignment, we will also use a new keyword:

    DISTINCT

DISTINCT is used to remove duplicate rows from the result.

For example, the column "origin" contains many repeated values like:
    JFK, JFK, JFK, LGA, LGA, EWR, ...

If we want to see only the unique airports, we use:

Example:
    SELECT DISTINCT origin
    FROM flights;

Result:
    JFK
    LGA
    EWR

So:
- SELECT origin        → shows all rows (with duplicates)
- SELECT DISTINCT origin → shows only unique values

We will use DISTINCT only in a few simple queries later in this assignment.

================================================================================
*/

================================================================================

GOAL
----
In this assignment, you will:
1. Create a table for the flights dataset
2. Import the CSV file
3. Write basic SQL queries using:
      SELECT, FROM, WHERE, ORDER BY, LIMIT, DISTINCT
4. Create small subsets of the data that are suitable for visualization

IMPORTANT
---------
- Write your answers directly below each question.
- Do not delete the instructions.
- Use only the SQL ideas covered in class.
- Do NOT use GROUP BY, aggregates, joins, subqueries, or CASE.

DATASET
-------
Download the dataset from:
https://www.openintro.org/data/index.php?data=nycflights

Save it as:
flights.csv

TABLE NAME
----------
Use the table name:
flights

================================================================================
PART 0. CREATE THE TABLE
================================================================================
*/

DROP TABLE IF EXISTS flights;

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

/*
================================================================================
PART 1. IMPORT THE DATA
================================================================================

Option A:
Use the Import/Export tool in pgAdmin.

Option B:
Use COPY if it works on your computer.

Replace the path below with the full path to your file.

Example Mac:
'/Users/yourname/Downloads/flights.csv'

Example Windows:
'C:/Users/yourname/Downloads/flights.csv'
*/

-- OPTIONAL: Uncomment and edit if COPY works on your computer.
-- COPY flights
-- FROM '/full/path/to/flights.csv'
-- WITH (FORMAT CSV, HEADER TRUE);
\copy flights FROM 'nycflights.csv' WITH (FORMAT CSV, HEADER TRUE);

/*
Run this query after importing to confirm that the table is not empty.
*/

SELECT *
FROM flights
LIMIT 10;

/*
================================================================================
PART 2. BASIC SELECT QUERIES
================================================================================
*/

-- Q1. Show all columns for the first 5 rows.




-- Q2. Show only carrier, flight, origin, and dest for the first 10 rows.




-- Q3. Show only origin and dest for the first 10 rows.




/*
================================================================================
PART 3. WHERE CLAUSE
================================================================================
*/

-- Q4. Show the flights whose destination is 'ORD' for the first 10 rows.




-- Q5. Show the flights whose origin is 'JFK' for the first 10 rows.




-- Q6. Show all flights in January (month = 1) for the first 10 rows.



-- Q7. Show carrier, flight, origin, dest, dep_delay
-- for flights with dep_delay greater than 60 for the first 10 rows.




-- Q8. Show carrier, flight, origin, dest, distance
-- for flights whose distance is greater than 2000 for the first 10 rows.




-- Q9. Show all flights from JFK to MIA for the first 10 rows.




-- Q10. Show all flights from EWR with dep_delay greater than 30 for the first 10 rows.



/*
================================================================================
PART 4. ORDER BY
================================================================================
*/

-- Q11. Show the first 10 rows ordered by dep_delay from smallest to largest.




-- Q12. Show the first 10 rows ordered by dep_delay from largest to smallest.




-- Q13. Show carrier, flight, origin, dest, distance
-- ordered by distance from largest to smallest.
-- Return only the first 10 rows.




-- Q14. Show carrier, flight, origin, dest, arr_delay
-- ordered by arr_delay from largest to smallest.
-- Return only the first 10 rows.




/*
================================================================================
PART 5. DISTINCT
================================================================================
*/

-- Q15. Show the distinct origin airports for the first 10 rows.




-- Q16. Show the distinct destination airports for the first 10 rows.




-- Q17. Show the distinct carriers for the first 10 rows.




-- Q18. Show the distinct pairs (origin, dest) for the first 10 rows.




/*
================================================================================
PART 6. COMBINING WHERE, ORDER BY, AND LIMIT
================================================================================
*/

-- Q19. Show the 10 most delayed flights departing from JFK.
-- Include carrier, flight, dest, dep_delay.




-- Q20. Show the 10 longest flights departing from LGA.
-- Include carrier, flight, dest, distance.




-- Q21. Show the first 10 flights from EWR to ORD ordered by dep_time.




-- Q22. Show the first 10 flights to MIA with arr_delay greater than 30,
-- ordered by arr_delay from largest to smallest.




/*
================================================================================
PART 7. VISUALIZATION-READY SUBSETS
================================================================================

The full dataset is too large to visualize directly. In this part, create
small tables or query results that would be reasonable to visualize later
in Excel, Google Sheets, Python, or another tool.

Do NOT make a chart here. Just create a small, clean subset.

For each question below:
1. Write a query that returns a small number of rows.
2. The result should be easy to visualize.

Suggested idea:
- Use LIMIT
- Filter to one origin or one destination
- Sort clearly

*/

-- Q23. Create a small table-ready result showing 10 flights from JFK.
-- Include: day, dep_time, dep_delay, dest
-- Order by dep_delay from largest to smallest.




-- Q24. Create a small table-ready result showing 10 flights to ORD.
-- Include: origin, carrier, flight, arr_delay
-- Order by arr_delay from largest to smallest.




-- Q25. Create a small table-ready result showing 10 long-distance flights.
-- Include: origin, dest, distance, carrier
-- Only include flights with distance > 2000
-- Order by distance from largest to smallest.




/*
Optional:
If your SQL system allows exporting query results, you may export one of the
three results above as a CSV file for later visualization.

Example file names:
- viz_subset1.csv
- viz_subset2.csv
- viz_subset3.csv
*/


/*
================================================================================
PART 8. SHORT REFLECTION
================================================================================

Answer the following using SQL comments.

1. Which query was easiest for you?
2. Which query was most challenging for you?
3. Why is LIMIT useful when working with a large dataset?
*/

-- Reflection 1:


-- Reflection 2:


-- Reflection 3:


/*
================================================================================
END OF ASSIGNMENT
================================================================================
*/
