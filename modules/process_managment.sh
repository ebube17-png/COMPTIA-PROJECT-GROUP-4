#!/bin/bash

# Process Manager
# Enhanced process viewer and management tool

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PROCESS_LIMIT=15
LOG_FILE="/var/log/process_mgr.log"

# Log actions
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

display_header() {
    clear
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${BLUE}             PROCESS MANAGER                ${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}\n"
}

list_processes() {
    display_header
    
    echo -e "${GREEN}Sort processes by:${NC}"
    echo "  1) CPU Usage"
    echo "  2) Memory Usage"
    echo "  3) Process Name Search"
    echo "  4) Show All Processes"
    read -rp "Select option [1-4]: " choice

    case $choice in
        1)
            echo -e "\n${YELLOW}Top $PROCESS_LIMIT processes by CPU usage:${NC}"
            ps -eo pid,user,%cpu,%mem,cmd --sort=-%cpu | head -n $((PROCESS_LIMIT+1)) | column -t
            ;;
        2)
            echo -e "\n${YELLOW}Top $PROCESS_LIMIT processes by Memory usage:${NC}"
            ps -eo pid,user,%mem,%cpu,cmd --sort=-%mem | head -n $((PROCESS_LIMIT+1)) | column -t
            ;;
        3)
            read -rp "Enter process name to search: " proc_name
            echo -e "\n${YELLOW}Matching processes:${NC}"
            pgrep -fl "$proc_name" | head -n $PROCESS_LIMIT || echo -e "${RED}No matching processes found${NC}"
            ;;
        4)
            echo -e "\n${YELLOW}All running processes:${NC}"
            ps -ef | head -n $PROCESS_LIMIT
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            return 1
            ;;
    esac

    log "Process list viewed (option $choice)"
}

manage_process() {
    display_header
    
    echo -e "${GREEN}Process Management Options:${NC}"
    echo "  1) Kill by PID"
    echo "  2) Kill by Name"
    echo "  3) Change Priority"
    echo "  4) Return"
    read -rp "Select option [1-4]: " choice

    case $choice in
        1)
            read -rp "Enter PID to kill: " pid
            if ps -p "$pid" >/dev/null; then
                echo -e "\n${YELLOW}Process Details:${NC}"
                ps -fp "$pid"
                if read -rp $'\nKill this process? (y/n): ' confirm && [[ $confirm =~ ^[Yy]$ ]]; then
                    kill "$pid" && echo -e "${GREEN}Process killed${NC}" || echo -e "${RED}Failed to kill process${NC}"
                    log "Process $pid killed"
                fi
            else
                echo -e "${RED}Invalid PID or process not found${NC}"
            fi
            ;;
        2)
            read -rp "Enter process name to kill: " proc_name
            pids=$(pgrep "$proc_name")
            if [ -z "$pids" ]; then
                echo -e "${RED}No matching processes found${NC}"
                return
            fi
            
            echo -e "\n${YELLOW}Matching Processes:${NC}"
            pgrep -fl "$proc_name"
            
            if read -rp $'\nKill all matching processes? (y/n): ' confirm && [[ $confirm =~ ^[Yy]$ ]]; then
                pkill "$proc_name" && echo -e "${GREEN}Processes killed${NC}" || echo -e "${RED}Failed to kill processes${NC}"
                log "All $proc_name processes killed"
            fi
            ;;
        3)
            read -rp "Enter PID to renice: " pid
            if ps -p "$pid" >/dev/null; then
                current_priority=$(ps -o ni= -p "$pid")
                echo -e "\nCurrent priority: $current_priority (lower is higher priority)"
                read -rp "Enter new priority (-20 to 19): " new_pri
                if [[ $new_pri =~ ^-?[0-9]+$ ]] && [ $new_pri -ge -20 ] && [ $new_pri -le 19 ]; then
                    renice $new_pri -p "$pid" && echo -e "${GREEN}Priority changed${NC}" || echo -e "${RED}Failed to change priority${NC}"
                    log "Process $pid priority changed to $new_pri"
                else
                    echo -e "${RED}Invalid priority value${NC}"
                fi
            else
                echo -e "${RED}Invalid PID or process not found${NC}"
            fi
            ;;
        4)
            return
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac
}

main_menu() {
    while true; do
        display_header
        
        echo -e "${GREEN}Main Menu:${NC}"
        echo "  1) View Processes"
        echo "  2) Manage Processes"
        echo "  3) Exit"
        echo -e "${BLUE}════════════════════════════════════════════${NC}"
        read -rp "Select option [1-3]: " choice

        case $choice in
            1) list_processes ;;
            2) manage_process ;;
            3) break ;;
            *) echo -e "${RED}Invalid option${NC}" ;;
        esac
        
        read -rp $'\nPress Enter to continue...'
    done
}

main_menu
