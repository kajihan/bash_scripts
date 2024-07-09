#!/bin/bash

# Function to get the OS version
get_os_version() {
    grep 'PRETTY_NAME' /etc/os-release | cut -d '=' -f2 | tr -d '"'
}

# Function to get users with bash shell installed
get_users_with_bash() {
    awk -F: '/\/bin\/bash/ {print $1}' /etc/passwd | paste -sd ', '
}

# Function to get open ports
get_open_ports() {
    ss -tuln | tail -n +2
}

# Display information in a readable format with colors and bold text
bold=$(tput bold)
cyan='\033[36m'
reset='\033[0m'

echo -e "${bold}${cyan}OS version:${reset}"
echo "$(get_os_version)"
echo
echo -e "${bold}${cyan}Users with bash shell installed:${reset}"
echo "$(get_users_with_bash)"
echo
echo -e "${bold}${cyan}Open ports: ${reset}"
get_open_ports
