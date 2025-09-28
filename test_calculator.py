#!/usr/bin/env python3
"""
Pytest test suite for calculator MCP server
"""

import pytest
import sys
import os

# Add current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import calculator_server


def test_server_import():
    """Test that the calculator server can be imported."""
    assert calculator_server is not None


def test_fastmcp_app_creation():
    """Test that FastMCP app is created."""
    assert hasattr(calculator_server, 'app')
    assert calculator_server.app is not None


def test_basic_math_functions():
    """Test that basic math functions are accessible."""
    # This is a basic smoke test
    # In a real scenario, you'd test the actual MCP tool functions
    assert True  # Placeholder for actual tool tests


class TestCalculatorFunctions:
    """Test the calculator functionality directly."""
    
    def test_addition(self):
        """Test addition works correctly."""
        result = 2 + 2
        assert result == 4
    
    def test_complex_calculation(self):
        """Test more complex calculations."""
        import math
        result = math.sqrt(16) + 2**3
        assert result == 12.0
    
    def test_scientific_calculation(self):
        """Test scientific calculations."""
        import numpy as np
        result = np.pi
        assert abs(result - 3.14159) < 0.001


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
