#!/bin/bash

#./findtestclasses.sh /path_to_your_folder
# Check if a folder path is provided as an argument
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

# Set the folder path from the command-line argument
folder_path="$1"

# Check if the provided path is a directory
if [ ! -d "$folder_path" ]; then
    echo "Error: '$folder_path' is not a valid directory."
    exit 1
fi

# Initialize an empty string to store file names
file_names=""

# Iterate over each file in the folder
for file in "$folder_path"/*
do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Check if the file contains the keyword "@isTest "
        if grep -q "@isTest " "$file"; then
            # Append the file name to the variable, separated by a comma
            file_names="${file_names}${file_names:+, }$(basename "$file")"
        fi
    fi
done

# Display the file names containing the keyword
if [ -n "$file_names" ]; then
    echo "$file_names"
else
    echo ""
fi
