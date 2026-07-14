#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/lib/logging.sh"

MISE_BIN="$HOME/.local/bin/mise"
BASHRC="$HOME/.bashrc"

log_step "Installing Mise"

# ------------------------------------------------------------------
# Install Mise
# ------------------------------------------------------------------

if [[ ! -x "$MISE_BIN" ]]; then
    log_info "Installing Mise..."
    curl https://mise.run | sh
else
    log_info "Mise already installed."
fi

# ------------------------------------------------------------------
# Ensure ~/.local/bin is on PATH
# ------------------------------------------------------------------

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$BASHRC"; then
    log_info "Adding ~/.local/bin to PATH..."

    cat >> "$BASHRC" <<'EOT'

# Cloud Workstation
export PATH="$HOME/.local/bin:$PATH"
EOT
fi

# ------------------------------------------------------------------
# Enable Mise
# ------------------------------------------------------------------

if ! grep -q 'mise activate bash' "$BASHRC"; then
    log_info "Enabling Mise..."

    cat >> "$BASHRC" <<'EOT'

# Mise
eval "$("$HOME/.local/bin/mise" activate bash)"
EOT
fi

# ------------------------------------------------------------------
# Load into current shell
# ------------------------------------------------------------------

export PATH="$HOME/.local/bin:$PATH"

eval "$("$MISE_BIN" activate bash)"

# ------------------------------------------------------------------
# Install project toolchain
# ------------------------------------------------------------------

cd "$ROOT_DIR"

log_info "Installing toolchain..."

mise install

log_success "Mise installation complete."

echo
log_warn "Run the following once to reload your shell:"
echo
echo "    source ~/.bashrc"
echo
