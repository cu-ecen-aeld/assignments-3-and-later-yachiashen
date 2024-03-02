#!/bin/bash

# Check if the number of arguments provided is correct
if [ $# -ne 2 ]; then
    echo "Error: Incorrect number of arguments provided."
    exit 1
fi

writefile=$1
writestr=$2

# Check if both arguments are provided
if [ -z "$writefile" ] || [ -z "$writestr" ]; then
    echo "Error: Both arguments must be specified."
    exit 1
fi

# Create the directory path if it doesn't exist
mkdir -p "$(dirname "$writefile")"

# Write the string to the file
echo "$writestr" > "$writefile"

# Check if the file was created successfully
if [ $? -ne 0 ]; then
    echo "Error: Failed to create the file."
    exit 1
fi

echo "File '$writefile' created successfully with content: '$writestr'"

