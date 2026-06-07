@echo off
setlocal
cd /d "%~dp0"

echo.
echo ======================================================
echo  ConnectVoice - Vercel Deployment (No GitHub required)
echo ======================================================
echo.

REM Check Node
where node >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Node.js is not installed. Install from https://nodejs.org
  pause
  exit /b 1
)

REM Install Vercel CLI locally to avoid global permission issues
if not exist "node_modules\vercel" (
  echo [1/4] Installing Vercel CLI...
  call npm install --no-save --no-audit --no-fund vercel@latest
  if errorlevel 1 goto :error
)

REM Build locally to verify everything compiles
echo.
echo [2/4] Building project locally...
call npm run build
if errorlevel 1 goto :error

REM Deploy
echo.
echo [3/4] Deploying to Vercel...
echo A browser will open for login if needed.
echo.
call npx vercel deploy --prod --yes
if errorlevel 1 goto :error

echo.
echo ======================================================
echo  [4/4] DONE! Your site is live.
echo  Check the URL printed above.
echo ======================================================
echo.
pause
exit /b 0

:error
echo.
echo [DEPLOYMENT FAILED]
echo.
echo If you got a login error, run: npx vercel login
echo If you got a build error, run: npm run build  (to see details)
echo.
pause
exit /b 1
