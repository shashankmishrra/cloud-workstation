#!/usr/bin/env bash

set -Eeuo pipefail

readonly LOG_RESET="\033[0m"

readonly LOG_BLUE="\033[1;34m"
readonly LOG_GREEN="\033[1;32m"
readonly LOG_YELLOW="\033[1;33m"
readonly LOG_RED="\033[1;31m"
readonly LOG_GRAY="\033[0;90m"

_timestamp() {
    date +"%H:%M:%S"
}

_log() {
    local color="$1"
    local level="$2"
    shift 2

    printf "%b[%s] %-7s%b %s\n" \
        "$color" \
        "$(_timestamp)" \
        "$level" \
        "$LOG_RESET" \
        "$*"
}

log_step() {
    _log "$LOG_BLUE" "STEP" "$@"
}

log_info() {
    _log "$LOG_GRAY" "INFO" "$@"
}

log_success() {
    _log "$LOG_GREEN" "SUCCESS" "$@"
}

log_warn() {
    _log "$LOG_YELLOW" "WARNING" "$@"
}

log_error() {
    _log "$LOG_RED" "ERROR" "$@"
}

log_fatal() {
    log_error "$@"
    exit 1
}
