#!/bin/bash

# Check if the number of arguments provided is correct
if [ "$#" -ne 2 ]; then
    echo "Error: Incorrect number of arguments provided."
    exit 1
fi

filesdir=$1
searchstr=$2

# Check if both arguments are provided
if [ -z "$filesdir" ] || [ -z "$searchstr" ]; then
    echo "Error: Both arguments must be specified."
    exit 1
fi

# Check if filesdir exists and is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a directory."
    exit 1
fi

# Find the number of files in filesdir and its subdirectories
num_files=$(find "$filesdir" -type f | wc -l)

# Find the number of matching lines in respective files
num_matching_lines=$(grep -r "$searchstr" "$filesdir" | wc -l)

# Print the results
echo "The number of files are $num_files and the number of matching lines are $num_matching_lines"

