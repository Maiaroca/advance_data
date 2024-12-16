-- Index pour améliorer les performances des recherches
CREATE INDEX idx_countries_name ON Countries (name);
CREATE INDEX idx_genres_name ON Genres (name);
CREATE INDEX idx_directors_name ON Directors (name);
CREATE INDEX idx_cast_name ON Cast (name);

-- Index sur les colonnes fréquemment utilisées dans les requêtes
CREATE INDEX idx_movies_type ON MoviesAndShows (type);
CREATE INDEX idx_movies_release_year ON MoviesAndShows (release_year);
CREATE INDEX idx_movies_title ON MoviesAndShows (title);
