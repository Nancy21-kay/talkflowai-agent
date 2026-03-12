@echo off
title VoiceAI Agent
color 0A
echo.
echo  ==========================================
echo   VoiceAI Agent Launcher
echo  ==========================================
echo.

REM Check Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Python not found!
    echo.
    echo  Install Python 3.11 from:
    echo  https://www.python.org/downloads/release/python-3119/
    echo.
    echo  Check "Add Python to PATH" during install, then restart PC.
    pause
    exit /b 1
)

REM Get version string
for /f "tokens=2 delims= " %%V in ('python --version 2^>^&1') do set PYVER=%%V
for /f "tokens=1,2 delims=." %%A in ("%PYVER%") do (
    set PYMAJ=%%A
    set PYMIN=%%B
)

REM Block Python 3.13 and 3.14 - too new, LiveKit won't install
if "%PYMAJ%"=="3" (
    if %PYMIN% GEQ 13 (
        echo  [ERROR] Python %PYVER% is too new!
        echo.
        echo  LiveKit requires Python 3.11 or 3.12.
        echo  Install Python 3.11 from:
        echo  https://www.python.org/downloads/release/python-3119/
        echo.
        pause
        exit /b 1
    )
)

echo  [OK] Python %PYVER% found
echo.

cd /d "%~dp0"

echo  Installing dependencies (first run takes 2-5 minutes, please wait)...
echo.
pip install -r requirements.txt --timeout 120 --retries 5
if errorlevel 1 (
    echo.
    echo  [ERROR] Failed to install dependencies.
    echo  Check your internet connection and try again.
    echo  If the problem persists, try running as Administrator.
    pause
    exit /b 1
)

echo.
echo  [OK] Dependencies ready
echo.
echo  Agent is starting... (connecting to LiveKit cloud)
echo  Keep this window open while the demo is running.
echo  Press Ctrl+C to stop.
echo.

python main.py dev

pause
