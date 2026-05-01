# MATH 251 Course Project: Data Collection and Database Design

## Topic: IMDb Top Rated Movies & Directors

### 1. Dataset Description
This dataset contains a collection of 30 top-rated movies as listed on IMDb. It includes information such as the movie title, release year, genre, duration (in minutes), average user vote, and the director's name. 

**Why I chose this topic:**
I have a deep passion for cinema and previously took several film classes where I learned about the technical and artistic aspects of filmmaking. I even used to make my own short films! I am a huge fan of Christopher Nolan's work (especially *Inception* and *The Dark Knight*), so I wanted to build a database that allows me to analyze the filmography of top directors like him.

### 2. Data Source
The data was collected from the publicly available IMDb dataset via GitHub. 
*   **Original Source:** [IMDb Dataset](https://gist.github.com/stungeye/a3af50385215b758637e73eaacac93a3)

### 3. Database Schema Design
I designed a relational database with two tables connected through a primary-foreign key relationship:

*   **Table 1: `directors`**
    *   `director_id` (Primary Key): A unique integer assigned to each director.
    *   `name`: The full name of the director (Unique).

*   **Table 2: `movies`**
    *   `movie_id` (Primary Key): The unique IMDb identifier (e.g., tt0111161).
    *   `title`: The name of the movie.
    *   `release_year`: The year the movie was released.
    *   `genre`: The primary genre of the movie.
    *   `duration`: Length of the movie in minutes.
    *   `avg_vote`: The average rating from user reviews.
    *   `director_id` (Foreign Key): Links each movie to its director in the `directors` table.

### 4. Relational Diagram (Conceptual)


### 5. Sample Questions Answered
*   Which movies in the top 30 were directed by Christopher Nolan?
*   What is the average user rating per genre?
*   Which directors have multiple movies in this top-rated list?
*   What is the longest movie in the collection?
*   How has the volume of top-rated films changed across decades?
