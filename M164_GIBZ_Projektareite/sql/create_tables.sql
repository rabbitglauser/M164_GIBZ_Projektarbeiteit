CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Year INT,
    GenreID INT,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Age INT,
    Location VARCHAR(100)
);

CREATE TABLE Ratings (
    RatingID BIGINT PRIMARY KEY,
    MovieID INT,
    UserID INT,
    Score DECIMAL(2,1),
    Timestamp TIMESTAMP,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Reviews (
    ReviewID BIGINT PRIMARY KEY,
    MovieID INT,
    UserID INT,
    Text TEXT,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);