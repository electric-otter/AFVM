#!/bin/bash

# Define variables
APP_NAME="AFVM"
INSTALL_DIR="/opt/$APP_NAME"
BIN_DIR="/usr/local/bin"
SCRIPT_NAME="launch.sh"

# Function to check for root privileges
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root. Use sudo." >&2
        exit 1
    fi
}

# Function to install dependencies (example: curl, git)
install_dependencies() {
    echo "Installing dependencies..."
    apt update && apt install -y curl git
}

# Function to install the application
install_application() {
    echo "Installing $APP_NAME..."
    mkdir -p "$INSTALL_DIR"
    cp "$SCRIPT_NAME" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

    # Create a symlink to make it accessible system-wide
    ln -sf "$INSTALL_DIR/$SCRIPT_NAME" "$BIN_DIR/$APP_NAME"
}

# Function to clean up
cleanup() {
    echo "Cleaning up..."
    rm -rf "$INSTALL_DIR/temp_files"
}

# Function to display completion message
finish_installation() {
    echo "$APP_NAME installed successfully!"
    echo "You can now run it using '$APP_NAME'"
}

# Main function
main() {
    check_root
    install_dependencies
    install_application
    cleanup
    finish_installation
}

# Execute main function
main
