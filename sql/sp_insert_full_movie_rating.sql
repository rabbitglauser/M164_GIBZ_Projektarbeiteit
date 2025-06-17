-- psql -h aws-0-eu-central-2.pooler.supabase.com -U postgres.fcvrfyxqmedmrugjylfo -p 6543 -d Projektarbeit -f ./sp_insert_full_movie_rating.sql
\c projektarbeit
CREATE OR REPLACE FUNCTION sp_insert_full_movie_rating(
    in_movieID INT,
    in_userID INT,
    in_score DECIMAL(3, 2),
    in_reviewText TEXT
) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if the Movie ID exists
    IF NOT EXISTS (SELECT 1 FROM Movies WHERE MovieID = in_movieID) THEN
        RAISE EXCEPTION 'MovieID % does not exist', in_movieID;
    END IF;

    -- Check if the User ID exists
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = in_userID) THEN
        RAISE EXCEPTION 'UserID % does not exist', in_userID;
    END IF;

    -- Insert into Ratings table
    INSERT INTO Ratings (RatingID, MovieID, UserID, Score, RatingDate)
    VALUES (gen_random_uuid(), in_movieID, in_userID, in_score, NOW());

    -- Insert into Reviews table
    INSERT INTO Reviews (ReviewID, MovieID, UserID, ReviewText, ReviewDate)
    VALUES (gen_random_uuid(), in_movieID, in_userID, in_reviewText, NOW());
END;
$$;