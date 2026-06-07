@echo off
setlocal
cd /d "%~dp0"

echo.
echo ======================================================
echo  ConnectVoice - Cloudflare Pages Deploy
echo ======================================================
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Node.js not installed. Get it from https://nodejs.org
  pause
  exit /b 1
)

echo [1/5] Building...
call npm run build
if errorlevel 1 goto :error

echo.
echo [2/5] Installing wrangler (Cloudflare CLI)...
if not exist "node_modules\wrangler" call npm install --no-save --no-audit --no-fund wrangler
if errorlevel 1 goto :error

echo.
echo [3/5] Login to Cloudflare (browser will open)...
call npx wrangler login
if errorlevel 1 goto :error

echo.
echo [4/5] Creating Cloudflare Pages project...
call npx wrangler pages project create connectvoice --production-branch main --compatibility-date 2024-01-01 2>nul
if errorlevel 1 (
  echo Project may already exist, continuing...
)

echo.
echo [5/5] Deploying to Cloudflare Pages...
call npx wrangler pages deploy dist --project-name connectvoice --branch main
if errorlevel 1 goto :error

echo.
echo ======================================================
echo  DONE! Your site is live on Cloudflare Pages.
echo  Check the URL printed above.
echo ======================================================
echo.
pause
exit /b 0

:error
echo.
echo [FAILED] See error above.
echo Docs: https://developers.cloudflare.com/pages
pause
exit /b 1
