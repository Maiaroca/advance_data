-- Création d'une table de log si elle n'existe pas déjà
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE loader_user.AuditLog (
        log_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        table_name VARCHAR2(100),
        operation VARCHAR2(20),
        timestamp DATE
    )';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -955 THEN -- Code erreur -955 signifie que la table existe déjà
            RAISE;
        END IF;
END;
/

-- Trigger pour la table MoviesGenres
CREATE OR REPLACE TRIGGER trg_moviesgenres_log
AFTER INSERT OR UPDATE OR DELETE ON loader_user.MoviesGenres
FOR EACH ROW
BEGIN
    INSERT INTO loader_user.AuditLog (table_name, operation, timestamp)
    VALUES ('MoviesGenres', ORA_SYSEVENT, SYSDATE);
END;
/

-- Trigger pour la table MoviesCountries
CREATE OR REPLACE TRIGGER trg_moviescountries_log
AFTER INSERT OR UPDATE OR DELETE ON loader_user.MoviesCountries
FOR EACH ROW
BEGIN
    INSERT INTO loader_user.AuditLog (table_name, operation, timestamp)
    VALUES ('MoviesCountries', ORA_SYSEVENT, SYSDATE);
END;
/

-- Trigger pour la table MoviesDirectors
CREATE OR REPLACE TRIGGER trg_moviesdirectors_log
AFTER INSERT OR UPDATE OR DELETE ON loader_user.MoviesDirectors
FOR EACH ROW
BEGIN
    INSERT INTO loader_user.AuditLog (table_name, operation, timestamp)
    VALUES ('MoviesDirectors', ORA_SYSEVENT, SYSDATE);
END;
/

-- Trigger pour la table MoviesCast
CREATE OR REPLACE TRIGGER trg_moviescast_log
AFTER INSERT OR UPDATE OR DELETE ON loader_user.MoviesCast
FOR EACH ROW
BEGIN
    INSERT INTO loader_user.AuditLog (table_name, operation, timestamp)
    VALUES ('MoviesCast', ORA_SYSEVENT, SYSDATE);
END;
/
