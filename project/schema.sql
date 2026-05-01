-- MATH 251 Course Project: Database Schema
-- Topic: Top Rated Movies & Directors
-- Student: Cole Determan

-- Drop tables if they exist to allow re-running the script
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS directors;

-- 1. Create Directors Table
-- This table stores unique information about film directors.
CREATE TABLE directors (
    director_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- 2. Create Movies Table
-- This table stores movie details and references the directors table.
CREATE TABLE movies (
    movie_id VARCHAR(50) PRIMARY KEY, -- Using IMDb ID as the unique identifier
    title VARCHAR(255) NOT NULL,
    release_year INTEGER,
    genre VARCHAR(100),
    duration INTEGER, -- duration in minutes
    avg_vote DECIMAL(3,1),
    director_id INTEGER REFERENCES directors(director_id)
);
