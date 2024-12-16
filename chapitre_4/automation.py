#BONUS

import cx_Oracle

connection = cx_Oracle.connect("loader_user", "loader_password", "localhost/xepdb1") #modifier avec les bonnes informations de connexion
cursor = connection.cursor()

# Récupérer les nouvelles sorties de films
cursor.execute("""
    SELECT title
    FROM MoviesAndShows
    WHERE release_year = EXTRACT(YEAR FROM SYSDATE)
""")
movies = cursor.fetchall()

for movie in movies:
    print(f"Nouvelle sortie : {movie[0]}")

connection.close()
