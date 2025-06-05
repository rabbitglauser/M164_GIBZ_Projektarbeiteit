import csv
import mysql.connector
import json
import os

# Load DB config
config_path = os.path.join(os.path.dirname(__file__), '..', 'config', 'db_config.json')
with open(config_path) as f:
    config = json.load(f)

conn = mysql.connector.connect(**config)
cursor = conn.cursor()

csv_path = os.path.join(os.path.dirname(__file__), 'movie.csv')  # fix filename here
with open(csv_path, newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        cursor.execute(
            "INSERT INTO Movies (MovieID, Title, Year, GenreID) VALUES (%s, %s, %s, %s)",
            (row['MovieID'], row['Title'], row['Year'], row['GenreID'])
        )

conn.commit()
cursor.close()
conn.close()
