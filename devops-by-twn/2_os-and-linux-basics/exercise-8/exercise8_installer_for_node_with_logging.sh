#!/bin/bash
# -e → Exit if any command fails
# -u → Exit if an uninitialized variable is used
# -o pipefail → Exit if any command in a pipeline fails
# set -euo pipefail

# ─────────────────────────────────────────────
# PARAMETER VALIDATION
# ─────────────────────────────────────────────
# Ensure the script receives exactly one argument
if [ "$#" -ne 1 ]; then
    echo "ERROR: Missing required parameter."
    echo "Usage: $0 <log_directory>"
    exit 1
fi

LOG_DIR_INPUT="$1"

# ─────────────────────────────────────────────
# STEP 0: Resolve or create the log directory
# ─────────────────────────────────────────────
if [ -d "$LOG_DIR_INPUT" ]; then
    # Directory already exists — resolve its absolute path
    echo ">>> Log directory already exists: $LOG_DIR_INPUT"
    export LOG_DIR="$(realpath "$LOG_DIR_INPUT")"
else
    # Directory does not exist — create it
    echo ">>> Log directory does not exist. Creating: $LOG_DIR_INPUT"
    mkdir -p "$LOG_DIR_INPUT"
    export LOG_DIR="$(realpath "$LOG_DIR_INPUT")"
fi

echo ">>> LOG_DIR set to: $LOG_DIR"

# ─────────────────────────────────────────────
# STEP 1: Install NVM (Node Version Manager)
# ─────────────────────────────────────────────
echo ">>> Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# Load NVM into the current shell session immediately
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ─────────────────────────────────────────────
# STEP 2: Install Node.js (NVM bundles NPM too)
# ─────────────────────────────────────────────
echo ">>> Installing Node.js 24..."
nvm install 24
nvm use 24

npm install -g npm@latest

echo ">>> Node version: $(node -v)"
echo ">>> NPM version:  $(npm -v)"

# ─────────────────────────────────────────────
# STEP 3: Download the artifact
# ─────────────────────────────────────────────
ARTIFACT_URL="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
ARTIFACT_FILE="bootcamp-node-envvars-project-1.0.0.tgz"

echo ">>> Downloading artifact..."
curl -fsSL "$ARTIFACT_URL" -o "$ARTIFACT_FILE"

# ─────────────────────────────────────────────
# STEP 4: Unzip the downloaded file
# ─────────────────────────────────────────────
echo ">>> Extracting artifact..."
tar -xzf "$ARTIFACT_FILE"

# ─────────────────────────────────────────────
# STEP 5: Set required environment variables
# ─────────────────────────────────────────────
echo ">>> Setting environment variables..."
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret
# LOG_DIR is already exported above

# ─────────────────────────────────────────────
# STEP 6: Change into the application directory
# ─────────────────────────────────────────────
# The .tgz typically extracts into a folder called "package"
APP_DIR="package"
echo ">>> Changing into directory: $APP_DIR"
cd "$APP_DIR"

# ─────────────────────────────────────────────
# STEP 7: Install dependencies and run the app
# ─────────────────────────────────────────────
echo ">>> Installing application dependencies..."
npm install

# The & runs the process in the background, thus freeing the terminal
echo ">>> Starting Node.js application in background..."
node server.js &
APP_PID=$!

# Default value prevents set -u from killing the script if port is not found
APP_PORT="unknown"

# Poll until the port appears (up to 10 seconds)
for i in $(seq 1 10); do
    APP_PORT=$(ss -tlnp | grep "pid=$APP_PID," | awk '{print $4}' | awk -F: '{print $NF}')
    if [ -n "$APP_PORT" ]; then
        break
    fi
    sleep 1
done

echo ">>> Application started."
echo ">>> PID:  $APP_PID"
echo ">>> Port: $APP_PORT"
echo ">>> LOG_DIR: $LOG_DIR"
echo ">>> Logging into: $LOG_DIR/app.log"
echo ">>> Done!"