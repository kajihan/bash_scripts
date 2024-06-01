#!/bin/bash

# Function to check the success of the last command
check_last_command() {
  if [ $? -ne 0 ]; then
    echo "Error: $1"
    exit 1
  fi
}

# Check if arguments were provided
if [ $# -eq 0 ]; then
  echo "Error: No packages specified for installation."
  echo "Usage: $0 package1 package2 ..."
  exit 1
fi

# Determine the distribution and version of the OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
  VERSION_ID=$VERSION_ID
else
  echo "Error: Could not determine the operating system."
  exit 1
fi

# Function to install packages on Ubuntu
install_ubuntu() {
  sudo apt-get update
  check_last_command "Failed to update package lists."
  for package in "$@"; do
    sudo apt-get install -y "$package"
    check_last_command "Failed to install package $package."
  done
}

# Function to install packages on CentOS
install_centos() {
  sudo yum update -y
  check_last_command "Failed to update package lists."
  for package in "$@"; do
    sudo yum install -y "$package"
    check_last_command "Failed to install package $package."
  done
}

# Install packages depending on the OS
case $OS in
  ubuntu)
    echo "Ubuntu system detected, version $VERSION_ID."
    install_ubuntu "$@"
    ;;
  centos)
    echo "CentOS system detected, version $VERSION_ID."
    install_centos "$@"
    ;;
  *)
    echo "Error: Unsupported operating system."
    exit 1
    ;;
esac

echo "Package installation completed successfully."
