#!/bin/bash

# Backup Management Script
# Provides functionality to create and restore system backups

source ./utilis/log.sh
source ./utilis/userInput.sh

# Configuration
BACKUP_DIR="/var/backups"
TIMESTAMP=$(date +%F_%H-%M-%S)

validate_directory() {
    if [ ! -d "$1" ]; then
        log_error "Directory does not exist: $1"
        return 1
    fi
    return 0
}

create_backup() {
    echo "==== Create Backup ===="
    while true; do
        read -rp "Enter directory to backup: " src
        validate_directory "$src" && break
    done

    while true; do
        read -rp "Enter destination (default: $BACKUP_DIR): " dst
        dst=${dst:-$BACKUP_DIR}
        validate_directory "$dst" && break
    done

    backup_file="$dst/backup_$TIMESTAMP.tar.gz"

    if tar -czf "$backup_file" "$src"; then
        log_action "Created backup: $backup_file"
        echo "Backup created successfully: $backup_file"
    else
        log_error "Failed to create backup of $src"
        return 1
    fi
}

restore_backup() {
    echo "==== Restore Backup ===="
    while true; do
        read -rp "Enter backup file path: " backup
        if [ -f "$backup" ]; then
            break
        else
            log_error "Backup file not found: $backup"
        fi
    done

    while true; do
        read -rp "Enter restore destination: " dst
        validate_directory "$dst" && break
    done

    if tar -xzf "$backup" -C "$dst"; then
        log_action "Restored backup: $backup to $dst"
        echo "Restore completed successfully"
    else
        log_error "Failed to restore backup from $backup"
        return 1
    fi
}

main() {
    local options=("Create Backup" "Restore Backup" "Return to Main Menu")

    while true; do
        clear
        echo "==== Backup Management ===="
        menu "Select Operation" "${options[@]}"
        read -rp "Enter your choice: " choice

        case "$choice" in
        0) create_backup ;;
        1) restore_backup ;;
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
