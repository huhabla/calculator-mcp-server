@echo off
echo Setting up Calculator MCP Server...

REM Check if we're in the right directory
if not exist calculator_server.py (
    echo Error: Run this script from the calculator-mcp-server directory!
    exit /b 1
)

REM Create virtual environment
echo Creating virtual environment...
python -m venv venv

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Install dependencies
echo Installing dependencies...
pip install -r requirements.txt
pip install matplotlib
pip install -e .

echo.
echo Setup complete!
echo.
echo To test the server, run:
echo   python test_server.py
echo.
echo Then to run the server:
echo   python calculator_server.py
echo.
