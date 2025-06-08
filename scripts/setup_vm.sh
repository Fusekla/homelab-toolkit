#!/bin/bash
set -euo pipefail

# Set default variable values
SCRIPT_VERSION="0.0.2"
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_FILE="$LOG_DIR/$(date +%Y%m%d-%H%M_setup_vm.log)"
VM_NAME=""

# Ensure we have log directory present
mkdir -p "$LOG_DIR"

# Load helper scripts
source "$(dirname "${BASH_SOURCE[0]}")/helpers/logging.sh"

# Help section
print_usage() {
  # Display help
  echo "This script provisions a VM."
  echo
  echo "Available flags :"
  echo "  -h|--help         -> Prints help"
  echo "  -v|--vm-name      -> Set VM name (required) [1-8 alphanumerical characters]"
  echo "Usage :"
  echo "  setup_vm.sh [-h, --help|-v, --vm-name <vm-name>]"
  echo
}

# create_vm
# Simulates VM provisioning. Expects one argument : VM name
create_vm() {
  log INFO "Provisioning VM : $1"
  sleep 1
  log SUCCESS "VM $1 successfully provisioned!"
}

# cleanup
# Placeholder for later cleanup function
cleanup() {
  echo "Doing cleanup"
}

# validate_input
# Validates is user provided VM name consists of 1-8 alphanumerical characters
validate_input() {
  if [[ "$1" =~ ^[a-zA-Z0-9]{1,8}$ ]]; then
    log INFO "Provided VM name '$1' is valid, proceeding with creation."
  else
    log ERROR "Provided VM name '$1' is invalid - must be 1-8 alphanumerical characters"
    exit 1
  fi
}

# Collect user provided arguments and validate
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      print_usage
      exit 0
      ;;
    -v|--vm-name)
      if [[ -n "${2:-}" ]]; then
        VM_NAME="$2"
        shift 2
      else
        echo "Error: --vm-name requires a value"
        exit 1
      fi
      ;;
    *)
      echo "Error: Unknown option: $1"
      print_usage
      exit 1
      ;;
  esac
done

if [[ -z "$VM_NAME" ]]; then
  echo "Error: VM name is required"
  print_usage
  exit 1
fi

# Validate provided VM name
validate_input "$VM_NAME"

# Provision VM
create_vm "$VM_NAME"
