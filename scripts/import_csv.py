# psql -h aws-0-eu-central-2.pooler.supabase.com -U postgres.fcvrfyxqmedmrugjylfo -p 6543 -d Projektarbeit -f ./create_tables.sql

import csv
import json
import mysql.connector
import psycopg2

# === Load MySQL config ===
with open('../config/db_config.json') as f:
    config = json.load(f)

mysql_conn = mysql.connector.connect(
    host=config['host'],
    user=config['user'],
    password=config['password'],
    database=config['database']
)
mysql_cursor = mysql_conn.cursor()

# === Supabase PostgreSQL config ===
supabase_conn = psycopg2.connect(
    dbname='postgres',                       # usually 'postgres'
    user='postgres',                         # usually 'postgres'
    password='your_actual_supabase_password',
    host='db.suhfyfxibbdebnmouxuk.supabase.co', # replace with your actual host
    port='5432'
)
supabase_cursor = supabase_conn.cursor()

def import_csv(file, table, columns):
    with open(file, encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)  # skip header
        for row in reader:
            # MySQL insert
            mysql_sql = f"INSERT IGNORE INTO {table} ({', '.join(columns)}) VALUES ({', '.join(['%s']*len(columns))})"
            mysql_cursor.execute(mysql_sql, row)

            # Supabase insert with conflict handling
            pg_sql = f"""
                INSERT INTO {table} ({', '.join(columns)}) 
                VALUES ({', '.join(['%s']*len(columns))})
                ON CONFLICT DO NOTHING
            """
            supabase_cursor.execute(pg_sql, row)

    mysql_conn.commit()
    supabase_conn.commit()

# === Import data to both databases ===
import_csv('genres.csv', 'Genres', ['GenreID', 'GenreName'])
import_csv('movies.csv', 'Movies', ['MovieID', 'Title', 'Year', 'GenreID'])

# === Close connections ===
mysql_cursor.close()
mysql_conn.close()
supabase_cursor.close()
supabase_conn.close()
