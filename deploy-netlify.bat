@echo off
setlocal
cd /d "%~dp0"

echo.
echo ======================================================
echo  ConnectVoice - Netlify Deploy
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
echo [2/4] Installing Netlify CLI...
if not exist "node_modules\.bin\netlify.cmd" call npm install --no-save --no-audit --no-fund netlify-cli
if errorlevel 1 goto :error

echo.
echo [3/4] Login to Netlify (browser will open)...
call npx netlify login
if errorlevel 1 goto :error

echo.
echo [4/4] Deploying to production...
call npx netlify deploy --dir=dist --prod
if errorlevel 1 goto :error

echo.
echo ======================================================
echo  DONE! Your site is live on Netlify.
echo ======================================================
echo.
pause
exit /b 0

:error
echo.
echo [FAILED] See error above.
echo.
echo ALTERNATIVE: Just open https://app.netlify.com/drop
echo and drag the dist folder onto the page.
pause
exit /b 1
