#!/bin/bash

# Function to remove node_modules and clear cache for both npm and Yarn
clear_cache() {
    # Remove node_modules directory if it exists
    [ -d "node_modules" ] && rm -rf node_modules

    # Clear Yarn cache
    yarn cache clean

    # Clear npm cache
    npm cache clean --force
}

# Clear caches and node_modules before timing Yarn install
clear_cache
start=$(date +%s.%N)
yarn install
end=$(date +%s.%N)
runtime=$(echo "$end - $start" | bc)

# Save the installation time for Yarn
echo "Yarn install time: $runtime seconds"

# Clear caches and node_modules before timing npm install
clear_cache
start_npm=$(date +%s.%N)
npm install
end_npm=$(date +%s.%N)
runtime_npm=$(echo "$end_npm - $start_npm" | bc)

# Save the installation time for npm
echo "npm install time: $runtime_npm seconds"

# Compare the installation times
difference=$(echo "$runtime - $runtime_npm" | bc)
if (( $(echo "$difference < 0" | bc -l) )); then
    echo "Yarn is faster by ${difference#-} seconds"
else
    echo "npm is faster by $difference seconds"
fi
