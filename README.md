# Guide d’Exécution pour le Projet ADBM

Ce guide décrit les étapes pour exécuter le projet ADBM depuis un terminal, y compris l’utilisation de SQL*Plus.

---

## Prérequis
1. **Installations nécessaires** :
   - Oracle Database (avec SQL*Plus accessible depuis le terminal).
   - Python installé avec les bibliothèques suivantes :
     - `cx_Oracle`
     - `pandas`
     - `sqlalchemy`
   
2. **Installation de Python (si non installé)** :
   - **Vérifier si Python est déjà installé** :
     ```bash
     python --version
     ```
   - **Installer Python** :
     - **Windows** : Téléchargez l'installateur depuis [python.org](https://www.python.org/downloads/) et cochez "Add Python to PATH".
     - **macOS** : Utilisez Homebrew :
       ```bash
       brew install python
       ```
     - **Windows/macOS/Linux** : Installez les bibliothèques requises après installation de Python :
       ```bash
       pip install cx_Oracle pandas sqlalchemy
       ```
   - **Configurer cx_Oracle** : Téléchargez les Oracle Instant Client Libraries depuis [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client.html) et ajoutez leur chemin à `PATH`.

3. **Organisation des fichiers** : Structurez vos dossiers comme suit :
   ```
   Advance_database-main/
   ├── chapitre_1/
   │   ├── cast_debug.csv
   │   ├── countries_debug.csv
   │   ├── create_table.sql
   │   ├── directors_debug.csv
   │   ├── genres_debug.csv
   │   ├── import_data.log
   │   ├── import_data.py
   │   ├── movies_and_shows_debug.csv
   │   ├── movies_cast_debug.csv
   │   ├── movies_countries_debug.csv
   │   ├── movies_directors_debug.csv
   │   ├── movies_genres_debug.csv
   │   └── netflix_titles.csv
   ├── chapitre_2/
   │   ├── create_user.sql
   │   ├── roles_and_privileges.sql
   │   ├── security_config.sql
   │   ├── test_privileges.sql
   │   └── test_users.sql
   ├── chapitre_3/
   │   ├── constraints.sql
   │   ├── indexes.sql
   │   ├── queries.sql
   │   └── views.sql
   ├── chapitre_4/
   │   ├── automation.py
   │   ├── procedure.sql
   │   └── trigger.sql
   ├── chapitre_5/
   └── README.md
   ```

---

## Étapes d’exécution

## 1. **Chapitre 1 : Importation des données**

1. **Se positionner dans le dossier `chapitre_1`** :
   ```bash
   cd Advance_database-main/chapitre_1
   ```
   
2. **Se connecter à SQL*Plus avec l’utilisateur loader_user** :
   ```bash
   sqlplus loader_user/loader_password@localhost:1521/xepdb1
   @create_table.sql
   quit;
   ```

3. **Exécuter le script Python pour importer les données** :
   ```bash
   python import_data.py
   ```

4. **Quitter le dossier** :
   ```bash
   cd ..
   ```
## 2. **Chapitre 2 à 4**
Pour exécuter la suite du projet, il suffie d'accéder au dossier et d'exécuter les programme qu'ils contiennent en suivant cette démarche  :

 1. **Se positionner dans le dossier `chapitre_X`** :
 ```bash
 cd chapitre_X
 ```

2. **Se connecter à SQL*Plus** :
 ```bash
 sqlplus username/mdp@localhost as sysdba
 ```

3. **Basculer dans la PDB (si nécessaire)** :
 ```sql
 ALTER SESSION SET CONTAINER = XEPDB1;
 ```
 Remplacez `XEPDB1` par le nom de votre PDB. Vérifiez le nom avec :
 ```sql
 SHOW CON_NAME;
 ```

4. **Exécuter les scripts** :
 ```sql
 @script.sql
 ```

5. **Quitter SQL\*Plus** :
 ```sql
 quit;
 ```

6. **Quitter le dossier** :
 ```bash
 cd ..
 ```
   

