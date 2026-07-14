#!/usr/bin/env bash

set -Eeuo pipefail

export PATH="$HOME/.local/bin:$PATH"

echo "Verifying Hermes Agent..."
echo

which hermes

hermes --version

echo
echo "✓ Hermes Agent installed"
