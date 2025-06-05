# 🎬 Movie Ratings Automation Project

This project automates the process of importing and analyzing movie ratings data. A Python script imports data from a CSV file into a normalized relational database. SQL procedures/functions are used to process and analyze the data. A Grafana dashboard provides insights such as top-rated movies, popular genres, and rating trends.

## Features
- Data import script for bulk loading
- Database normalized to 3NF
- Stored procedure + analytical SQL function
- Backup/restore scripts
- Grafana dashboard with 3+ visualizations

## Tech Stack
- Python
- PostgreSQL or MySQL
- Grafana
- SQL
- GitHub

## How to Run
1. Configure `config/db_config.json`
2. Run `import_csv.py` to load the data
3. Run `create_tables.sql` to build DB
4. Open Grafana to view dashboard

## Author
[Your Name]
