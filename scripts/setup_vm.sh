#!/bin/bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/helpers/logging.sh"

# Help section
print_usage() {
  # Display help
  echo "This script provisions a VM."
  echo
  echo "Available flags :"
  echo "  --help      -> Prints help"
  echo "  --vm-name   -> Set VM name (required)"
  echo "Usage :"
  echo "  var-cleanup.sh [--help|--vm-name <vm-name>]"
  echo
}

# Validate user input
validate_input() {
  
}