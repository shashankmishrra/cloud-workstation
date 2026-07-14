#!/usr/bin/env bash

set -Eeuo pipefail

export PATH="$HOME/.local/bin:$PATH"

if [[ -x "$HOME/.local/bin/mise" ]]; then
    eval "$("$HOME/.local/bin/mise" activate bash)"
fi

echo "Verifying Mise..."
echo

which mise
mise --version
echo

node --version
pnpm --version
echo

mise ls

echo
echo "✓ Mise verification passed."
