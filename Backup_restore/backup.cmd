@echo off
REM Safe Backup Script (Structure + Data Only)

SET DB_NAME=postgres
SET FILE_NAME=movies_backup.dump
SET HOST=aws-0-eu-north-1.pooler.supabase.com
SET PORT=6543
SET USER=postgres.suhfyfxibbdebnmouxuk

pg_dump -h %HOST% -U %USER% -p %PORT% -F c -f %FILE_NAME% ^
  --no-owner --no-privileges --clean %DB_NAME%

echo Backup complete: %FILE_NAME%
pause
