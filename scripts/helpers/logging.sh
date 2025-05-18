#!/bin/bash
# Logging functions for bash scripts
# This script provides functions to log messages with different severity levels (info, warning, error)
# and to format the log messages with timestamps.
# Usage:
#   source logging.sh
#   log_info "This is an info message"
#   log_warning "This is a warning message"
#   log_error "This is an error message"
#   log_debug "This is a debug message"
#   log "INFO" "This is a custom log message"

log() {
  local level="$1"; shift
  local message="$@"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" | tee -a "$LOG_FILE"
}