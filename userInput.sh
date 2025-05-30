#!/bin/bash
# User Input Utilities
# Provides standardized input and menu functions

# Prompt for user input with validation
input_prompt() {
    local prompt="$1"
    local validation_regex="$2"
    local error_msg="$3"
    local default_value="$4"

    while true; do
        read -rp "$prompt" input

        # Use default if input is empty and default provided
        if [ -z "$input" ] && [ -n "$default_value" ]; then
            echo "$default_value"
            return 0
        fi

        # Validate input if regex provided
        if [ -z "$validation_regex" ] || [[ "$input" =~ $validation_regex ]]; then
            echo "$input"
            return 0
        else
            echo "$error_msg" >&2
        fi
    done
}

# Display a formatted menu
menu() {
    local title="$1"
    shift
    local options=("$@")

    # Calculate maximum line length for border
    local max_length=$((${#title} + 4))
    for option in "${options[@]}"; do
        [ ${#option} -gt "$max_length" ] && max_length=${#option}
    done

    # Create border string
    border=$(printf '=%.0s' $(seq 1 $((max_length + 8))))

    # Display menu
    echo
    echo "$border"
    printf "%*s\n" $(((${#border} + ${#title}) / 2)) "$title"
    echo "$border"
    echo

    for index in "${!options[@]}"; do
        printf "%2d. %s\n" "$index" "${options[$index]}"
    done

    echo
    echo "$border"
    echo
}
