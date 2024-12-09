# Python Environment Library Installer

## Prerequisites
- Python 3.8+ installed
- pip installed
- Administrative/root privileges

## Installation Instructions

### Windows
1. Download the `install_python_libs.bat` by cloning the repository on your project directory
```bash
git clone https://github.com/eduro0/venv_init.git
```
2. Right-click and "Run as Administrator"
3. Follow the on-screen prompts

### Linux/macOS
```bash
# Clone the repository
git clone https://github.com/eduro0/venv_init.git

# Navigate to the directory
cd python-env-setup

# Make the script executable
chmod +x install_python_libs.sh

# Run with sudo
sudo ./install_python_libs.sh
```

## What This Script Does
- Updates pip to the latest version
- Installs common Python libraries for:
  - Machine Learning
  - Data Processing
  - Utilities
  - User Specified Libraries
- Optional virtual environment creation (in the parent directory, namely, the one you want your project to be in)

The script installs the following libraries:
- numpy
- pandas
- matplotlib
- seaborn
- scikit-learn
- torch
- transformers
- regex
- tqdm 
- ipykernel 
- python-dotenv

## Customization
Edit the script to add or remove libraries based on your project needs.

## Troubleshooting
- Ensure Python and pip are installed
- Check the installation log file for any errors
- Verify your Python installation adds Python to system PATH
