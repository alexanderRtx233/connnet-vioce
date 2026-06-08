@echo off
setlocal
cd /d "%~dp0"

echo.
echo ======================================================
echo  ConnectVoice - Expose Local Server with ngrok
echo ======================================================
echo.
echo This makes your local server (already running on port 5173)
echo publicly accessible via a temporary ngrok URL.
echo No signup needed for basic use.
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Node.js not installed. Get it from https://nodejs.org
  pause
  exit /b 1
)

REM Check if local server is running
netstat -an | findstr ":5173.*LISTENING" >nul
if errorlevel 1 (
  echo [NOTE] Local server not detected on port 5173.
  echo        Starting it now...
  call serve.bat
  timeout /t 5 /nobreak >nul
)

echo [1/3] Installing ngrok...
if not exist "node_modules\.bin\ngrok.cmd" call npm install --no-save --no-audit --no-fund ngrok
if errorlevel 1 goto :error

echo.
echo [2/3] Configuring ngrok (free, no auth needed for limited use)...
echo        If asked, sign up free at https://dashboard.ngrok.com/signup
echo        and paste your authtoken here.
echo.
set /p AUTHTOKEN="Paste your ngrok authtoken (or press Enter to try without): "
if not "%AUTHTOKEN%"=="" call npx ngrok config add-authtoken %AUTHTOKEN%

echo.
echo [3/3] Starting ngrok tunnel to port 5173...
echo.
echo ======================================================
echo  COPY THE URL that looks like https://xxxx-xxx.ngrok-free.app
echo  That's your public URL. Anyone in the world can use it.
echo  Press Ctrl+C to stop.
echo ======================================================
echo.
call npx ngrok http 5173

:error
echo [FAILED]
pause
