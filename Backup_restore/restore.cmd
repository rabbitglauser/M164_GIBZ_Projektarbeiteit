
@echo off
set DB_NAME=postgres
set HOST=aws-0-eu-central-2.pooler.supabase.com
set PORT=6543
set USER=postgres.fcvrfyxqmedmrugjylfo

echo Restoring database...
pg_restore -h %HOST% -p %PORT% -U %USER% -d %DB_NAME% --clean --if-exists --no-owner --no-comments --no-privileges --verbose pet_adoption_backup.dump
echo Restore complete: %DB_NAME%
pause