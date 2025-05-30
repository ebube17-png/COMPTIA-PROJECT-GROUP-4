#!/bin/bash

# Log Management Script
# Provides functionality to view and search system logs

source ./utilis/log.sh
source ./utilis/userInput.sh

# Configuration
LOG_LINES=20

view_logs() {
    echo "==== Recent System Logs ===="
    journalctl -n $LOG_LINES --no-pager
    log_action "Viewed recent system logs"
}

search_logs() {
    echo "==== Log Search ===="
    read -rp "Enter search pattern: " pattern
    if [ -z "$pattern" ]; then
        echo "Error: Search pattern cannot be empty"
        return 1
    fi

    echo "Searching logs for: $pattern"
    journalctl --no-pager | grep -i "$pattern"
    log_action "Searched logs for pattern: $pattern"
}

main() {
    local options=("View Recent Logs" "Search Logs" "Return to Main Menu")

    while true; do
        clear
        echo "==== Log Management ===="
        menu "Select Operation" "${options[@]}"
        read -rp "Enter your choice: " choice

        case "$choice" in
        0) view_logs ;;
        1) search_logs ;;
        2) return 0 ;;
        *)
            echo "Invalid option"
            continue
            ;;
        esac

        read -rp "Press Enter to continue..."
    done
}

main
