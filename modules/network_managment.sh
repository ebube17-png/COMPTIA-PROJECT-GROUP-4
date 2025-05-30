#!/bin/bash

# Network Management Script
# Provides network information and diagnostics

source ./utilis/log.sh

# Configuration
INTERFACE="eth0"

get_network_info() {
    echo "==== Network Information ===="
    echo -e "\nIP Configuration:"
    ip -br a

    echo -e "\nRouting Table:"
    ip route

    echo -e "\nActive Connections:"
    ss -tulnp

    log_action "Viewed network information"
}

test_connectivity() {
    echo "==== Network Test ===="
    read -rp "Enter host to test (default: 8.8.8.8): " host
    host=${host:-8.8.8.8}

    if ping -c 4 "$host"; then
        echo "Connectivity test successful"
    else
        echo "Connectivity test failed"
    fi

    log_action "Performed connectivity test to $host"
}

main() {
    local options=("Show Network Info" "Test Connectivity" "Return to Main Menu")

    while true; do
        clear
        echo "==== Network Management ===="
        select opt in "${options[@]}"; do
            case $REPLY in
            1)
                get_network_info
                break
                ;;
            2)
                test_connectivity
                break
                ;;
            3) return 0 ;;
            *)
                echo "Invalid option"
                continue
                ;;
            esac
        done

        read -rp "Press Enter to continue..."
    done
}

main
