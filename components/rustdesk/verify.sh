#!/usr/bin/env bash

set -Eeuo pipefail

echo "Verifying RustDesk..."

command -v rustdesk >/dev/null

systemctl is-enabled rustdesk >/dev/null
systemctl is-active rustdesk >/dev/null

echo "✓ RustDesk installed"
echo "✓ RustDesk enabled"
echo "✓ RustDesk running"

echo
echo "RustDesk verification passed."
