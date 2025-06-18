-- Run with:
-- psql -h aws-0-eu-north-1.pooler.supabase.com -U postgres.suhfyfxibbdebnmouxuk -p 6543 -d postgres -f ./normalization/normalize.sql

-- Drop previous tables if rerunning (removed movie_genres & auditlog if unused)
DROP TABLE IF EXISTS ratings, reviews, movies, genres, users, actors, directors, movie_actors, movie_directors CASCADE;

-- 1. Genres
CREATE TABLE genres
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

INSERT INTO genres(name)
SELECT DISTINCT GenreName
FROM raw_movies;

-- 2. Movies
CREATE TABLE movies
(

    title        VARCHAR(200) NOT NULL,
    release_year INT          NOT NULL,
    genre_id     INT REFERENCES genres (id) ON DELETE CASCADE
);

INSERT INTO movies(title, release_year, genre_id)
SELECT DISTINCT MovieTitle, ReleaseYear, g.id
FROM raw_movies r
JOIN genres g ON r.GenreName = g.name;

-- 3. Actors
CREATE TABLE actors
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(200) UNIQUE
);

INSERT INTO actors(name)
SELECT DISTINCT ActorName
FROM raw_movies;

-- 4. Movie Actors (many-to-many)
CREATE TABLE movie_actors
(
    movie_id INT REFERENCES movies (id) ON DELETE CASCADE,
    actor_id INT REFERENCES actors (id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, actor_id)
);

INSERT INTO movie_actors(movie_id, actor_id)
SELECT m.id,
       a.id
FROM raw_movies r
JOIN movies m ON r.MovieTitle = m.title AND r.ReleaseYear = m.release_year
JOIN actors a ON r.ActorName = a.name;

-- 5. Directors
CREATE TABLE directors
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(200) UNIQUE
);

INSERT INTO directors(name)
SELECT DISTINCT DirectorName
FROM raw_movies;

-- 6. Movie Directors (many-to-many)
CREATE TABLE movie_directors
(
    movie_id    INT REFERENCES movies (id) ON DELETE CASCADE,
    director_id INT REFERENCES directors (id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, director_id)
);

INSERT INTO movie_directors(movie_id, director_id)
SELECT m.id,
       d.id
FROM raw_movies r
JOIN movies m ON r.MovieTitle = m.title AND r.ReleaseYear = m.release_year
JOIN directors d ON r.DirectorName = d.name;

-- 7. Users
CREATE TABLE users
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO users(name)
SELECT DISTINCT ReviewerName
FROM raw_movies;

-- 8. Ratings
CREATE TABLE ratings
(
    id          SERIAL PRIMARY KEY,
    movie_id    INT REFERENCES movies (id) ON DELETE CASCADE,
    user_id     INT REFERENCES users (id) ON DELETE CASCADE,
    score       DECIMAL(2, 1) NOT NULL,
    rating_date DATE          NOT NULL
);

INSERT INTO ratings(movie_id, user_id, score, rating_date)
SELECT m.id,
       u.id,
       r.ReviewRating,
       CURRENT_DATE
FROM raw_movies r
JOIN movies m ON r.MovieTitle = m.title AND r.ReleaseYear = m.release_year
JOIN users u ON r.ReviewerName = u.name;

-- 9. Reviews
CREATE TABLE reviews
(
    id          SERIAL PRIMARY KEY,
    movie_id    INT REFERENCES movies (id) ON DELETE CASCADE,
    user_id     INT REFERENCES users (id) ON DELETE CASCADE,
    review_text TEXT,
    review_date DATE NOT NULL
);

INSERT INTO reviews(movie_id, user_id, review_text, review_date)
SELECT m.id,
       u.id,
       r.ReviewComment,
       CURRENT_DATE
FROM raw_movies r
JOIN movies m ON r.MovieTitle = m.title AND r.ReleaseYear = m.release_year
JOIN users u ON r.ReviewerName = u.name;

-- Optional preview
SELECT * FROM ratings LIMIT 5;
