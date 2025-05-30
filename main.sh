#!/bin/bash
# Main System Management Interface
# Provides menu navigation to all system management modules

# Load dependencies
source ./utilis/userInput.sh
source ./utilis/log.sh

# Configuration
MODULE_DIR="./modules"
LOGFILE="./log/system_admin.log"

# Ensure required directories exist
mkdir -p ./log

# Main menu options
menu_options=(
    "System Information"
    "User Management"
    "Process Management"
    "Network Management"
    "Service Management"
    "Update Management"
    "Log Management"
    "Backup Management"
    "Exit"
)

# Module mapping
module_map=(
    "system_information.sh"
    "user_managment.sh"
    "process_managment.sh"
    "network_managment.sh"
    "service_managment.sh"
    "update_managment.sh"
    "log_managment.sh"
    "backup_managment.sh"
)

# Main loop
while true; do
    clear
    echo "==== System Management Dashboard ===="
    menu "Main Menu" "${menu_options[@]}"

    read -rp "Enter your choice (0-$((${#menu_options[@]} - 1)): " choice

    # Validate input
    if [[ ! "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 0 ] || [ "$choice" -ge "${#menu_options[@]}" ]; then
        echo "Invalid selection. Please try again."
        sleep 2
        continue
    fi

    # Handle exit option
    if [ "$choice" -eq $((${#menu_options[@]} - 1)) ]; then
        echo "Exiting system..."
        exit 0
    fi

    # Launch selected module
    module="${module_map[$choice]}"
    if [ -f "$MODULE_DIR/$module" ]; then
        log_action "Accessed module: ${menu_options[$choice]}"
        bash "$MODULE_DIR/$module"
    else
        log_error "Module not found: $module"
        echo "Error: Module not available"
        sleep 2
    fi
done
