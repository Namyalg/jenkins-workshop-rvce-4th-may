#!/bin/bash

# ============================================
# Simple Tests for Workshop
# ============================================

PASSED=0
FAILED=0

echo "========================================"
echo "Running Tests..."
echo "========================================"

# Test 1: Check if index.html exists
if [ -f index.html ]; then
    echo "✓ PASSED: index.html exists"
    ((PASSED++))
else
    echo "✗ FAILED: index.html not found"
    ((FAILED++))
fi

# Test 2: Check if name was changed from default
if grep -q '>Your Name Here<' index.html; then
    echo "✗ FAILED: Name not changed - please update your name in index.html"
    ((FAILED++))
else
    echo "✓ PASSED: Name was customized"
    ((PASSED++))
fi

# Test 3: Check if title was changed from default
if grep -q '<title>Jenkins Workshop - RVCE</title>' index.html; then
    echo "✗ FAILED: Title not changed - please update the title with your name"
    ((FAILED++))
else
    echo "✓ PASSED: Title was customized"
    ((PASSED++))
fi

echo "========================================"
echo "Test Results: $PASSED passed, $FAILED failed"
echo "========================================"

# Exit with error if any tests failed
if [ $FAILED -gt 0 ]; then
    exit 1
fi

exit 0
