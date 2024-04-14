#!/bin/sh
# Tester script for assignment 1 and assignment 2
# Author: Siddhant Jajoo


:<<COMMENT
# Directory where the script is located
SCRIPT_DIR=$(dirname "$0")

# Clean build artifacts
echo "Cleaning previous build artifacts..."
rm -f "${SCRIPT_DIR}/writer" "${SCRIPT_DIR}"/*.o

# Compile writer application using native compilation
echo "Compiling writer application..."
gcc -o "${SCRIPT_DIR}/writer" "${SCRIPT_DIR}/writer.c" -Wall

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

# Use the writer utility instead of writer.sh

# Assuming the usage of writer is "./writer <file> <string>"
# and you have paths or parameters for <file> and <string>

#FILE_PATH="/path/to/file.txt"
#WRITE_STRING="This is a test string"

# Replace calls to writer.sh with calls to the compiled writer application
#echo "Running writer to create ${FILE_PATH} with content: '${WRITE_STRING}'"
#"${SCRIPT_DIR}/writer" "${FILE_PATH}" "${WRITE_STRING}"
COMMENT

# Your existing logic for the finder-test.sh script continues here...

set -e
set -u

NUMFILES=10
WRITESTR=AELD_IS_FUN
WRITEDIR=/tmp/aeld-data
username=$(cat conf/username.txt)

if [ $# -lt 3 ]
then
	echo "Using default value ${WRITESTR} for string to write"
	if [ $# -lt 1 ]
	then
		echo "Using default value ${NUMFILES} for number of files to write"
	else
		NUMFILES=$1
	fi	
else
	NUMFILES=$1
	WRITESTR=$2
	WRITEDIR=/tmp/aeld-data/$3
fi

MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo "Writing ${NUMFILES} files containing string ${WRITESTR} to ${WRITEDIR}"

rm -rf "${WRITEDIR}"

# create $WRITEDIR if not assignment1
assignment=`cat ../conf/assignment.txt`

if [ $assignment != 'assignment1' ]
then
	mkdir -p "$WRITEDIR"

	#The WRITEDIR is in quotes because if the directory path consists of spaces, then variable substitution will consider it as multiple argument.
	#The quotes signify that the entire string in WRITEDIR is a single string.
	#This issue can also be resolved by using double square brackets i.e [[ ]] instead of using quotes.
	if [ -d "$WRITEDIR" ]
	then
		echo "$WRITEDIR created"
	else
		exit 1
	fi
fi
#echo "Removing the old writer utility and compiling as a native application"
#make clean
#make

for i in $( seq 1 $NUMFILES)
do
	./writer "$WRITEDIR/${username}$i.txt" "$WRITESTR"
done

OUTPUTSTRING=$(./finder.sh "$WRITEDIR" "$WRITESTR")

# remove temporary directories
rm -rf /tmp/aeld-data

set +e
echo ${OUTPUTSTRING} | grep "${MATCHSTR}"
if [ $? -eq 0 ]; then
	echo "success"
	exit 0
else
	echo "failed: expected  ${MATCHSTR} in ${OUTPUTSTRING} but instead found"
	exit 1
fi
