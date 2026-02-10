# Setup script for Windows
Write-Host "Setting up Calculator MCP Server..." -ForegroundColor Green

# Check if we're in the right directory
if (-Not (Test-Path "calculator_server.py")) {
    Write-Host "Error: Run this script from the calculator-mcp-server directory!" -ForegroundColor Red
    exit 1
}

# Check if uv is installed
try {
    uv --version | Out-Null
    Write-Host "UV found, using UV for setup..." -ForegroundColor Cyan
    $useUV = $true
} catch {
    Write-Host "UV not found, using standard Python..." -ForegroundColor Yellow
    $useUV = $false
}

# Create virtual environment
if ($useUV) {
    Write-Host "Creating virtual environment with UV..." -ForegroundColor Cyan
    uv venv
} else {
    Write-Host "Creating virtual environment with Python..." -ForegroundColor Cyan
    python -m venv venv
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Cyan
& ".\.venv\Scripts\Activate.ps1"

# Install dependencies
if ($useUV) {
    Write-Host "Installing dependencies with UV..." -ForegroundColor Cyan
    uv pip install -r requirements.txt
    uv pip install matplotlib  # Adding matplotlib separately since it's missing from requirements.txt
    uv pip install -e .
} else {
    Write-Host "Installing dependencies with pip..." -ForegroundColor Cyan
    pip install -r requirements.txt
    pip install matplotlib
    pip install -e .
}

Write-Host "`nSetup complete!" -ForegroundColor Green
Write-Host "`nTo test the server, run:" -ForegroundColor Yellow
Write-Host "  python calculator_server.py" -ForegroundColor White
Write-Host "`nClaude Desktop configuration:" -ForegroundColor Yellow
Write-Host @"
{
  "mcpServers": {
    "calculator": {
      "command": "$($PWD)\.venv\Scripts\python.exe",
      "args": ["$($PWD)\calculator_server.py"]
    }
  }
}
"@ -ForegroundColor White
