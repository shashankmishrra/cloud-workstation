#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/lib/logging.sh"

log_step "Installing Docker"

if ! command -v docker >/dev/null 2>&1; then

    sudo apt-get update

    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg

    sudo install -m 0755 -d /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

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
done < "${ROOT_DIR}/configs/packages/docker.txt"

sudo usermod -aG docker "$USER"

sudo systemctl enable docker
sudo systemctl start docker

log_success "Docker installed."
