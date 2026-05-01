-- MATH 251 Course Project:

-- 1. List all movies directed by Christopher Nolan.
SELECT m.title, m.release_year, m.avg_vote
FROM movies m
JOIN directors d ON m.director_id = d.director_id
WHERE d.name = 'Christopher Nolan'
ORDER BY m.release_year DESC;

-- 2. Find the average rating for each genre.
SELECT genre, ROUND(AVG(avg_vote), 2) as average_rating
FROM movies
GROUP BY genre
ORDER BY average_rating DESC;

-- 3. List directors who have more than one movie in the top 30 list.
SELECT d.name, COUNT(m.movie_id) as movie_count
FROM directors d
JOIN movies m ON d.director_id = m.director_id
GROUP BY d.name
HAVING COUNT(m.movie_id) > 1
ORDER BY movie_count DESC;

-- 4. Find the longest movie in the dataset and its director.
SELECT m.title, m.duration, d.name as director
FROM movies m
JOIN directors d ON m.director_id = d.director_id
ORDER BY m.duration DESC
LIMIT 1;

-- 5. Calculate the total number of movies released in each decade.
SELECT (release_year / 10) * 10 as decade, COUNT(*) as movie_count
FROM movies
GROUP BY decade
ORDER BY decade ASC;
