-- Run with:
-- psql -h aws-0-eu-north-1.pooler.supabase.com -U postgres.suhfyfxibbdebnmouxuk -p 6543 -d postgres -f ./import/import.sql

\c postgres

DROP TABLE IF EXISTS raw_movies;

-- Create raw_movies table for import
CREATE TABLE IF NOT EXISTS raw_movies
(
    MovieID      SERIAL PRIMARY KEY,
    MovieTitle   VARCHAR(255) NOT NULL,
    ReleaseYear  INT NOT NULL,
    GenreID      INT,
    GenreName    VARCHAR(50),
    ActorID      INT,
    ActorName    VARCHAR(100),
    DirectorID   INT,
    DirectorName VARCHAR(100),
    ReviewerID   INT,
    ReviewID     INT,
    ReviewRating NUMERIC(3,1),
    ReviewComment TEXT,
    ReviewerName VARCHAR(100)
);

-- Import data from CSV (make sure the path is correct)
\COPY raw_movies FROM './import/movies.csv' DELIMITER ',' CSV HEADER;

-- Load normalization script
\i ./normalization/normalize.sql
