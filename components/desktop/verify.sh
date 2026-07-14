#!/usr/bin/env bash

set -Eeuo pipefail

echo "Verifying desktop component..."

packages=(
    xfce4
    lightdm
)

for pkg in "${packages[@]}"; do
    if dpkg -s "$pkg" >/dev/null 2>&1; then
        echo "✓ $pkg"
    else
        echo "✗ $pkg"
        exit 1
    fi
done

if systemctl is-enabled lightdm >/dev/null 2>&1; then
    echo "✓ lightdm enabled"
else
    echo "✗ lightdm not enabled"
    exit 1
fi

echo
echo "Desktop verification passed."
