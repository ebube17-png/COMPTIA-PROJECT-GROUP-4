#!/bin/bash

# System Information Script
# Displays comprehensive system details

source ./utilis/log.sh

show_system_info() {
    echo "==== System Information ===="

    echo -e "\nOS Version:"
    if [ -f /etc/os-release ]; then
        grep PRETTY_NAME /etc/os-release | cut -d'"' -f2
    else
        lsb_release -d | cut -f2- 2>/dev/null || echo "Not available"
    fi

    echo -e "\nKernel Version:"
    uname -r

    echo -e "\nCPU Info:"
    lscpu | grep -E 'Model name|Socket|Core|Thread|MHz' | sed 's/^[ \t]*//'

    echo -e "\nMemory Usage:"
    free -h

    echo -e "\nDisk Usage:"
    df -h

    echo -e "\nUptime:"
    uptime

    log_action "Viewed system information"
}

main() {
    while true; do
        clear
        show_system_info

        read -rp $'\nPress "q" to quit or any other key to refresh: ' -n 1 key
        if [[ $key == "q" ]]; then
            break
        fi
    done
}

main
