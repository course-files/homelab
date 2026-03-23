#!/bin/bash

# Configuration
NEW_USER="myapp"
PORT=3000

echo ">>> Starting uninstallation process..."

# 1. Terminate the Node.js process
echo ">>> Checking for running Node.js processes..."
# Kill by port first to ensure the port is freed
PORT_PID=$(netstat -ltnp | grep ":$PORT" | awk '{print $7}' | cut -d'/' -f1 || echo "")

if [ -n "$PORT_PID" ]; then
    echo ">>> Killing process $PORT_PID on port $PORT..."
    kill -9 "$PORT_PID"
else
    echo ">>> No process found on port $PORT."
fi

# 2. Remove the application user and their home directory
# This deletes the downloaded .tgz and the /package folder automatically
if id "$NEW_USER" &>/dev/null; then
    echo ">>> Removing user '$NEW_USER' and all application files in home directory..."
    userdel -r "$NEW_USER"
else
    echo ">>> User '$NEW_USER' does not exist."
fi

# 3. Clean up the Log Directory
echo -n "Enter the absolute path of the log directory to delete: "
read LOG_DIRECTORY

if [ -d "$LOG_DIRECTORY" ]; then
    echo ">>> Deleting log directory: $LOG_DIRECTORY"
    rm -rf "$LOG_DIRECTORY"
else
    echo ">>> Log directory $LOG_DIRECTORY not found."
fi

# 4. Optional: Remove system packages
echo -n "Do you want to uninstall nodejs, npm, and net-tools? (y/n): "
read UNINSTALL_TOOLS
if [ "$UNINSTALL_TOOLS" = "y" ]; then
    echo ">>> Uninstalling packages..."
    apt purge -y nodejs npm net-tools
    apt autoremove -y
fi

echo ""
echo "################"
echo "Uninstallation complete. System is clean."
echo "################"