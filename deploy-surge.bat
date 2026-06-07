@echo off
setlocal
cd /d "%~dp0"

echo.
echo ======================================================
echo  ConnectVoice - Surge.sh Deploy
echo ======================================================
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Node.js not installed. Get it from https://nodejs.org
  pause
  exit /b 1
)

echo [1/4] Building...
call npm run build
if errorlevel 1 goto :error

echo.
echo [2/4] Installing surge...
if not exist "node_modules\surge" call npm install --no-save --no-audit --no-fund surge
if errorlevel 1 goto :error

echo.
echo [3/4] First time? You'll be asked to create an account.
echo Use any email and password. It's instant.
echo.
echo [4/4] Deploying...
call npx surge dist connectvoice.surge.sh
if errorlevel 1 goto :error

echo.
echo ======================================================
echo  DONE! Live at https://connectvoice.surge.sh
echo ======================================================
echo.
pause
exit /b 0

:error
echo.
echo [FAILED] See error above.
pause
exit /b 1
