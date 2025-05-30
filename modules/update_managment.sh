#!/bin/bash

# System Update Manager
# Handles package updates and maintenance

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="/var/log/update_mgr.log"

# Log actions
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

display_header() {
    clear
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${BLUE}           SYSTEM UPDATE MANAGER            ${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}\n"
}

check_updates() {
    display_header
    echo -e "${GREEN}Checking for available updates...${NC}\n"
    
    if ! sudo apt update >/dev/null 2>&1; then
        echo -e "${RED}Failed to update package lists${NC}"
        log "Update check failed"
        return 1
    fi

    updates=$(apt list --upgradable 2>/dev/null | wc -l)
    if [ "$updates" -le 1 ]; then
        echo -e "${GREEN}✓ System is up to date${NC}"
    else
        echo -e "${YELLOW}Available updates:${NC}"
        apt list --upgradable 2>/dev/null | sed 's/^/  /'
        echo -e "\n${GREEN}Total packages to update: $((updates-1))${NC}"
    fi

    log "Update check completed"
}

apply_updates() {
    display_header
    echo -e "${YELLOW}Applying system updates...${NC}\n"
    
    if ! confirm_action "Proceed with system update?"; then
        echo -e "${GREEN}Update canceled${NC}"
        return
    fi

    echo -e "${GREEN}Upgrading packages...${NC}"
    if sudo apt upgrade -y; then
        echo -e "\n${GREEN}✓ Updates applied successfully${NC}"
        log "System updates applied"
    else
        echo -e "\n${RED}✗ Failed to apply updates${NC}"
        log "Update application failed"
    fi
}

system_cleanup() {
    display_header
    echo -e "${GREEN}System Cleanup Options:${NC}\n"
    echo "  1) Remove unused packages"
    echo "  2) Clean package cache"
    echo "  3) Remove old kernels"
    echo "  4) Return"
    read -rp "Select option [1-4]: " choice

    case $choice in
        1)
            echo -e "\n${YELLOW}Removing unused packages...${NC}"
            sudo apt autoremove -y
            echo -e "${GREEN}✓ Cleanup complete${NC}"
            log "Unused packages removed"
            ;;
        2)
            echo -e "\n${YELLOW}Cleaning package cache...${NC}"
            sudo apt clean
            echo -e "${GREEN}✓ Cache cleaned${NC}"
            log "Package cache cleaned"
            ;;
        3)
            echo -e "\n${YELLOW}Removing old kernels...${NC}"
            sudo apt purge $(dpkg -l | grep '^rc' | awk '{print $2}')
            echo -e "${GREEN}✓ Old kernels removed${NC}"
            log "Old kernels purged"
            ;;
        4)
            return
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac
}

confirm_action() {
    read -rp "$1 (y/n): " choice
    [[ $choice =~ ^[Yy]$ ]]
}

main_menu() {
    while true; do
        display_header
        
        echo -e "${GREEN}Main Menu:${NC}"
        echo "  1) Check for Updates"
        echo "  2) Apply Updates"
        echo "  3) System Cleanup"
        echo "  4) Exit"
        echo -e "${BLUE}════════════════════════════════════════════${NC}"
        read -rp "Select option [1-4]: " choice

        case $choice in
            1) check_updates ;;
            2) apply_updates ;;
            3) system_cleanup ;;
            4) break ;;
            *) echo -e "${RED}Invalid option${NC}" ;;
        esac
        
        read -rp $'\nPress Enter to continue...'
    done
}

main_menu
