-- psql -h aws-0-eu-north-1.pooler.supabase.com -U postgres.suhfyfxibbdebnmouxuk -p 6543 -d postgres -f ./functions/functions.sql

--this command is for showing an analysis at the bottom of the code
-- psql -h aws-0-eu-north-1.pooler.supabase.com -U postgres.suhfyfxibbdebnmouxuk -p 6543 -d postgres -P pager=off -c "SELECT * FROM analyze_movie_ratings();"
\c postgres

-- Function to analyze average ratings by genre and director
CREATE OR REPLACE FUNCTION analyze_movie_ratings()
RETURNS TABLE (
    genre_name VARCHAR,
    director_name VARCHAR,
    average_rating NUMERIC(3,2),
    total_reviews INT
)
LANGUAGE sql
AS $$
SELECT
    g.name AS genre_name,
    d.name AS director_name,
    AVG(r.score) AS average_rating,
    COUNT(r.id) AS total_reviews
FROM ratings r
JOIN movies m ON r.movie_id = m.id
JOIN genres g ON m.genre_id = g.id
JOIN movie_directors md ON md.movie_id = m.id
JOIN directors d ON md.director_id = d.id
GROUP BY g.name, d.name
ORDER BY average_rating DESC, total_reviews DESC;
$$;

-- Example usage: select all analysis results
SELECT * FROM analyze_movie_ratings();
