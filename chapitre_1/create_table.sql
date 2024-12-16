CREATE TABLE MoviesAndShows (
    show_id NUMBER PRIMARY KEY,
    title VARCHAR2(255),
    type VARCHAR2(50),
    release_year NUMBER,
    director_id NUMBER,
    country_id NUMBER
);

CREATE TABLE Directors (
    director_id NUMBER PRIMARY KEY,
    name VARCHAR2(255)
);

CREATE TABLE Cast (
    cast_id NUMBER PRIMARY KEY,
    name VARCHAR2(255)
);

CREATE TABLE Countries (
    country_id NUMBER PRIMARY KEY,
    name VARCHAR2(255)
);

CREATE TABLE Genres (
    genre_id NUMBER PRIMARY KEY,
    name VARCHAR2(255)
);

CREATE TABLE MoviesCountries (
    movie_id NUMBER,
    country_id NUMBER,
    FOREIGN KEY (movie_id) REFERENCES MoviesAndShows (show_id),
    FOREIGN KEY (country_id) REFERENCES Countries (country_id)
);

CREATE TABLE MoviesGenres (
    movie_id NUMBER,
    genre_id NUMBER,
    FOREIGN KEY (movie_id) REFERENCES MoviesAndShows (show_id),
    FOREIGN KEY (genre_id) REFERENCES Genres (genre_id)
);

CREATE TABLE MoviesDirectors (
    movie_id NUMBER,
    director_id NUMBER,
    FOREIGN KEY (movie_id) REFERENCES MoviesAndShows (show_id),
    FOREIGN KEY (director_id) REFERENCES Directors (director_id)
);

CREATE TABLE MoviesCast (
    movie_id NUMBER,
    cast_id NUMBER,
    FOREIGN KEY (movie_id) REFERENCES MoviesAndShows (show_id),
    FOREIGN KEY (cast_id) REFERENCES Cast (cast_id)
);
CREATE TABLE MonthlyReports (
    report_month DATE NOT NULL,
    total_movies NUMBER NOT NULL
);
