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

# ─────────────────────────────────────────────
# STEP 1: Install NVM (Node Version Manager)
# ─────────────────────────────────────────────
echo ">>> Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# Load NVM into the current shell session immediately (without needing to restart the terminal)
# NVM is shell-function based — without this, the script cannot find nvm immediately after installation.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ─────────────────────────────────────────────
# STEP 2: Install Node.js (NVM bundles NPM too)
# ─────────────────────────────────────────────
echo ">>> Installing Node.js 24..."
nvm install 24
nvm use 24

# Upgrade NPM to latest
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

echo ">>> Application started. PID: $!"
echo ">>> Done!"