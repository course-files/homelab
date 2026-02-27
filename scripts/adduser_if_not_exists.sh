#!/bin/bash

# Step 1: "Defensive Programming" Practices
# Avoids cases where scripts silently continue executing after a command fails.

# -e → Exit the entire script if any command returns a non-zero exit code (if any command fails).
# -u → Exit the entire script if you try to use an uninitialized variable (a variable that has not been set).
# -o pipefail → If any command in a pipeline fails, the entire pipeline will be considered to have failed, and the script will exit.

set -euo pipefail

# Step 2: User Provisioning

USERNAME="$1"
USERGROUP="$2"

if ! id "$USERNAME" &>/dev/null; then
    sudo adduser "$USERNAME"
    sudo passwd --expire "$USERNAME" # Force password change on first login. More secure than setting a default password.
fi

# Add user to a group if it exists
if getent group "$USERGROUP" &>/dev/null; then
    sudo usermod -aG "$USERGROUP" "$USERNAME"
else
    echo "Warning: Group '$USERGROUP' does not exist. Skipping group assignment."
fi