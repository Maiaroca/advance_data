GRANT ALL PRIVILEGES ON loader_user.Countries TO admin_user;
GRANT ALL PRIVILEGES ON loader_user.Genres TO admin_user;
GRANT ALL PRIVILEGES ON loader_user.Directors TO admin_user;
GRANT ALL PRIVILEGES ON loader_user.Cast TO admin_user;
GRANT ALL PRIVILEGES ON loader_user.MoviesAndShows TO admin_user;

GRANT SELECT, INSERT, UPDATE ON loader_user.MoviesAndShows TO manager_user;
GRANT SELECT, INSERT, UPDATE ON loader_user.MoviesGenres TO manager_user;

GRANT SELECT ON loader_user.MoviesAndShows TO regular_user;
GRANT SELECT ON loader_user.Countries TO regular_user;
GRANT SELECT ON loader_user.Genres TO regular_user;
