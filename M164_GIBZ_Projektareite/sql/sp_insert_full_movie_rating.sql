DELIMITER $$

CREATE PROCEDURE sp_insert_full_movie_rating (
    IN in_movieID INT,
    IN in_title VARCHAR(100),
    IN in_year INT,
    IN in_genreID INT,
    IN in_userID INT,
    IN in_age INT,
    IN in_location VARCHAR(100),
    IN in_score DECIMAL(2,1),
    IN in_timestamp TIMESTAMP,
    IN in_reviewText TEXT
)
BEGIN
    -- Insert movie if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM Movies WHERE MovieID = in_movieID) THEN
        INSERT INTO Movies (MovieID, Title, Year, GenreID)
        VALUES (in_movieID, in_title, in_year, in_genreID);
    END IF;

    -- Insert user if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = in_userID) THEN
        INSERT INTO Users (UserID, Age, Location)
        VALUES (in_userID, in_age, in_location);
    END IF;

    -- Insert rating
    INSERT INTO Ratings (RatingID, MovieID, UserID, Score, Timestamp)
    VALUES (UUID_SHORT(), in_movieID, in_userID, in_score, in_timestamp);

    -- Insert review
    INSERT INTO Reviews (ReviewID, MovieID, UserID, Text)
    VALUES (UUID_SHORT(), in_movieID, in_userID, in_reviewText);
END$$

DELIMITER ;