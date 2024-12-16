-- Configuration du profil par défaut
ALTER PROFILE DEFAULT LIMIT PASSWORD_VERIFY_FUNCTION NULL;

-- Activer l'audit
AUDIT SELECT ON loader_user.MoviesAndShows BY ACCESS;
AUDIT INSERT, UPDATE, DELETE ON loader_user.MoviesAndShows BY ACCESS;

AUDIT SELECT ON loader_user.Directors BY ACCESS;
AUDIT INSERT, UPDATE, DELETE ON loader_user.Directors BY ACCESS;
