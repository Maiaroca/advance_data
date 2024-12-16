-- Configuration du profil par défaut
ALTER PROFILE DEFAULT LIMIT
  PASSWORD_VERIFY_FUNCTION NULL
  FAILED_LOGIN_ATTEMPTS 5
  PASSWORD_LIFE_TIME 30;

-- Activation de l'audit pour les tables principales
AUDIT SELECT, INSERT, UPDATE, DELETE ON loader_user.MoviesAndShows BY ACCESS;
AUDIT SELECT, INSERT, UPDATE, DELETE ON loader_user.Directors BY ACCESS;

-- Ajout de politiques d'audit pour surveiller les activités des utilisateurs
AUDIT SESSION BY admin_user;
AUDIT SELECT TABLE, INSERT TABLE, UPDATE TABLE, DELETE TABLE BY manager_user;
AUDIT SELECT TABLE BY regular_user;

-- Verrouillage du compte de l'utilisateur régulier
ALTER USER regular_user ACCOUNT LOCK;
