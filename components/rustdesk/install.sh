#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/lib/logging.sh"

if command -v rustdesk >/dev/null 2>&1; then
    log_info "RustDesk already installed."
else
    log_fatal "RustDesk is not installed.

For now this project assumes the RustDesk package has already been downloaded.
Automatic installation will be implemented later."
fi

log_success "RustDesk installation verified."
