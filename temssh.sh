#!/bin/bash

if [ ! -f ~/.config/temshh.conf ]; then
  echo "Configuration file not found, create new file..."
  echo "Config file is created ~/.config/temssh.conf"
  echo "declare -A SSH_CONFIGS" > ~/.config/temshh.conf
fi

source ~/.config/temshh.conf

configure_ssh() {
  echo "Add new servers"
  echo -n "Server name: "
  read server_name
  echo -n "Host/IP addreas: "
  read SSH_HOST
  echo -n "Port (optional): "
  read SSH_PORT
  echo -n "Username: "
  read SSH_USER
  if [ -z "$SSH_PORT"];then
    SSH_CONFIGS[$server_name]="$SSH_USER@$SSH_HOST"
  else
    SSH_CONFIGS[$server_name]="$SSH_USER@$SSH_HOST -p $SSH_PORT"
  fi
  echo "declare -A SSH_CONFIGS" > ~/.config/temshh.conf
  for key in "${!SSH_CONFIGS[@]}"; do
    echo "SSH_CONFIGS[$key]='${SSH_CONFIGS[$key]}'" >> ~/.config/temshh.conf
  done
  echo "Config saved!."
}

show_config() {
  echo "List SSH config:"
  for server in "${!SSH_CONFIGS[@]}"; do
    echo "Server: $server"
    echo "Config: ${SSH_CONFIGS[$server]}"
  done
}

connect_ssh() {
  echo "Available server:"
  for server in "${!SSH_CONFIGS[@]}"; do
    echo $server
  done
  echo -n "Select servers: "
  read server_name
  if [[ ! ${SSH_CONFIGS[$server_name]+_} ]]; then
    echo "Server Not found."
  else
    echo "Connecting to ${SSH_CONFIGS[$server_name]}..."
    echo -n "Are you sure you want to connect? (y/n): "
    read confirm
    if [ $confirm == "y" ]; then
      ssh ${SSH_CONFIGS[$server_name]}
    else
      echo "Cancel connect."
    fi
  fi
}

delete_server() {
  echo "Available server:"
  for server in "${!SSH_CONFIGS[@]}"; do
    echo $server
  done
  echo -n "Select the server you want to delete: "
  read server_name
  if [[ ! ${SSH_CONFIGS[$server_name]+_} ]]; then
    echo "Server not found."
  else
    unset SSH_CONFIGS[$server_name]
    echo "declare -A SSH_CONFIGS" > ~/.config/temshh.conf
    for key in "${!SSH_CONFIGS[@]}"; do
      echo "SSH_CONFIGS[$key]='${SSH_CONFIGS[$key]}'" >> ~/.config/temshh.conf
    done
    echo "Server deleted successfully."
  fi
}

while true; do
  echo "Select an option:"
  echo "1. Setting SSH configuration"
  echo "2. Show SSH configuration"
  echo "3. Connect to SSH"
  echo "4. Delete server"
  echo "5. Exit"
  read -p "Enter choice (1/2/3/4/5): " choice
  case $choice in
    1) configure_ssh;;
    2) show_config;;
    3) connect_ssh;;
    4) delete_server;;
    5) break;;
  esac
done
