#!/usr/bin/env bash

# Ask user for input
read -p "Enter name: " input

# Trim spaces
input=$(echo "$input" | xargs)

name="$input"

# ======================
# 1. BASIC VALIDATION
# ======================

if [[ -z "$name" ]]; then
    echo " Invalid name: name cannot be empty."
    exit 1
fi

if ! [[ "$name" =~ ^[a-zA-Z[:space:]]+$ ]]; then
    echo " Invalid name: only letters are allowed."
    exit 1
fi

clean_name=$(echo "$name" | tr -d ' ')
length=${#clean_name}

if (( length < 2 )); then
    echo " Invalid name: too short."
    exit 1
fi

if echo "$clean_name" | grep -E "(.)\1{4,}" >/dev/null; then
    echo " Invalid name: too many repeated characters."
    exit 1
fi

if ! echo "$clean_name" | grep -iq '[aeiou]'; then
    echo " Invalid name: must contain at least one vowel."
    exit 1
fi

# ======================
# 2. ANALYSIS ENGINE
# ======================

vowels=$(echo "$clean_name" | grep -o -i '[aeiou]' | wc -l)
consonants=$(echo "$clean_name" | grep -o -i '[bcdfghjklmnpqrstvwxyz]' | wc -l)

issues=()

# Vowel density check
vowel_ratio=$(( vowels * 100 / length ))
if (( vowel_ratio < 30 )); then
    issues+=("low vowel density")
fi

# Consonant dominance
if (( consonants > vowels * 3 )); then
    issues+=("too many consonants compared to vowels")
fi

# Repetition patterns
if echo "$clean_name" | grep -Eiq '[aeiou]{3}'; then
    issues+=("too many consecutive vowels")
fi

if echo "$clean_name" | grep -Eiq '[bcdfghjklmnpqrstvwxyz]{3}'; then
    issues+=("too many consecutive consonants")
fi

# Structure randomness check
switches=$(echo "$clean_name" | grep -o -i '[aeiou][bcdfghjklmnpqrstvwxyz]\|[bcdfghjklmnpqrstvwxyz][aeiou]' | wc -l)

if (( switches < length / 3 )); then
    issues+=("unnatural letter structure")
fi

# ======================
# 3. FINAL DECISION
# ======================

if (( ${#issues[@]} > 0 )); then
    echo " Invalid name: ${issues[*]}"
    exit 1
fi

echo " Valid name: $name"

# ======================
# 4. PROJECT CREATION (THIS IS THE PART YOU WANTED)
# ======================

# SAFE NAME GENERATION (for folder safety)
safe_name="${name// /_}"


# Define BASE_DIR FIRST

BASE_DIR="attendance_tracker_${input}"

echo "Creating project: $BASE_DIR"

# Create main directory

mkdir -p "$BASE_DIR"

# Create subdirectories

mkdir -p "$BASE_DIR/Helpers"
mkdir -p "$BASE_DIR/reports"

# Copy files into structure

cat attendance_checker.py > "$BASE_DIR/attendance_checker.py"
cat assets.csv > "$BASE_DIR/Helpers/assets.csv"
cat config.json > "$BASE_DIR/Helpers/config.json"
cat reports.log > "$BASE_DIR/reports/reports.log"

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

# Ask the user if they want to update attendance
read -p "Do you want to update attendance thresholds? (y/n): " choice

# Normalize input
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]' | xargs)

if [[ "$choice" == "y" || "$choice" == "yes" ]]; then

    # Ask for warning threshold
    read -p "Enter Warning threshold (%): " warn
    read -p "Enter Failure threshold (%): " fail

    # Remove spaces
    warn=$(echo "$warn" | tr -d ' ')
    fail=$(echo "$fail" | tr -d ' ')

    # Remove % sign if user adds it
    warn=${warn%\%}
    fail=${fail%\%}

    # Check empty input
    if [[ -z "$warn" || -z "$fail" ]]; then
        echo " Error: Threshold values cannot be empty."
        exit 1
    fi

    # Check numeric (only integers)
    if ! [[ "$warn" =~ ^[0-9]+$ && "$fail" =~ ^[0-9]+$ ]]; then
        echo " Invalid input: Please enter whole numbers only (e.g. 80, 50)."
        exit 1
    fi

    # Range validation (0–100)
    if (( warn < 0 || warn > 100 || fail < 0 || fail > 100 )); then
        echo " Invalid range: Values must be between 0 and 100."
        exit 1
    fi

    # Logical validation
    if (( warn <= fail )); then
        echo " Warning threshold must be GREATER than failure threshold."
        exit 1
    fi

    # Backup config
    if [[ -f "$BASE_DIR/Helpers/config.json" ]]; then
        cp "$BASE_DIR/Helpers/config.json" "$BASE_DIR/Helpers/config_backup.json"
    else
        echo " Error: config.json not found."
        exit 1
    fi

    # Update config safely
    sed -i "s/\"warning\"[[:space:]]*:[[:space:]]*[0-9]\+/\"warning\": $warn/" \
        "$BASE_DIR/Helpers/config.json"

    sed -i "s/\"failure\"[[:space:]]*:[[:space:]]*[0-9]\+/\"failure\": $fail/" \
        "$BASE_DIR/Helpers/config.json"

    echo " Thresholds updated successfully."

elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
    echo " Keeping previous attendance thresholds."

else
    echo " Invalid input. Please enter 'y' or 'n'."
    exit 1
fi

# Environment validation

echo "Checking Python installation..."

if command -v python3 &>/dev/null; then
echo " Python3 is installed and ready to roll "
else
echo " Python3 is NOT installed."
exit 1
fi



