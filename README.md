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
- `docs/` — Normalization and component diagram
