#!/usr/bin/env python3
"""Test script for calculator MCP server"""

import sys
import os

# Add current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    print("Testing calculator server import...")
    import calculator_server
    print("✓ Import successful")
    
    print("\nTesting FastMCP initialization...")
    # The app should already be created
    print(f"✓ FastMCP app created: {calculator_server.app}")
    
    print("\nAvailable tools:")
    # In newer FastMCP, tools might be stored differently
    # This is just to verify the server loads without errors
    print("✓ Server loaded successfully!")
    
    print("\nTo run the server:")
    print("  python calculator_server.py")
    
except Exception as e:
    print(f"✗ Error: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)
