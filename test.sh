#!/bin/bash

# Hidden test values
GROUP_NAME="developers"

echo "Running tests..."

# Clean up before testing
sudo groupdel "$GROUP_NAME" 2>/dev/null || true

# Run student script
sudo bash starter.sh

# Test 1: Group should have been created and deleted
if getent group "$GROUP_NAME" > /dev/null 2>&1; then
    echo "FAIL: Group '$GROUP_NAME' still exists."
    exit 1
else
    echo "PASS: Group was deleted successfully."
fi

# Test 2: Check that script contains groupadd
if grep -Eq '(^|[[:space:];&|])groupadd([[:space:]]|$)' starter.sh; then
    echo "PASS: groupadd command found."
else
    echo "FAIL: groupadd command not found."
    exit 1
fi

# Test 3: Check that script contains groupdel
if grep -Eq '(^|[[:space:];&|])groupdel([[:space:]]|$)' starter.sh; then
    echo "PASS: groupdel command found."
else
    echo "FAIL: groupdel command not found."
    exit 1
fi

echo "All tests passed!"
exit 0
