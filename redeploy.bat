@echo off
echo.
echo ======================================================
echo  ConnectVoice - Re-deploy with SPA fix
echo ======================================================
echo.
echo Your dist folder now has the _redirects file.
echo.
echo NEXT STEPS (do this on your PHONE or computer):
echo.
echo 1. Go to: https://app.netlify.com/
echo 2. Click on your site (connect-voice)
echo 3. Go to "Deploys" tab
echo 4. Scroll to the bottom: "Need to update your site?"
echo 5. Drag this folder onto that area: E:\New folder (2)\connectvoice\dist
echo 6. Wait 10 seconds for redeploy
echo.
echo OR if you used Surge.sh, run this in PowerShell:
echo   cd "E:\New folder (2)\connectvoice"
echo   npx surge dist connect-voice.surge.sh
echo.
echo.
echo Opening Netlify dashboard for you...
start https://app.netlify.com/
pause
