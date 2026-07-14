#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/lib/logging.sh"

PACKAGE_FILE="${ROOT_DIR}/configs/packages/system.txt"

log_step "Installing system packages"

if [[ ! -f "${PACKAGE_FILE}" ]]; then
    log_fatal "Missing package configuration: ${PACKAGE_FILE}"
fi

log_info "Updating package index..."
sudo apt-get update

while IFS= read -r package || [[ -n "$package" ]]; do
    [[ -z "$package" ]] && continue

    if dpkg -s "$package" >/dev/null 2>&1; then
        log_info "$package already installed"
    else
        log_info "Installing $package"
        sudo apt-get install -y "$package"
    fi
done < "${PACKAGE_FILE}"

log_success "System component completed."
