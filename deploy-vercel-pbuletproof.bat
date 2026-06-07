@echo off
setlocal
cd /d "%~dp0"

echo.
echo ======================================================
echo  ConnectVoice - Vercel Deploy (BULLETPROOF MODE)
echo  Builds LOCALLY, uploads prebuilt files to Vercel.
echo  This BYPASSES all Vercel build issues.
echo ======================================================
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Node.js not installed.
  pause
  exit /b 1
)

REM Step 1: Clean previous builds
echo [1/5] Cleaning previous build artifacts...
if exist dist rmdir /s /q dist
if exist .tanstack rmdir /s /q .tanstack
if exist node_modules\.vite rmdir /s /q node_modules\.vite
if exist node_modules\.cache rmdir /s /q node_modules\.cache

REM Step 2: Fresh install (clean lockfile ensures no weird state)
echo.
echo [2/5] Ensuring dependencies are installed...
call npm install --no-audit --no-fund --legacy-peer-deps
if errorlevel 1 (
  echo [ERROR] npm install failed
  pause
  exit /b 1
)

REM Step 3: Build locally
echo.
echo [3/5] Building project locally...
call npm run build
if errorlevel 1 (
  echo [ERROR] Build failed. See errors above.
  pause
  exit /b 1
)

REM Verify dist exists
if not exist "dist\index.html" (
  echo [ERROR] dist\index.html was not created. Build broken.
  pause
  exit /b 1
)

echo Build successful. dist/ contains:
dir /b dist

REM Step 4: Install Vercel CLI locally
echo.
echo [4/5] Setting up Vercel CLI...
if not exist "node_modules\vercel" (
  call npm install --no-save --no-audit --no-fund vercel@latest
  if errorlevel 1 (
    echo [ERROR] Failed to install Vercel CLI
    pause
    exit /b 1
  )
)

REM Step 5: Deploy prebuilt output
echo.
echo [5/5] Deploying to Vercel...
echo A browser will open for login if this is your first time.
echo.

REM Use --prebuilt to skip Vercel-side build, use our local dist
call npx vercel deploy --prebuilt --prod --yes
if errorlevel 1 (
  echo.
  echo ======================================================
  echo  First-time setup? You may need to link a project.
  echo  Run: npx vercel link
  echo  Then run this script again.
  echo ======================================================
  pause
  exit /b 1
)

echo.
echo ======================================================
echo  DEPLOYED! Your site is live.
echo  The URL is shown above (something.vercel.app).
echo ======================================================
echo.
pause
exit /b 0
