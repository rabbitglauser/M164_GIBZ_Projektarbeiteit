# Movie Ratings Project

## Overview
A normalized movie rating database project with import, analysis, monitoring, and backup.

## Features
- 5 normalized tables (Movies, Genres, Users, Ratings, Reviews)
- Bulk import from CSV (Python)
- Stored procedure for full movie/rating/user insert
- Analysis function (average ratings, genre, review count)
- Backup/restore script
- Grafana dashboard (3 visualizations)
- No hardcoded credentials (config file)
- Component diagram and normalization docs

## Structure
- `sql/` — DDL, procedures, functions
- `scripts/` — CSV import, backup/restore
- `config/` — DB config
- `monitoring/` — Grafana setup
- `docs/` — Normalization and component diagram

## How to Run
1. Configure DB credentials in `config/db_config.json`.
2. Create tables:  
   ```sh
   mysql -u <user> -p <db> < sql/create_tables.sql
   ```
3. Import CSVs:  
   ```sh
   python3 scripts/import_csv.py
   ```
4. Create procedure & function:  
   ```sh
   mysql -u <user> -p <db> < sql/sp_insert_full_movie_rating.sql
   mysql -u <user> -p <db> < sql/fn_movie_rating_summary.sql
   ```
5. Backup/restore:  
   ```sh
   ./scripts/backup_restore.sh backup moviedb backup.sql
   ./scripts/backup_restore.sh restore moviedb backup.sql
   ```
6. Set up Grafana as per `monitoring/grafana_setup.md`.

## Presentation
- See `docs/normalization.md` and `docs/component_diagram.md`