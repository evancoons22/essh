#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
CONFIG_FILE="$SCRIPT_DIR/servers.json"

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuration file '$CONFIG_FILE' not found."
  exit 1
fi

# Read server names and display with addresses
mapfile -t server_list < <(jq -r '.servers[] | "\(.name) (\(.address))"' "$CONFIG_FILE")

# Function to select an item (server or user)
select_item() {
  local prompt="$1"
  shift
  local items=("$@")

  printf '%s\n' "${items[@]}" | \
    fzf --ansi \
        --bind='ctrl-j:down,ctrl-k:up' \
        --header="Use Ctrl-j/Ctrl-k to navigate, Enter to select" \
        --prompt="$prompt" \
        --height=100% --layout=reverse
}

# Select a server
selected_server=$(select_item "Select a server: " "${server_list[@]}")

# Exit if no server is selected
if [ -z "$selected_server" ]; then
  echo "No server selected."
  exit 1
fi

# Extract the server name (everything before the first space)
server_name=$(echo "$selected_server" | awk '{print $1}')

# Get server details from the configuration file
server_info=$(jq -r --arg name "$server_name" '.servers[] | select(.name == $name)' "$CONFIG_FILE")
server_address=$(echo "$server_info" | jq -r '.address')
mapfile -t user_list < <(echo "$server_info" | jq -r '.users[]')

# Select a user
selected_user=$(select_item "Select a user: " "${user_list[@]}")

# Exit if no user is selected
if [ -z "$selected_user" ]; then
  echo "No user selected."
  exit 1
fi

# Confirm the SSH command
echo "Connecting to $server_name ($server_address) as $selected_user..."

ssh "$selected_user@$server_address"

