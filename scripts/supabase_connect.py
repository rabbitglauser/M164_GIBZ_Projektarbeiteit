import psycopg2

# Replace these with your actual Supabase credentials
conn = psycopg2.connect(
    dbname='postgres',
    user='postgres',
    password='070975',
    host='db.YOUR_PROJECT_ID.supabase.co',
    port='5432'
)


cursor = conn.cursor()

# ✅ Example query
cursor.execute("SELECT NOW();")
print("Connected to Supabase:", cursor.fetchone())

cursor.close()
conn.close()
