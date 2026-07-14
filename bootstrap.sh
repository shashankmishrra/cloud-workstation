#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${ROOT_DIR}/lib/logging.sh"

COMPONENTS_FILE="${ROOT_DIR}/configs/components.conf"

log_step "Cloud Workstation Bootstrap"

if [[ ! -f "${COMPONENTS_FILE}" ]]; then
    log_fatal "Missing component manifest: ${COMPONENTS_FILE}"
fi

log_info "Loading component manifest..."

mapfile -t COMPONENTS < "${COMPONENTS_FILE}"

log_success "Loaded ${#COMPONENTS[@]} components"

echo

for component in "${COMPONENTS[@]}"; do
    COMPONENT_DIR="${ROOT_DIR}/scripts/${component}"

    if [[ -d "${COMPONENT_DIR}" ]]; then
        log_success "Found component: ${component}"
    else
        log_error "Missing component: ${component}"
        exit 1
    fi
done

echo

log_success "Bootstrap validation completed successfully."
