#!/bin/bash

# Define variables
APP_NAME="AFVM"
INSTALL_DIR="/opt/$APP_NAME"
BIN_DIR="/usr/local/bin"
SYMLINK="$BIN_DIR/$APP_NAME"

# Function to check for root privileges
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root. Use sudo." >&2
        exit 1
    fi
}

# Function to remove the application
uninstall_application() {
    echo "Uninstalling $APP_NAME..."
    
    # Remove the installation directory
    if [ -d "$INSTALL_DIR" ]; then
        rm -rf "$INSTALL_DIR"
        echo "Removed $INSTALL_DIR"
    else
        echo "$INSTALL_DIR does not exist. Skipping."
    fi
    
    # Remove the symbolic link
    if [ -L "$SYMLINK" ]; then
        rm "$SYMLINK"
        echo "Removed symlink $SYMLINK"
    else
        echo "Symlink $SYMLINK does not exist. Skipping."
    fi
    
    echo "$APP_NAME has been uninstalled successfully."
}

# Main function
main() {
    check_root
    uninstall_application
}

# Execute main function
main
