@echo off
echo ============================================
echo  ConnectVoice - Vercel Deploy Script
echo ============================================
echo.

REM Install Vercel CLI if not present
where vercel >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Vercel CLI...
    call npm install -g vercel
)

echo.
echo Logging in to Vercel (browser will open)...
call vercel login

echo.
echo Deploying to Vercel...
call vercel --prod

echo.
echo ============================================
echo  Done! Your site is live.
echo  Check the URL printed above.
echo ============================================
pause
