# Component Diagram

- User interacts with the import script (Python).
- Import script connects to the MySQL database (via config).
- MySQL DB is monitored by Grafana (read access for visualization).
- All credentials/configurations are managed via config files (never hardcoded).
- Communication:
    - Import script ↔️ DB: MySQL protocol (TCP/3306)
    - Grafana ↔️ DB: MySQL protocol (TCP/3306)