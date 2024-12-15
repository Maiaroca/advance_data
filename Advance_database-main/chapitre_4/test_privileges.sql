-- Test des privilèges pour ADMIN_USER
CONNECT ADMIN_USER/admin_password@localhost:1521/xepdb1;
-- Vérification des privilèges d'insertion et d'utilisation des séquences
INSERT INTO loader_user.MoviesAndShows (show_id, title, type, release_year) 
VALUES (loader_user.SEQ_MOVIE_ID.NEXTVAL, 'Admin Test Movie', 'Movie', 2024);

-- Vérification de l'accès aux autres tables
SELECT * FROM loader_user.Genres WHERE ROWNUM <= 5;
SELECT * FROM loader_user.Directors WHERE ROWNUM <= 5;
SELECT * FROM loader_user.Countries WHERE ROWNUM <= 5;

-- Suppression des données test
DELETE FROM loader_user.MoviesAndShows WHERE title = 'Admin Test Movie';

-- Déconnexion
DISCONNECT;

-- Test des privilèges pour MANAGER_USER
CONNECT MANAGER_USER/manager_password@localhost:1521/xepdb1;
-- Vérification des privilèges d'insertion via séquence
INSERT INTO loader_user.MoviesAndShows (show_id, title, type, release_year) 
VALUES (loader_user.SEQ_MOVIE_ID.NEXTVAL, 'Manager Test Movie', 'Movie', 2024);

-- Vérification des privilèges de lecture
SELECT * FROM loader_user.Genres WHERE ROWNUM <= 5;
SELECT * FROM loader_user.Directors WHERE ROWNUM <= 5;
SELECT * FROM loader_user.Countries WHERE ROWNUM <= 5;

-- Suppression des données test
DELETE FROM loader_user.MoviesAndShows WHERE title = 'Manager Test Movie';

-- Déconnexion
DISCONNECT;

-- Test des privilèges pour REGULAR_USER
CONNECT REGULAR_USER/regular_password@localhost:1521/xepdb1;
-- Vérification de l'accès en lecture seule
SELECT * FROM loader_user.MoviesAndShows WHERE ROWNUM <= 5;
SELECT * FROM loader_user.Genres WHERE ROWNUM <= 5;
SELECT * FROM loader_user.Directors WHERE ROWNUM <= 5;
SELECT * FROM loader_user.Countries WHERE ROWNUM <= 5;

-- Tentative d'insertion (doit échouer)
BEGIN
    INSERT INTO loader_user.MoviesAndShows (show_id, title, type, release_year) 
    VALUES (loader_user.SEQ_MOVIE_ID.NEXTVAL, 'Regular Test Movie', 'Movie', 2024);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Regular User: Cannot insert as expected.');
END;
/

-- Déconnexion
DISCONNECT;
