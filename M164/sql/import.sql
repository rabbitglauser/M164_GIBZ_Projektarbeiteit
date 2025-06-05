-- psql -h aws-0-eu-central-2.pooler.supabase.com -U postgres.vceberzqpcutgbhcwvaq -p 6543 -d postgres -f ./import.sql

DROP DATABASE smartphones WITH (FORCE);

CREATE DATABASE smartphones;

\c smartphones

CREATE TABLE IF NOT EXISTS smartphones (
     Brand VARCHAR(50),
     Model VARCHAR(100),
     Price_USD NUMERIC,
     Selling_Platform VARCHAR(50),
     Rating NUMERIC,
     Refresh_Rate_Hz INTEGER,
     Screen_Size_Inches NUMERIC,
     RAM_GB INTEGER,
     Storage_GB INTEGER,
     Processor VARCHAR(100),
     Camera_Setup VARCHAR(100)
);

\COPY smartphones FROM './mobile_phones_2000.csv' DELIMITER ',' CSV HEADER;

\i 'normalize.sql'