-- psql -h aws-0-eu-central-2.pooler.supabase.com -U postgres.fcvrfyxqmedmrugjylfo -p 6543 -d Projektarbeit -f ./create_tables.sql
-- Cleaned up script for Supabase (default DB: postgres)
\c projektarbeit
-- Drop tables (in correct dependency order)
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS users;

-- Create genres table
CREATE TABLE genres (
    GenreID SERIAL PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);

-- Create movies table
CREATE TABLE movies (
    MovieID SERIAL PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    GenreID INT REFERENCES genres(GenreID)
);

-- Create users table
CREATE TABLE users (
    UserID SERIAL PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    RegistrationDate TIMESTAMP DEFAULT NOW()
);

-- Create ratings table
CREATE TABLE ratings (
    RatingID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    MovieID INT REFERENCES movies(MovieID),
    UserID INT REFERENCES users(UserID),
    Score DECIMAL(3, 2) NOT NULL,
    RatingDate TIMESTAMP DEFAULT NOW()
);

CREATE TABLE AuditLog (
    LogID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UserID INT REFERENCES Users(UserID),
    MovieID INT REFERENCES Movies(MovieID),
    Action TEXT NOT NULL,
    LogDate TIMESTAMP DEFAULT NOW()
);

-- Create reviews table
CREATE TABLE reviews (
    ReviewID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    MovieID INT REFERENCES movies(MovieID),
    UserID INT REFERENCES users(UserID),
    ReviewText TEXT,
    ReviewDate TIMESTAMP DEFAULT NOW()
);

-- Load data from CSV files
\COPY genres FROM '../scripts/genres.csv' DELIMITER ',' CSV HEADER;
\COPY movies FROM '../scripts/movies.csv' DELIMITER ',' CSV HEADER;
