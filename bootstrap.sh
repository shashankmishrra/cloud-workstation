#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${ROOT_DIR}/lib/logging.sh"
source "${ROOT_DIR}/lib/component.sh"

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
    run_component "${ROOT_DIR}" "${component}"
    echo
done

log_success "Bootstrap completed successfully."
