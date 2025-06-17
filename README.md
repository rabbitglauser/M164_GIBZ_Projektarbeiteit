# Movie Ratings Database System

## Project Overview

A comprehensive movie rating database system built with MySQL, featuring automated data import, advanced analytics, monitoring dashboards, and robust backup capabilities. This project demonstrates database normalization principles, stored procedures, data visualization, and system administration best practices.

The system manages movie ratings and reviews across multiple normalized tables, providing insights into user preferences, movie popularity, and genre trends through automated reporting and visual dashboards.

## Architecture & Design

### Database Schema
- **5 Normalized Tables**: Fully normalized database design following 3NF principles
 - `Movies` - Movie catalog with titles, years, and genre associations
 - `Genres` - Genre classification system
 - `Users` - User demographics and location data
 - `Ratings` - Numerical movie ratings with timestamps
 - `Reviews` - Textual movie reviews and feedback

### Key Components
- **Data Import Pipeline** - Python-based CSV processing with error handling
- **Backup System** - Automated MySQL backup and restore functionality
- **Analytics Engine** - Custom stored procedures and functions for data analysis
- **Monitoring Dashboard** - Real-time Grafana visualizations
- **Security** - Configuration-based credentials (no hardcoded passwords)

## Core Features

### 🔄 Data Management
- **Bulk CSV Import**: Automated import from `genres.csv` and `movies.csv` with duplicate handling
- **Data Validation**: Input validation and error handling during import processes
- **Foreign Key Integrity**: Maintains referential integrity across all tables

### 📊 Analytics & Reporting
- **Advanced Stored Procedures**: 
 - `sp_insert_full_movie_rating` - Complete movie/user/rating/review insertion with existence checks
- **Custom Functions**:
 - `fn_movie_rating_summary` - Comprehensive movie analytics (average scores, review counts, genre info)

### 💾 Backup & Recovery
- **Automated Backups**: Bash script for scheduled database backups using mysqldump
- **One-Click Restore**: Simple restore functionality for disaster recovery
- **Cross-Platform**: Windows-compatible paths with Git Bash support

### 📈 Monitoring & Visualization
- **Grafana Integration**: Real-time dashboard with 3+ visualization types
- **Performance Metrics**: Database performance and usage analytics
- **Trend Analysis**: Historical data visualization and pattern recognition

### 🔒 Security & Configuration
- **External Configuration**: Database credentials stored in `config/db_config.json`
- **Environment Isolation**: Separate configuration for different environments
- **Secure Connections**: Proper MySQL connection handling with connection pooling

## Project Structure
M164_GIBZ_Projektareite/
├── backup/
├── config/
├── docs/
│   ├── Grafana_imgs/
│   │   ├── img.png
│   │   ├── img_1.png
│   │   ├── img_2.png
│   │   ├── img_3.png
│   │   └── img_4.png
│   ├── Component Diagram.png
│   ├── component_diagram.md
│   └── Component_Diagram2.png
├── scripts/
│   ├── backup_restore.sh
│   ├── genres.csv
│   ├── import_csv.py
│   └── movies.csv
├── sql/
│   ├── create_tables.sql
│   ├── fn_movie_rating_summary.sql
│   └── sp_insert_full_movie_rating.sql
└── README.md
## Quick Start

### Prerequisites
- MySQL Server 8.0+
- Python 3.8+ with mysql-connector-python
- Git Bash (Windows) or Bash (Linux/Mac)
- Grafana (optional, for dashboards)

