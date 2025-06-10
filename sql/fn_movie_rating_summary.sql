DELIMITER $$

CREATE FUNCTION fn_movie_rating_summary(movie_id INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE avg_score DECIMAL(3,2);
    DECLARE review_count INT;
    DECLARE genre_name VARCHAR(50);

    SELECT AVG(r.Score), COUNT(*), g.GenreName
    INTO avg_score, review_count, genre_name
    FROM Ratings r
    JOIN Reviews rev ON r.MovieID = rev.MovieID AND r.UserID = rev.UserID
    JOIN Movies m ON r.MovieID = m.MovieID
    JOIN Genres g ON m.GenreID = g.GenreID
    WHERE r.MovieID = movie_id
    LIMIT 1;

    RETURN CONCAT('Genre: ', IFNULL(genre_name, 'Unknown'), ', Average Score: ', IFNULL(avg_score, 0), ', Reviews: ', IFNULL(review_count, 0));
END$$

DELIMITER ;