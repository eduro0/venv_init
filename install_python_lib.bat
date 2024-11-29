@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM Python Environment Library Installer for Windows
REM Run this script as an administrator

REM Check for administrator privileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (
    echo Running with administrator privileges...
) else (
    echo Please run this script as an Administrator.
    pause
    exit /b
)

REM Check if Python is installed
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python is not installed or not in PATH.
    echo Please install Python from https://www.python.org/downloads/windows/
    pause
    exit /b
)

REM Check if pip is available
python -m pip --version >nul 2>nul
if %errorlevel% neq 0 (
    echo Pip is not installed. Attempting to install...
    python -m ensurepip --upgrade
)

REM Upgrade pip to latest version
python -m pip install --upgrade pip

REM Create a log file for installation
set LOGFILE=python_lib_install.log
echo Starting Python Library Installation > "%LOGFILE%"

REM Data Science and Machine Learning Libraries
echo Installing Data Science and Machine Learning Libraries...
python -m pip install numpy pandas scikit-learn scipy matplotlib seaborn torch >> "%LOGFILE%" 2>&1

REM Utility and Productivity Libraries
echo Installing Utility Libraries...
python -m pip install tqdm python-dotenv >> "%LOGFILE%" 2>&1

REM Virtual Environment Creation
set /p CREATE_VENV="Would you like to create a virtual environment? (y/n): "
if /i "%CREATE_VENV%"=="y" (
    set /p VENV_NAME="Enter virtual environment name (default: myenv): "
    if not defined VENV_NAME set VENV_NAME=myenv
    
    python -m venv !VENV_NAME!
    echo Virtual environment '!VENV_NAME!' created.
    echo Activate it using: !VENV_NAME!\Scripts\activate
)

echo Python library installation complete!
echo Check %LOGFILE% for detailed installation log.
pause
