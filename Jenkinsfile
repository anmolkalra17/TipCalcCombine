#!/bin/bash

# Function to display an error message and exit
function error_exit {
    echo "Error: $1"
    exit 1
}

# Check if the branch parameter is provided
if [ -z "$1" ]; then
    error_exit "Branch parameter not provided. Usage: $0 <branch_name>"
fi

# Set GitHub repo and token
repo_url="https://github.com/anmolkalra17/TipCalcCombine.git"
github_token="${GITHUB_TOKEN}"

# Check if GitHub token is provided
if [ -z "$github_token" ]; then
    error_exit "GitHub token not found. Set it as an environment variable in Jenkins."
fi

# Change to the desired branch
git checkout "$1" || error_exit "Failed to checkout branch $1"

# Set GitHub credentials
git config credential.helper 'cache --timeout=300'
git remote set-url origin "$repo_url" || error_exit "Failed to set remote URL"

# Clean environment
source ~/.bash_profile  # or any other script to set up your environment

# Invoke fastlane to clean
fastlane clean || error_exit "Failed to clean with fastlane"

# Code signing (if required)
# Uncomment the following lines if code signing is needed
fastlane ios adhoc || error_exit "Failed to sign the code"

# Build using gym command in fastlane
fastlane ios build || error_exit "Failed to build with fastlane"
