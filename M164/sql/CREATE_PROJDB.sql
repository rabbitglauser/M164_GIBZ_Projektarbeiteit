-- psql -h aws-0-eu-central-2.pooler.supabase.com -U postgres.vceberzqpcutgbhcwvaq -p 6543 -d postgres -f ./"CREATE_PROJDB.sql"

DROP DATABASE IF EXISTS projects WITH (FORCE);

CREATE DATABASE projects;

\c projects

CREATE TABLE project_assignments (
    project_code VARCHAR(10),
    project_name VARCHAR(100),
    project_manager VARCHAR(100),
    project_budget NUMERIC(12, 2),
    employee_no VARCHAR(10),
    employee_name VARCHAR(100),
    department_no VARCHAR(10),
    department_name VARCHAR(100),
    hourly_rate NUMERIC(8, 2)
);

INSERT INTO project_assignments
(project_code, project_name, project_manager, project_budget, employee_no, employee_name, department_no, department_name, hourly_rate)
VALUES
    ('P01', 'Ecommerce Solution', 'Mr. Laurin Smith', 120000.00, 'E01', 'Tim Marthaler', 'D03', 'Software Engineering', 200.00),
    ('P02', 'Reservation System', 'Mrs. Augusta Ellis', 250000.00, 'E05', 'Joshua Wegelin', 'D05', 'Database', 210.00);

--\i ./PROJDBN1-N3.sql
