import pandas as pd
from sqlalchemy import create_engine
import logging

# Configuration des logs
logging.basicConfig(
    filename='import_data.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

# Connexion à la base Oracle
username = "loader_user"
password = "loader_password"
dsn = "xepdb1"
host = "localhost"
port = 1521

engine = create_engine(f"oracle+cx_oracle://{username}:{password}@{host}:{port}/?service_name={dsn}")

try:
    # Charger les données CSV
    logging.info("Chargement du fichier netflix_titles.csv...")
    data = pd.read_csv('netflix_titles.csv')
    logging.info("Fichier CSV chargé avec succès.")

    # Vérification des premières lignes du fichier
    logging.info(f"Premières lignes des données :\n{data.head()}")

    # Prétraitement des données
    logging.info("Prétraitement des données...")
    data['show_id'] = data['show_id'].str.extract('(\d+)').astype(int)
    data['release_year'] = data['release_year'].fillna(0).astype(int)
    data['country'] = data['country'].fillna('Unknown')
    data['director'] = data['director'].fillna('Unknown')
    data['cast'] = data['cast'].fillna('Unknown')
    data['listed_in'] = data['listed_in'].fillna('Unknown')
    logging.info("Prétraitement terminé.")

    # Insérer dans MoviesAndShows
    logging.info("Insertion dans MoviesAndShows...")
    movies_and_shows = data[['show_id', 'title', 'type', 'release_year']].drop_duplicates()
    movies_and_shows.to_csv('movies_and_shows_debug.csv', index=False)
    logging.info(f"Données MoviesAndShows générées :\n{movies_and_shows.head()}")
    movies_and_shows.to_sql('MOVIESANDSHOWS', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans MOVIESANDSHOWS.")

    # Insérer dans Countries
    logging.info("Insertion dans Countries...")
    countries = data[['country']].dropna().drop_duplicates().reset_index(drop=True)
    countries = countries.assign(country=countries['country'].str.split(',')).explode('country').reset_index(drop=True)
    countries['country'] = countries['country'].str.strip()
    countries = countries.drop_duplicates().reset_index(drop=True)
    countries = countries.reset_index().rename(columns={'index': 'COUNTRY_ID', 'country': 'NAME'})
    countries['COUNTRY_ID'] += 1
    countries.to_csv('countries_debug.csv', index=False)
    logging.info(f"Données Countries générées :\n{countries.head()}")
    countries.to_sql('COUNTRIES', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans COUNTRIES.")

    # Insérer dans Directors
    logging.info("Insertion dans Directors...")
    directors = data[['director']].dropna().drop_duplicates().reset_index(drop=True)
    directors = directors.assign(director=directors['director'].str.split(',')).explode('director').reset_index(drop=True)
    directors['director'] = directors['director'].str.strip()
    directors = directors.reset_index().rename(columns={'index': 'DIRECTOR_ID', 'director': 'NAME'})
    directors['DIRECTOR_ID'] += 1
    directors.to_csv('directors_debug.csv', index=False)
    logging.info(f"Données Directors générées :\n{directors.head()}")
    directors.to_sql('DIRECTORS', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans DIRECTORS.")

    # Insérer dans Cast
    logging.info("Insertion dans Cast...")
    casts = data[['cast']].dropna().drop_duplicates().reset_index(drop=True)
    casts = casts.assign(cast=casts['cast'].str.split(',')).explode('cast').reset_index(drop=True)
    casts['cast'] = casts['cast'].str.strip()
    casts = casts.reset_index().rename(columns={'index': 'CAST_ID', 'cast': 'NAME'})
    casts['CAST_ID'] += 1
    casts.to_csv('cast_debug.csv', index=False)
    logging.info(f"Données Cast générées :\n{casts.head()}")
    casts.to_sql('CAST', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans CAST.")

    # Insérer dans Genres
    logging.info("Insertion dans Genres...")
    genres = data[['listed_in']].dropna().drop_duplicates().reset_index(drop=True)
    genres = genres.assign(listed_in=genres['listed_in'].str.split(',')).explode('listed_in').reset_index(drop=True)
    genres['listed_in'] = genres['listed_in'].str.strip()
    genres = genres.reset_index().rename(columns={'index': 'GENRE_ID', 'listed_in': 'NAME'})
    genres['GENRE_ID'] += 1
    genres.to_csv('genres_debug.csv', index=False)
    logging.info(f"Données Genres générées :\n{genres.head()}")
    genres.to_sql('GENRES', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans GENRES.")

    # Insérer dans MoviesCountries
    logging.info("Insertion dans MoviesCountries...")
    movies_countries = data[['show_id', 'country']].dropna()
    movies_countries = movies_countries.assign(country=movies_countries['country'].str.split(',')).explode('country').reset_index(drop=True)
    movies_countries['country'] = movies_countries['country'].str.strip()
    movies_countries = movies_countries.merge(countries, left_on='country', right_on='NAME')[['show_id', 'COUNTRY_ID']]
    movies_countries = movies_countries.rename(columns={'show_id': 'movie_id', 'COUNTRY_ID': 'country_id'})
    movies_countries.to_csv('movies_countries_debug.csv', index=False)
    logging.info(f"Données MoviesCountries générées :\n{movies_countries.head()}")
    movies_countries.to_sql('MOVIESCOUNTRIES', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans MoviesCountries.")

    # Insérer dans MoviesGenres
    logging.info("Insertion dans MoviesGenres...")
    movies_genres = data[['show_id', 'listed_in']].dropna()
    movies_genres = movies_genres.assign(listed_in=movies_genres['listed_in'].str.split(',')).explode('listed_in').reset_index(drop=True)
    movies_genres['listed_in'] = movies_genres['listed_in'].str.strip()
    movies_genres = movies_genres.merge(genres, left_on='listed_in', right_on='NAME')[['show_id', 'GENRE_ID']]
    movies_genres = movies_genres.rename(columns={'show_id': 'movie_id', 'GENRE_ID': 'genre_id'})
    movies_genres.to_csv('movies_genres_debug.csv', index=False)
    logging.info(f"Données MoviesGenres générées :\n{movies_genres.head()}")
    movies_genres.to_sql('MOVIESGENRES', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans MoviesGenres.")

    # Insérer dans MoviesDirectors
    logging.info("Insertion dans MoviesDirectors...")
    movies_directors = data[['show_id', 'director']].dropna()
    movies_directors = movies_directors.assign(director=movies_directors['director'].str.split(',')).explode('director').reset_index(drop=True)
    movies_directors['director'] = movies_directors['director'].str.strip()
    movies_directors = movies_directors.merge(directors, left_on='director', right_on='NAME')[['show_id', 'DIRECTOR_ID']]
    movies_directors = movies_directors.rename(columns={'show_id': 'movie_id', 'DIRECTOR_ID': 'director_id'})
    movies_directors.to_csv('movies_directors_debug.csv', index=False)
    logging.info(f"Données MoviesDirectors générées :\n{movies_directors.head()}")
    movies_directors.to_sql('MOVIESDIRECTORS', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans MoviesDirectors.")

    # Insérer dans MoviesCast
    logging.info("Insertion dans MoviesCast...")
    movies_cast = data[['show_id', 'cast']].dropna()
    movies_cast = movies_cast.assign(cast=movies_cast['cast'].str.split(',')).explode('cast').reset_index(drop=True)
    movies_cast['cast'] = movies_cast['cast'].str.strip()
    movies_cast = movies_cast.merge(casts, left_on='cast', right_on='NAME')[['show_id', 'CAST_ID']]
    movies_cast = movies_cast.rename(columns={'show_id': 'movie_id', 'CAST_ID': 'cast_id'})
    movies_cast.to_csv('movies_cast_debug.csv', index=False)
    logging.info(f"Données MoviesCast générées :\n{movies_cast.head()}")
    movies_cast.to_sql('MOVIESCAST', con=engine, if_exists='append', index=False)
    logging.info("Données insérées dans MoviesCast.")


    logging.info("Importation terminée avec succès.")

except Exception as e:
    logging.error(f"Erreur lors de l'importation : {e}")
    raise
