-- Joindre MoviesCountries avec MoviesAndShows
SELECT M.title, C.name AS country_name
FROM MoviesAndShows M
JOIN MoviesCountries MC ON M.show_id = MC.movie_id
JOIN Countries C ON MC.country_id = C.country_id;

-- Joindre MoviesGenres avec MoviesAndShows
SELECT M.title, G.name AS genre_name
FROM MoviesAndShows M
JOIN MoviesGenres MG ON M.show_id = MG.movie_id
JOIN Genres G ON MG.genre_id = G.genre_id;

-- Joindre MoviesDirectors avec MoviesAndShows
SELECT M.title, D.name AS director_name
FROM MoviesAndShows M
JOIN MoviesDirectors MD ON M.show_id = MD.movie_id
JOIN Directors D ON MD.director_id = D.director_id;

-- Joindre MoviesCast avec MoviesAndShows
SELECT M.title, C.name AS cast_name
FROM MoviesAndShows M
JOIN MoviesCast MC ON M.show_id = MC.movie_id
JOIN Cast C ON MC.cast_id = C.cast_id;

-- Compter le nombre de films par genre
SELECT G.name AS genre_name, COUNT(MG.movie_id) AS total_movies
FROM Genres G
JOIN MoviesGenres MG ON G.genre_id = MG.genre_id
GROUP BY G.name;

-- Compter le nombre de films par pays
SELECT C.name AS country_name, COUNT(MC.movie_id) AS total_movies
FROM Countries C
JOIN MoviesCountries MC ON C.country_id = MC.country_id
GROUP BY C.name;
