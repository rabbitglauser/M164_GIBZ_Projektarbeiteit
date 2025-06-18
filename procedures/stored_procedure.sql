-- psql -h aws-0-eu-north-1.pooler.supabase.com -U postgres.suhfyfxibbdebnmouxuk -p 6543 -d postgres -f ./procedures/stored_procedure.sql

\c postgres

CREATE OR REPLACE PROCEDURE insert_movie_details(
    IN p_movie_title TEXT,
    IN p_release_year INT,
    IN p_director_name TEXT,
    IN p_actor_name TEXT,
    IN p_genre_name TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_genre_id INT;
    v_director_id INT;
    v_actor_id INT;
    v_movie_id INT;
BEGIN
    -- Check or insert genre
    SELECT id INTO v_genre_id FROM genres WHERE name = p_genre_name;
    IF NOT FOUND THEN
        INSERT INTO genres(name) VALUES (p_genre_name) RETURNING id INTO v_genre_id;
    END IF;

    -- Check or insert director
    SELECT id INTO v_director_id FROM directors WHERE name = p_director_name;
    IF NOT FOUND THEN
        INSERT INTO directors(name) VALUES (p_director_name) RETURNING id INTO v_director_id;
    END IF;

    -- Check or insert actor
    SELECT id INTO v_actor_id FROM actors WHERE name = p_actor_name;
    IF NOT FOUND THEN
        INSERT INTO actors(name) VALUES (p_actor_name) RETURNING id INTO v_actor_id;
    END IF;

    -- Check or insert movie
    SELECT id INTO v_movie_id FROM movies WHERE title = p_movie_title AND release_year = p_release_year;
    IF NOT FOUND THEN
        INSERT INTO movies(title, release_year, genre_id)
        VALUES (p_movie_title, p_release_year, v_genre_id)
        RETURNING id INTO v_movie_id;
    END IF;

    -- Link movie and director (many-to-many)
    BEGIN
        INSERT INTO movie_directors(movie_id, director_id)
        VALUES (v_movie_id, v_director_id);
    EXCEPTION
        WHEN unique_violation THEN
            -- Link exists, do nothing
            NULL;
    END;

    -- Link movie and actor (many-to-many)
    BEGIN
        INSERT INTO movie_actors(movie_id, actor_id)
        VALUES (v_movie_id, v_actor_id);
    EXCEPTION
        WHEN unique_violation THEN
            -- Link exists, do nothing
            NULL;
    END;

END;
$$;

-- Test call for the insert_movie_details procedure
CALL insert_movie_details(
  'The Matrix',
  1999,
  'Wachowski Sisters',
  'Keanu Reeves',
  'Sci-Fi'
);
