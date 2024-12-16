--création d’une vue matérialisée pour une analyse des films par année et genre
CREATE MATERIALIZED VIEW mv_movies_by_year_genre AS
SELECT G.name AS genre_name, M.release_year, COUNT(*) AS total_movies
FROM MoviesAndShows M
JOIN MoviesGenres MG ON M.show_id = MG.show_id
JOIN Genres G ON MG.genre_id = G.genre_id
GROUP BY G.name, M.release_year;

--création d’une vue matérialisée pour une analyse des films par réalisateur et genre
CREATE MATERIALIZED VIEW mv_movies_by_director_genre AS
SELECT 
    D.name AS director_name, 
    G.name AS genre_name, 
    COUNT(*) AS total_movies
FROM MoviesAndShows M
JOIN Directors D ON M.director_id = D.director_id
JOIN MoviesGenres MG ON M.show_id = MG.show_id
JOIN Genres G ON MG.genre_id = G.genre_id
GROUP BY D.name, G.name;

--création d’une vue matérialisée pour une analyse des films par pays et année de sortie
CREATE MATERIALIZED VIEW mv_movies_by_country_year AS
SELECT 
    C.name AS country_name, 
    M.release_year, 
    COUNT(*) AS total_movies
FROM MoviesAndShows M
JOIN MoviesCountries MC ON M.show_id = MC.show_id
JOIN Countries C ON MC.country_id = C.country_id
GROUP BY C.name, M.release_year;


