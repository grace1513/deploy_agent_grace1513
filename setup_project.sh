#!/usr/bin/env bash

#Ask user for input

echo "Enter project name:" 
read input


# Parent directory

BASE_DIR="attendance_tracker_${input}"

echo "Enter project name:" 
read input

# Create directories


mkdir -p "attendance_tracker_$input/Helpers" 
mkdir -p "attendance_tracker_$input/reports"


# Copy files into structure


cp attendance_checker.py “$BASE_DIR/attendance_checker.py"
cp  assets.csv  “$BASE_DIR/Helpers/assets.csv"
cp  config.json “$BASE_DIR/Helpers/config.json”
cp  reports.log  “$BASE_DIR/reports/reports.log"


# Trap function for Ctrl+C

trap cleanup SIGINT

cleanup() {
    echo " Interrupted!"

    tar -czf "${BASE_DIR}_archive.tar.gz" "$BASE_DIR" 2>/dev/null
    rm -rf "$BASE_DIR"

    echo "Cleaned and archived."
    exit 1
}

trap cleanup SIGINT


#Ask the user if they want to update attendance

read -p "Do you want to update attendance thresholds? (y/n): " choice

if [[ "$choice" =~ ^[yY]$ ]]; then
    read -p "Enter Warning threshold (%): " warn
    read -p "Enter Failure threshold (%): " fail

# Validate input (numbers only)

    if ! [[ "$warn" =~ ^[0-9]+$ && "$fail" =~ ^[0-9]+$ ]]; then
        echo " Invalid input. Please enter numbers only."
        exit 1
    fi

    # Logical validation
    if (( warn <= fail )); then
        echo " Warning threshold must be greater than failure threshold."
        exit 1
    fi

    # Backup before editing 

    cp "$BASE_DIR/Helpers/config.json" "$BASE_DIR/Helpers/config_backup.json"

    # Update config.json

    sed -i "s/\"warning\": *[0-9]*/\"warning\": $warn/" "$BASE_DIR/Helpers/config.json"
    sed -i "s/\"failure\": *[0-9]*/\"failure\": $fail/" "$BASE_DIR/Helpers/config.json"

    echo "Thresholds updated successfully."
else
    echo " Keeping default thresholds."
fi


# Environment validation

echo "Checking Python installation..."

if command -v python3 &>/dev/null; then
    echo "Python3 is installed."
else
    echo "Python3 is NOT installed."
    exit 1
fi
