#!/bin/bash

# Check if an argument is provided
if [ $# -ne 1 ]; then
  echo "Error: You need to provide exactly one argument."
  echo "Usage: $0 number"
  exit 1
fi

# Check if the argument is a number
if ! [[ $1 =~ ^[0-9]+$ ]]; then
  echo "Error: The argument should be a positive integer."
  exit 1
fi

# Countdown
time=$1
while [ $time -gt 0 ]; do
  echo "Seconds left: $time"
  sleep 1
  time=$((time - 1))
done

echo "Time's up!"
