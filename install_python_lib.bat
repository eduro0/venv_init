@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM Python Environment Library Installer for Windows
REM Run this script as an administrator

REM Get the parent directory (one level up from the script location)
pushd "%~dp0\.."
set "PARENT_DIR=%CD%"
popd

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

REM Virtual Environment Creation (BEFORE library installation)
set /p CREATE_VENV="Would you like to create a virtual environment (or run the installation in a preexisting one)? (y/n): "
if /i "%CREATE_VENV%"=="y" (
    set /p VENV_NAME="Enter virtual environment name (default: venv): "
    if not defined VENV_NAME set VENV_NAME=venv
    
    REM Check if the virtual environment already exists
    if exist "%PARENT_DIR%\!VENV_NAME!\" (
        echo Virtual environment already exists in %PARENT_DIR%\!VENV_NAME!
        set /p OVERWRITE_VENV="Would you like to overwrite the existing virtual environment? (y/n): "
        if /i "%OVERWRITE_VENV%"=="n" (
            echo Skipping virtual environment creation...
            goto :SKIP_VENV
        ) else (
            if /i "%OVERWRITE_VENV%"=="y" (
                echo Overwriting existing virtual environment...
                rmdir /s /q "%PARENT_DIR%\!VENV_NAME!"
                REM Create venv in the parent directory
                echo Creating virtual environment in %PARENT_DIR%\!VENV_NAME!
                python -m venv "%PARENT_DIR%\!VENV_NAME!"
            )
        )
    )
    
    if /i "%CREATE_VENV%"=="y" (
        REM Activate the virtual environment
        echo Activating virtual environment...
        call "%PARENT_DIR%\!VENV_NAME!\Scripts\activate.bat"
    )
)

REM Ask if the user would like to install any additional libries
set /p ADD_LIB="Would you like to install additional libraries other than the ones specified in the README? (y/n): "
if /i "%ADD_LIB%"=="y" (
    set /p ADD_LIBS="Enter the libraries you would like to install (separated by space): "
    if not defined ADD_LIBS (
        echo No additional libraries specified. Skipping...
    )
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
set LOGFILE=%PARENT_DIR%\venv_init\install_log.txt
echo Starting Python Library Installation > "%LOGFILE%"

REM Data Science and Machine Learning Libraries
echo Installing Data Science and Machine Learning Libraries...
python -m pip install numpy pandas scikit-learn scipy matplotlib seaborn torch >> "%LOGFILE%" 2>&1

REM Utility and Productivity Libraries
echo Installing Utility Libraries...
python -m pip install tqdm ipykernel python-dotenv >> "%LOGFILE%" 2>&1

REM Install additional libraries if specified
if defined ADD_LIBS (
    echo Installing Additional Libraries...
    python -m pip install %ADD_LIBS% >> "%LOGFILE%" 2>&1
)


echo Python library installation complete!
echo Check %LOGFILE% for detailed installation log.
echo Virtual environment created in %PARENT_DIR%\!VENV_NAME!
pause