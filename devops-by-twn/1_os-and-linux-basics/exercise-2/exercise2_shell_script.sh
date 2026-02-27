#!/bin/bash

# Step 1: "Defensive Programming" Practices
# Avoids cases where scripts silently continue executing after a command fails.

# -e → Exit the entire script if any command returns a non-zero exit code (if any command fails).
# -u → Exit the entire script if you try to use an uninitialized variable (a variable that has not been set).
# -o pipefail → If any command in a pipeline fails, the entire pipeline will be considered to have failed, and the script will exit.

set -euo pipefail

echo "Updating installed packages..."
sudo apt update

echo "Installing Java..."
sudo apt install -y openjdk-21-jdk

# Exit with an error if Java is not installed successfully
if ! command -v java &>/dev/null; then
    echo "Error: Java installation failed." >&2
    exit 1
fi

# `2>&1` redirects error output into normal output. 
# This is necessary because java -version outputs the version information to standard error (stderr) instead of standard output (stdout).

# `head -n 1` takes only the first line.

# The awk -F '"' sets the field delimiter to a double-quote character.

# Example, if the output of `java -version` is:
# openjdk version "11.0.11" 2021-04-20

# Then the fields would be split as follows:
# - Field 1: Everything before the first double quote (e.g., "openjdk version ")
# - Field 2: The Java version string (e.g., "11.0.11")
# - Field 3: Everything after the second double quote (e.g., " 2021-04-20")
# By printing $2, we get just the Java version number without any additional text.

JAVA_VERSION=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')

# Guard against empty version string (e.g., unexpected output format).
if [[ -z "$JAVA_VERSION" ]]; then
    echo "Error: Could not determine installed Java version." >&2
    exit 1
fi

# Assert minimum version requirement is met.
JAVA_MAJOR=$(echo "$JAVA_VERSION" | cut -d'.' -f1)
if [[ "$JAVA_MAJOR" -lt 11 ]]; then
    echo "Error: Java 11 or higher is required. Found: $JAVA_MAJOR" >&2
    exit 1
fi

echo "Java version installed: $JAVA_VERSION"
