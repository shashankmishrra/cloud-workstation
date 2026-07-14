#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/lib/logging.sh"

log_step "Configuring RustDesk"

sudo ufw allow 21115:21119/tcp
sudo ufw allow 21116/udp

log_success "RustDesk firewall configuration completed."
