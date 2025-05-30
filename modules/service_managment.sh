#!/bin/bash

# Service Management Script
# Provides control over system services

source ./utilis/log.sh

list_services() {
    echo "==== System Services ===="
    systemctl list-units --type=service --no-pager
    log_action "Listed system services"
}

service_operation() {
    local operation=$1
    read -rp "Enter service name: " svc

    if ! systemctl is-enabled "$svc" >/dev/null 2>&1; then
        echo "Service $svc not found"
        log_error "Attempted $operation on non-existent service: $svc"
        return 1
    fi

    case $operation in
    start)
        if systemctl start "$svc"; then
            echo "Service $svc started successfully"
            log_action "Started service: $svc"
        else
            echo "Failed to start $svc"
            log_error "Failed to start service: $svc"
        fi
        ;;
    stop)
        if systemctl stop "$svc"; then
            echo "Service $svc stopped successfully"
            log_action "Stopped service: $svc"
        else
            echo "Failed to stop $svc"
            log_error "Failed to stop service: $svc"
        fi
        ;;
    restart)
        if systemctl restart "$svc"; then
            echo "Service $svc restarted successfully"
            log_action "Restarted service: $svc"
        else
            echo "Failed to restart $svc"
            log_error "Failed to restart service: $svc"
        fi
        ;;
    status)
        systemctl status "$svc"
        log_action "Checked status of service: $svc"
        ;;
    esac
}

main() {
    local options=("List Services" "Start Service" "Stop Service" "Restart Service" "Check Status" "Return to Main Menu")

    while true; do
        clear
        echo "==== Service Management ===="
        select opt in "${options[@]}"; do
            case $REPLY in
            1)
                list_services
                break
                ;;
            2)
                service_operation "start"
                break
                ;;
            3)
                service_operation "stop"
                break
                ;;
            4)
                service_operation "restart"
                break
                ;;
            5)
                service_operation "status"
                break
                ;;
            6) return 0 ;;
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
