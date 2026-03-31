# Mathematical Calculator MCP Server

This is a Model Context Protocol (MCP) server that provides Claude with advanced mathematical calculation capabilities, including symbolic math, statistical analysis, and matrix operations.

## Features

The Mathematical Calculator MCP Server provides the following tools:

- **Basic Calculations**: Evaluate mathematical expressions safely
- **Batch Calculations**: Submit multiple calculations in a single call with dependency chaining
- **Symbolic Mathematics**:
  - Solve equations (linear, quadratic, polynomial, etc.)
  - Calculate derivatives of expressions
  - Compute integrals of expressions
- **Statistical Analysis**:
  - Mean, median, mode
  - Variance, standard deviation
  - Correlation coefficient
  - Linear regression
  - Confidence intervals
- **Matrix Operations**:
  - Matrix addition
  - Matrix multiplication
  - Matrix transposition

## Installation

### Prerequisites

- Python 3.10+ (recommended: Python 3.11+)
- [uv](https://github.com/astral-sh/uv) (recommended) or pip
- Claude Desktop app (to use the MCP server with Claude)

### Installation Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/2b3pro/calculator-mcp-server.git
   cd calculator-mcp-server
   ```

2. Install with uv (recommended):
   ```bash
   uv sync
   ```

   Or with pip:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -e .
   ```

3. Run doc-tests to verify everything works:
   ```bash
   python3 -m doctest calculator_server.py -v
   ```

## Integration with Claude Desktop

### Method 1: Configure in Claude Desktop

Add the server to your Claude Desktop configuration file:

**macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

Add the following to the `mcpServers` section:

```json
{
  "mcpServers": {
    "calculator": {
      "command": "uvx",
      "args": [
        "--from",
        "calculator-mcp-server@git+https://github.com/2b3pro/calculator-mcp-server.git",
        "--",
        "calculator-mcp-server",
        "--stdio"
      ]
    }
  }
}
```

**Note**: The `--stdio` flag is required for proper integration with Claude Desktop. The `--` separates uvx arguments from the calculator server arguments.

### Method 2: Install with FastMCP

1. Make sure you have uv installed ([Installation Guide](https://github.com/astral-sh/uv))

2. Install the MCP server in Claude Desktop:
   ```bash
   fastmcp install calculator_server.py
   ```

   Or with a custom name:
   ```bash
   fastmcp install calculator_server.py --name "Math Calculator"
   ```

3. Once installed, Claude will automatically have access to all the mathematical tools and functions.

## Usage Examples

After integrating with Claude Desktop, you can ask Claude to perform various mathematical operations. Here are some examples:

### Basic Calculations
```
Can you calculate 3.5^2 * sin(pi/4)?
```

### Batch Calculations

Submit multiple calculations in one call, with results from earlier steps feeding into later ones:

```
Calculate these in one batch:
- step "radius": 5
- step "area": pi * $radius ** 2
- step "circumference": 2 * pi * $radius
```

This sends a single request to the server and returns all three results. The `$radius` references are automatically resolved from the first step's result.

Dependency chaining example:
```
Batch calculate:
- step "base": 100
- step "tax": $base * 0.08
- step "total": $base + $tax
- step "tip": $total * 0.20
- step "grand_total": $total + $tip
```

### Solving Equations
```
Solve the following equation: x^2 - 5x + 6 = 0
```

### Calculating Derivatives
```
What's the derivative of sin(x^2) with respect to x?
```

### Computing Integrals
```
Calculate the integral of x^2 * e^x
```

### Statistical Analysis
```
Find the mean, median, mode, and standard deviation of this dataset: [23, 45, 12, 67, 34, 23, 18, 95, 41, 23]
```

### Linear Regression
```
Perform a linear regression on these points: (1,2), (2,3.5), (3,5.1), (4,6.5), (5,8.2)
```

### Matrix Operations
```
Multiply these two matrices:
[1, 2, 3]
[4, 5, 6]

and

[7, 8]
[9, 10]
[11, 12]
```

## Development

### Running Locally

```bash
uv run calculator_server.py
```

### Testing

Run doctests:
```bash
uv run python -m doctest calculator_server.py -v
```

### Interactive Development Mode

For development and debugging, you can use the FastMCP development mode:
```bash
uv run fastmcp dev calculator_server.py
```

This will start a local web interface where you can test all tools interactively.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [FastMCP](https://github.com/jlowin/fastmcp) for the Pythonic MCP server framework
- [SymPy](https://sympy.org/) for symbolic mathematics
- [NumPy](https://numpy.org/) and [SciPy](https://scipy.org/) for numerical and statistical computations
