# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Mathematical Calculator MCP Server - extends Claude's mathematical capabilities through the Model Context Protocol (MCP) with 23 specialized mathematical tools for symbolic math, statistics, and matrix operations.

## Core Architecture

- **Framework**: FastMCP (v0.4.1+) with decorator-based tool definitions
- **Main Module**: `calculator_server.py` - all tools implemented as `@app.tool()` decorated functions
- **Transport**: Supports both STDIO and SSE protocols (SSE default, use `--stdio` flag for STDIO)
- **Security**: Restricted evaluation context with function allowlist in `ALLOW_FUNCTION` dict

## Development Commands

### Setup Virtual Environment (Windows)
```bash
# Windows Batch script
setup_windows.bat

# Windows PowerShell script  
setup_windows.ps1

# Git Bash/Unix-style
bash setup_venv.sh

# Manual setup
python -m venv venv
venv\Scripts\activate  # Windows CMD
# or: source venv/bin/activate  # Git Bash/Unix
pip install -r requirements.txt
pip install matplotlib  # Additional dependency
pip install -e .  # Install package in editable mode
```

### Run Tests
```bash
# Test server import and initialization
python test_server.py

# Run comprehensive doctests
bash run_doctests.sh
# Equivalent: python -m doctest -v calculator_server.py
```

### Run Server
```bash
# Development mode with web interface
fastmcp dev calculator_server.py

# Run server with SSE transport (default)
python calculator_server.py

# Run server with STDIO transport
python calculator_server.py --stdio

# Production via uvx
uvx --from calculator-mcp-server@git+https://github.com/huhabla/calculator-mcp-server.git -- calculator-mcp-server --stdio
```

## Key Dependencies

- **fastmcp>=0.4.1**: MCP server framework
- **numpy>=2.2.0**: Numerical computations
- **scipy>=1.15.0**: Statistical analysis  
- **sympy>=1.13.0**: Symbolic mathematics
- **matplotlib**: Function plotting
- **pydantic>=2.10.0**: Data validation
- **pytest>=8.3.0**: Testing framework (dev)

## Tool Categories (23 tools)

1. **Basic**: `calculate()` - safe expression evaluation with restricted context
2. **Symbolic Math** (7 tools): `solve_equation()`, `differentiate()`, `integrate()`, `expand()`, `factorize()`, `summation()`, `plot_function()`
3. **Statistics** (8 tools): `mean()`, `median()`, `mode()`, `variance()`, `standard_deviation()`, `correlation_coefficient()`, `linear_regression()`, `confidence_interval()`
4. **Matrix/Vector** (7 tools): `matrix_addition()`, `matrix_multiplication()`, `matrix_transpose()`, `matrix_determinant()`, `vector_dot_product()`, `vector_cross_product()`, `vector_magnitude()`

## Error Handling Pattern

All tools follow consistent error handling:
```python
try:
    result = computation()
    return {"result": result}
except Exception as e:
    return {"error": str(e)}
```

## Windows-Specific Notes

- Shell scripts (`.sh`) require Git Bash or WSL on Windows
- Use `setup_windows.bat` or `setup_windows.ps1` for native Windows setup
- Virtual environment activation: `venv\Scripts\activate` (Windows CMD/PowerShell)
- Path separators in Python code use forward slashes for cross-platform compatibility

## Testing Approach

- **Doctests**: Embedded in function docstrings, validated via `run_doctests.sh`
- **Import test**: `test_server.py` verifies server initialization
- **Interactive testing**: Use FastMCP dev mode (`fastmcp dev calculator_server.py`)

## Main Entry Point

The server starts from `calculator_server.py:main()` which:
1. Parses command-line arguments (`--stdio` flag)
2. Determines transport type (SSE default, STDIO optional)
3. Runs FastMCP app with selected transport

## Claude Desktop Integration

Configuration file location:
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`
- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`

Add to `mcpServers` section for STDIO transport (required for Claude Desktop):
```json
{
  "mcpServers": {
    "calculator": {
      "command": "uvx",
      "args": [
        "--from",
        "calculator-mcp-server@git+https://github.com/huhabla/calculator-mcp-server.git",
        "--",
        "calculator-mcp-server",
        "--stdio"
      ]
    }
  }
}
```