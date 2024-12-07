#!/bin/bash -e

if [ "$#" -lt 2 ]; then
    cat <<-ENDOFMESSAGE
Please specify a writable working directory and output file as arguments.
Usage: ./run.sh <working directory> <output file> [OPTION]
ENDOFMESSAGE
    exit 1
fi  # This closes the 'if' block

mkdir -p "$1"
mkdir -p "$(dirname "$2")"
blogbench -d "$1" "${@:3}" | tee "$2"

echo "Clean working directory..."
rm -rf "$1"
echo "done."

