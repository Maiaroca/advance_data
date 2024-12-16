-- Procédure Stockée : Génération de rapport mensuel
CREATE OR REPLACE PROCEDURE generate_monthly_report
IS
BEGIN
   INSERT INTO MonthlyReports (report_month, total_movies)
   SELECT TRUNC(SYSDATE, 'MM'), COUNT(*)
   FROM MoviesAndShows
   WHERE release_year = EXTRACT(YEAR FROM SYSDATE);
END;
/
