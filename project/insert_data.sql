-- MATH 251 Course Project:

-- 1. Drop tables if they exist to allow re-running the script
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS directors;

-- 2. Create Directors Table
CREATE TABLE directors (
    director_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- 3. Create Movies Table
CREATE TABLE movies (
    movie_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER,
    genre VARCHAR(100),
    duration INTEGER,
    avg_vote DECIMAL(3,1),
    director_id INTEGER REFERENCES directors(director_id)
);

-- 4. Create a temporary staging table to hold the CSV data
CREATE TEMP TABLE temp_movies (
    movie_id VARCHAR(50),
    title VARCHAR(255),
    year INTEGER,
    genre VARCHAR(100),
    duration INTEGER,
    director_name VARCHAR(255),
    avg_vote DECIMAL(3,1)
);

-- 5. Load data from the CSV file into the staging table
\copy temp_movies FROM 'movies_dataset.csv' WITH (FORMAT csv, HEADER true);

-- 6. Insert unique directors into the directors table
INSERT INTO directors (name)
SELECT DISTINCT director_name
FROM temp_movies
ON CONFLICT (name) DO NOTHING;

-- 7. Insert movies into the movies table, mapping director names to director_ids
INSERT INTO movies (movie_id, title, release_year, genre, duration, avg_vote, director_id)
SELECT 
    tm.movie_id, 
    tm.title, 
    tm.year, 
    tm.genre, 
    tm.duration, 
    tm.avg_vote, 
    d.director_id
FROM temp_movies tm
JOIN directors d ON tm.director_name = d.name
ON CONFLICT (movie_id) DO NOTHING;

-- 8. Verify the data
SELECT * FROM directors;
SELECT * FROM movies;

-- 9. Clean up the temporary table
DROP TABLE temp_movies;
