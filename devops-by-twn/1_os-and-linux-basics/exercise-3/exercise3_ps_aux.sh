#!/bin/bash
# Step 1: "Defensive Programming" Practices
# Avoids cases where scripts silently continue executing after a command fails.
# -e → Exit the entire script if any command returns a non-zero exit code
#       (if any command fails).
# -u → Exit the entire script if you try to use an uninitialized variable
#       (a variable that has not been set).
# -o pipefail → If any command in a pipeline fails, the entire pipeline
#       will be considered to have failed, and the script will exit.
set -euo pipefail

# Step 2: Configuration
# Maximum number of lookups allowed per session (to avoid indefinite looping).
MAX_ITERATIONS=10
ITERATION=0
# Log file path for auditing user lookups and actions
LOG_FILE="/var/log/process_viewer.log"

SCRIPT_USER=$(whoami)

# Step 3: Verify the script is running in an interactive terminal.
# -t 0 checks if the file descriptor 0 (standard input) is a terminal.
# If it is not, the script is being run non-interactively (e.g., from a cron
# job or pipeline) and should exit immediately to avoid hanging indefinitely.
if ! [ -t 0 ]; then
    echo "Error: This script must be run in an interactive terminal."
    exit 1
fi

# Step 4: Verify the log file is writable before entering the loop.
# This avoids a situation where the script runs successfully but silently
# fails to write audit logs.
if ! touch "$LOG_FILE" &>/dev/null; then
    echo "Error: Cannot write to log file at '$LOG_FILE'."
    echo "Please run the script with sufficient permissions (e.g., sudo)."
    exit 1
fi

# Step 5: Helper function to write structured audit log entries.
log_event() {
    local EVENT="$1"
    local TARGET_USER="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | OPERATOR=$SCRIPT_USER | EVENT=$EVENT | TARGET_USER=$TARGET_USER" >> "$LOG_FILE"
}

log_event "SESSION_START" "N/A"

while true; do

    # Step 6: Enforce the maximum iteration limit.
    # Prevents indefinite looping.
    if [ "$ITERATION" -ge "$MAX_ITERATIONS" ]; then
        echo "Maximum number of lookups ($MAX_ITERATIONS) reached. Exiting."
        log_event "SESSION_LIMIT_REACHED" "N/A"
        exit 0
    fi

    ITERATION=$((ITERATION + 1))
    echo ""
    echo "Lookup $ITERATION of $MAX_ITERATIONS"

    # Step 7: Identify the user whose processes we want to list.
    read -p "Please enter the username: " USERNAME || { echo "Input interrupted. Exiting."; log_event "INPUT_INTERRUPTED" "N/A"; exit 1; }
    echo "Username received: $USERNAME"

    # Step 8: Check if the user exists.
    if ! id "$USERNAME" &>/dev/null; then
        echo "Error: User '$USERNAME' does not exist."
        echo "Defaulting to current user."
        log_event "USER_NOT_FOUND" "$USERNAME"
        USERNAME=$(whoami)
    fi

    echo ""
    echo "Listing processes for the following user: $USERNAME"
    read -p "Press 'q' to quit or any other key to continue: " CONTINUE || { echo "Input interrupted. Exiting."; log_event "INPUT_INTERRUPTED" "$USERNAME"; exit 1; }

    # Step 9: List the processes for the specified user in a paginated format.
    if ! [ "$CONTINUE" = "q" ]; then
        log_event "PROCESSES_VIEWED" "$USERNAME"
        # 'true' prevents the script from exiting with a non-zero exit code
        # Alternative to:
        # ps aux | grep aomondi | less || true
        # or
        # ps aux | grep $(whoami) | less || true
        # if the user presses 'q' to quit the "less" pager.
        ps -u "$USERNAME" -f | less || true
    else
        echo "Exiting the script."
        log_event "SESSION_END" "$USERNAME"
        exit 0
    fi

done
