#!/bin/bash

# ============================================
# Simple Tests for Workshop
# ============================================

PASSED=0
FAILED=0

# Helper function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"

    if eval "$test_command"; then
        echo "✓ PASSED: $test_name"
        ((PASSED++))
    else
        echo "✗ FAILED: $test_name"
        ((FAILED++))
    fi
}

echo "========================================"
echo "Running Tests..."
echo "========================================"

# Test 1: Check if index.html exists
run_test "index.html exists" "[ -f index.html ]"

# Test 2: Check if index.html is not empty
run_test "index.html is not empty" "[ -s index.html ]"

# Test 3: Check if HTML has required structure
run_test "HTML has <html> tag" "grep -q '<html' index.html"

# Test 4: Check if HTML has head section
run_test "HTML has <head> tag" "grep -q '<head>' index.html"

# Test 5: Check if HTML has body section
run_test "HTML has <body> tag" "grep -q '<body>' index.html"

# Test 6: Check if the name div exists
run_test "Name div exists" "grep -q 'class=\"name\"' index.html"

# Test 7: Check if name was changed from default
run_test "Name was customized (not default)" "! grep -q '>Your Name Here<' index.html"

# Test 8: Check if title exists
run_test "Page has a title" "grep -q '<title>' index.html"

echo "========================================"
echo "Test Results: $PASSED passed, $FAILED failed"
echo "========================================"

# Exit with error if any tests failed
if [ $FAILED -gt 0 ]; then
    exit 1
fi

exit 0
