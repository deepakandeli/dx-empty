#!/bin/bash

# Check if a folder name is provided as an argument
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

# Set the folder name from the command-line argument
folder_name="$1"

# Set the temporary location
temp_location="changed-sources-svmxc"

# Ensure the temporary location exists
mkdir -p "$temp_location"

# Change to the Git repository root directory
cd "$(git rev-parse --show-toplevel)"

# Get the list of files changed between the current HEAD and HEAD-1 in the specified folder
IFS=$'\n' # Set Internal Field Separator to newline to handle file names with spaces
changed_files=($(git diff --name-only HEAD HEAD~1 -- "$folder_name"))

# Copy the changed files to the temporary location
for file in "${changed_files[@]}"; do
    cp "$file" "$temp_location/"
done

echo "Changed files from folder '$folder_name' copied to $temp_location"