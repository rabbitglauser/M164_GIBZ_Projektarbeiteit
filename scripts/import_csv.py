import csv
import mysql.connector
import json

with open('../config/db_config.json') as f:
    config = json.load(f)

conn = mysql.connector.connect(
    host=config['host'],
    user=config['user'],
    password=config['password'],
    database=config['database']
)
cursor = conn.cursor()

def import_csv(file, table, columns):
    with open(file, encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)  # skip header
        for row in reader:
            sql = f"INSERT IGNORE INTO {table} ({', '.join(columns)}) VALUES ({', '.join(['%s']*len(columns))})"
            cursor.execute(sql, row)
    conn.commit()

import_csv('genres.csv', 'Genres', ['GenreID', 'GenreName'])
import_csv('movies.csv', 'Movies', ['MovieID', 'Title', 'Year', 'GenreID'])

cursor.close()
conn.close()