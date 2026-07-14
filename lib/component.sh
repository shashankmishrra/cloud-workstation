#!/usr/bin/env bash

set -Eeuo pipefail

run_component() {
    local root="$1"
    local component="$2"

    local installer="${root}/components/${component}/install.sh"

    if [[ ! -f "${installer}" ]]; then
        log_fatal "Missing installer: ${component}"
    fi

    log_step "Installing ${component}"

    bash "${installer}"

    log_success "${component} completed"
}
