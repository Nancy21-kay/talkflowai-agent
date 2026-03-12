@echo off
title VoiceAI Demo Site
color 0B
echo.
echo  ==========================================
echo   VoiceAI Demo Site
echo  ==========================================
echo.

REM Check Node is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Node.js not found!
    echo.
    echo  Please install Node.js from:
    echo  https://nodejs.org/
    echo.
    pause
    exit /b 1
)

for /f "tokens=*" %%V in ('node --version') do set NODEVER=%%V
echo  [OK] Node.js %NODEVER% found
echo.

REM Go to root demo folder (one level up from agent)
cd /d "%~dp0.."
echo  Working in: %CD%
echo.

REM Install if node_modules missing
if not exist "node_modules" (
    echo  Installing npm packages... this may take a few minutes
    echo.
    npm install
    if errorlevel 1 (
        echo.
        echo  [ERROR] npm install failed. See error above.
        pause
        exit /b 1
    )
)

echo  [OK] Packages ready
echo.
echo  Starting demo site at http://localhost:3000
echo  Keep this window open while the demo is running.
echo  Press Ctrl+C to stop.
echo.

npm run dev

echo.
echo  ==========================================
echo   Server stopped. Press any key to close.
echo  ==========================================
pause
