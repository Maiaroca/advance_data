-- Création des rôles dans le conteneur actuel
CREATE ROLE ADMIN_ROLE CONTAINER=CURRENT;
CREATE ROLE MANAGER_ROLE CONTAINER=CURRENT;
CREATE ROLE REGULAR_ROLE CONTAINER=CURRENT;

-- Attribution des privilèges aux rôles
-- L'admin a tous les privilèges pour la gestion des données
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE ON loader_user.MoviesAndShows TO ADMIN_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON loader_user.Genres TO ADMIN_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON loader_user.Directors TO ADMIN_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON loader_user.Countries TO ADMIN_ROLE;

-- Le manager peut gérer les films et leurs relations (insert, update, select)
GRANT CREATE SESSION, INSERT,UPDATE, SELECT ON loader_user.MoviesAndShows TO MANAGER_ROLE;
GRANT INSERT, UPDATE, SELECT ON loader_user.MoviesGenres TO MANAGER_ROLE;
GRANT INSERT, UPDATE, SELECT ON loader_user.Genres TO MANAGER_ROLE;
GRANT INSERT, UPDATE, SELECT ON loader_user.Directors TO MANAGER_ROLE;
GRANT INSERT, UPDATE, SELECT ON loader_user.MoviesDirectors TO MANAGER_ROLE;
GRANT INSERT, UPDATE, SELECT ON loader_user.Cast TO MANAGER_ROLE;
GRANT INSERT, UPDATE, SELECT ON loader_user.MoviesCast TO MANAGER_ROLE;
GRANT INSERT, UPDATE, SELECT ON loader_user.Countries TO MANAGER_ROLE;
GRANT INSERT, UPDATE, SELECT ON loader_user.MoviesCountries TO MANAGER_ROLE;

-- L'utilisateur régulier peut seulement interroger les données
GRANT CREATE SESSION, SELECT ON loader_user.MoviesAndShows TO REGULAR_ROLE;
GRANT SELECT ON loader_user.MoviesGenres TO REGULAR_ROLE;
GRANT SELECT ON loader_user.Genres TO REGULAR_ROLE;
GRANT SELECT ON loader_user.Directors TO REGULAR_ROLE;
GRANT SELECT ON loader_user.MoviesDirectors TO REGULAR_ROLE;
GRANT SELECT ON loader_user.Cast TO REGULAR_ROLE;
GRANT SELECT ON loader_user.MoviesCast TO REGULAR_ROLE;
GRANT SELECT ON loader_user.Countries TO REGULAR_ROLE;
GRANT SELECT ON loader_user.MoviesCountries TO REGULAR_ROLE;

-- Attribution des rôles aux utilisateurs
GRANT ADMIN_ROLE TO ADMIN_USER;
GRANT MANAGER_ROLE TO MANAGER_USER;
GRANT REGULAR_ROLE TO REGULAR_USER;
