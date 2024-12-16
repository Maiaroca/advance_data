-- Connexion en tant qu'utilisateur régulier
CONNECT regular_user/regular_password;

-- Tester l'accès en lecture
SELECT * FROM MoviesAndShows;

-- Essayer une opération interdite (doit échouer)
INSERT INTO MoviesAndShows (show_id, type) VALUES (9999, 'Test');

-- Connexion en tant que gestionnaire
CONNECT manager_user/manager_password;

-- Tester les privilèges d'insertion et de mise à jour
INSERT INTO MoviesAndShows (show_id, type, title) VALUES (9999, 'Movie', 'Test Movie');
UPDATE MoviesAndShows SET title = 'Updated Test Movie' WHERE show_id = 9999;

-- Connexion en tant qu'administrateur
CONNECT admin_user/admin_password;

-- Vérification complète des privilèges
SELECT * FROM MoviesAndShows;
DELETE FROM MoviesAndShows WHERE show_id = 9999;
