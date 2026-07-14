#!/usr/bin/env bash

set -Eeuo pipefail

commands=(
    git
    curl
    wget
    jq
)

echo "Verifying system component..."

for cmd in "${commands[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "✓ $cmd"
    else
        echo "✗ $cmd"
        exit 1
    fi
done

echo
echo "System verification passed."
