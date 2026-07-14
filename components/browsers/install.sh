#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/lib/logging.sh"

log_step "Installing browsers"

if ! dpkg -s google-chrome-stable >/dev/null 2>&1; then
    log_info "Adding Google Chrome repository..."

    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
        | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg

    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
        | sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null

    sudo apt-get update
fi

while IFS= read -r package || [[ -n "$package" ]]; do
    [[ -z "$package" ]] && continue

    if dpkg -s "$package" >/dev/null 2>&1; then
        log_info "$package already installed"
    else
        log_info "Installing $package"
        sudo apt-get install -y "$package"
    fi
done < "${ROOT_DIR}/configs/packages/browsers.txt"

log_success "Browsers installed."
