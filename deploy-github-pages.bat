@echo off
setlocal
cd /d "%~dp0"

echo.
echo ======================================================
echo  ConnectVoice - GitHub Pages Deploy
echo ======================================================
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Node.js not installed. Get it from https://nodejs.org
  pause
  exit /b 1
)

REM Check for gh CLI
where gh >nul 2>&1
if errorlevel 1 (
  echo [NOTE] GitHub CLI not found. Install from https://cli.github.com
  echo        Or just use git commands manually (see script output).
  echo.
)

REM Install gh-pages deployer
echo [1/5] Installing gh-pages...
if not exist "node_modules\gh-pages" call npm install --no-save --no-audit --no-fund gh-pages
if errorlevel 1 goto :error

echo.
echo [2/5] Building...
call npm run build
if errorlevel 1 goto :error

echo.
echo [3/5] You need a GitHub repo called YOUR_USERNAME.github.io
echo        or any repo with Pages enabled in Settings.
echo.
echo        Create one at: https://github.com/new
echo.
pause

echo.
echo [4/5] Setting up git remote...
set /p GHUSER="Enter your GitHub username: "
git remote remove origin 2>nul
git remote add origin https://github.com/%GHUSER%/connectvoice.git
git branch -M main
git push -u origin main
if errorlevel 1 (
  echo [WARN] Could not push automatically. Do it manually:
  echo   git remote add origin https://github.com/%GHUSER%/connectvoice.git
  echo   git push -u origin main
  pause
)

echo.
echo [5/5] Deploying to GitHub Pages...
call npx gh-pages -d dist
if errorlevel 1 goto :error

echo.
echo ======================================================
echo  DONE!
echo  1. Go to https://github.com/%GHUSER%/connectvoice/settings/pages
echo  2. Under "Source" select branch "gh-pages" / root
echo  3. Wait 1 minute, your site is live at:
echo     https://%GHUSER%.github.io/connectvoice
echo ======================================================
echo.
pause
exit /b 0

:error
echo.
echo [FAILED] See error above.
pause
exit /b 1
