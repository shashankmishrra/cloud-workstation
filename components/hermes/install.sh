#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/lib/logging.sh"

HERMES_BIN="$HOME/.local/bin/hermes"

log_step "Installing Hermes Agent"

if [[ -x "$HERMES_BIN" ]]; then
    log_info "Hermes Agent already installed."
else
    log_info "Downloading and installing Hermes Agent..."
    curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
fi

export PATH="$HOME/.local/bin:$PATH"

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
cat >> ~/.bashrc <<'EOT'

# Local user binaries
export PATH="$HOME/.local/bin:$PATH"
EOT
fi

log_success "Hermes Agent installed."

echo
log_warn "Reload your shell:"
echo "    source ~/.bashrc"
echo
log_warn "Then complete first-time setup:"
echo "    hermes setup --portal"
