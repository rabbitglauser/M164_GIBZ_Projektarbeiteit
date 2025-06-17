-- psql -h aws-0-eu-central-2.pooler.supabase.com -U postgres.fcvrfyxqmedmrugjylfo -p 6543 -d Projektarbeit -f ./fn_movie_rating_summary.sql

\c projektarbeit

-- ✅ This function meets the requirement:
--    "Minimum 1 Funktion (Analyse aus min 3 Tabellen)"

CREATE OR REPLACE FUNCTION fn_movie_rating_summary(movie_id INT)
RETURNS VARCHAR(255)
LANGUAGE plpgsql
AS $$
DECLARE
    avg_score DECIMAL(3,2);
    review_count INT;
    genre_name VARCHAR(50);
BEGIN
    SELECT
        COALESCE(AVG(r.Score), 0),      -- from Ratings
        COUNT(*),                       -- from Reviews
        COALESCE(g.GenreName, 'Unknown') -- from Genres
    INTO
        avg_score,
        review_count,
        genre_name
    FROM Ratings r
    JOIN Reviews rev ON r.MovieID = rev.MovieID AND r.UserID = rev.UserID
    JOIN Movies m ON r.MovieID = m.MovieID
    JOIN Genres g ON m.GenreID = g.GenreID
    WHERE r.MovieID = movie_id;

    RETURN CONCAT('Genre: ', genre_name, ', Average Score: ', avg_score, ', Reviews: ', review_count);
END;
$$;
