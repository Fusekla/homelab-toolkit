#!/bin/bash
set -euo pipefail

# Set default variable values
SCRIPT_VERSION="0.0.2"
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_FILE="$LOG_DIR/$(date +%Y%m%d-%H%M_setup_vm.log)"

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
  echo "  -h         -> Prints help"
  echo "  -v         -> Set VM name (required) [1-8 alphanumerical characters]"
  echo "Usage :"
  echo "  setup_vm.sh [-h|-v <vm-name>]"
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
while getopts "v:h" option; do
  case $option in
    h) # Display help page
       print_usage
       exit;;
    v) # Set desired VM name to be provisioned
       if [[ -z "${OPTARG}" ]]; then
        echo "Please provide a VM name."
        exit 1
       else
        VM_NAME=${OPTARG}
        validate_input $VM_NAME
        create_vm $VM_NAME
       fi;;
    \?) # Invalid option
       echo "Error : Invalid option"
       print_usage
       exit;;
  esac
done