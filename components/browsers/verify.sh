#!/usr/bin/env bash

set -Eeuo pipefail

echo "Verifying browsers..."

packages=(
    google-chrome-stable
    firefox
)

for package in "${packages[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo "✓ $package"
    else
        echo "✗ $package"
        exit 1
    fi
done

echo
echo "Browser verification passed."
