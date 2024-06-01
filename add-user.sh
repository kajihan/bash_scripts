#!/bin/bash

# Function to check the successful execution of the last command
check_last_command() {
  if [ $? -ne 0 ]; then
    echo "Error: $1"
    exit 1
  fi
}

# Request username
while true; do
  read -p "Enter username: " username
  if [[ -z "$username" ]]; then
    echo "Username cannot be empty. Please try again."
  elif id -u "$username" >/dev/null 2>&1; then
    echo "User with the name '$username' already exists. Please choose another name."
  else
    break
  fi
done

# Request password
while true; do
  read -s -p "Enter password: " password
  echo
  read -s -p "Confirm password: " password_confirm
  echo
  if [[ -z "$password" ]]; then
    echo "Password cannot be empty. Please try again."
  elif [[ "$password" != "$password_confirm" ]]; then
    echo "Passwords do not match. Please try again."
  else
    break
  fi
done

# Create user
sudo useradd -m "$username"
check_last_command "Failed to create user."

# Set password
echo "$username:$password" | sudo chpasswd
check_last_command "Failed to set password."

echo "User '$username' successfully created."
