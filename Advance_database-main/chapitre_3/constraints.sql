-- MoviesCountries
DECLARE
    v_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM USER_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'FK_MOVIE_COUNTRY';
    
    IF v_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE loader_user.MoviesCountries ADD CONSTRAINT fk_movie_country FOREIGN KEY (movie_id) REFERENCES loader_user.MoviesAndShows (show_id) ON DELETE CASCADE';
    END IF;
END;
/

-- MoviesGenres
DECLARE
    v_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM USER_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'FK_MOVIE_GENRE';
    
    IF v_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE loader_user.MoviesGenres ADD CONSTRAINT fk_movie_genre FOREIGN KEY (movie_id) REFERENCES loader_user.MoviesAndShows (show_id) ON DELETE CASCADE';
    END IF;
END;
/

-- MoviesDirectors
DECLARE
    v_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM USER_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'FK_MOVIE_DIRECTOR';
    
    IF v_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE loader_user.MoviesDirectors ADD CONSTRAINT fk_movie_director FOREIGN KEY (movie_id) REFERENCES loader_user.MoviesAndShows (show_id) ON DELETE CASCADE';
    END IF;
END;
/

-- MoviesCast
DECLARE
    v_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM USER_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'FK_MOVIE_CAST';
    
    IF v_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE loader_user.MoviesCast ADD CONSTRAINT fk_movie_cast FOREIGN KEY (movie_id) REFERENCES loader_user.MoviesAndShows (show_id) ON DELETE CASCADE';
    END IF;
END;
/
