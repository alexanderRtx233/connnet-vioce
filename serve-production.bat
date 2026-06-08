@echo off
setlocal
cd /d "%~dp0"

echo.
echo ======================================================
echo  ConnectVoice - Run Production Server Locally
echo ======================================================
echo.
echo This serves the built dist/ folder on http://localhost:5173
echo Keep this window open to keep the server running.
echo.
echo For public access, also run deploy-ngrok.bat
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Node.js not installed.
  pause
  exit /b 1
)

if not exist "dist\index.html" (
  echo Building first...
  call npm run build
)

echo.
echo Installing serve...
call npm install --no-save --no-audit --no-fund serve

echo.
echo Starting production server on port 5173...
echo.
echo ======================================================
echo  Open http://localhost:5173 in your browser
echo  Press Ctrl+C to stop
echo ======================================================
echo.
call npx serve -s dist -l 5173 --no-clipboard
