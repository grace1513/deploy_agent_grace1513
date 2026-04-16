Attendance Tracker Project Generator

📌 Overview
This project is a Bash script that automates the creation of an Attendance Tracker workspace.
It validates user input and generates a structured project directory:
attendance_tracker_{input}

✨ Features
Interactive user input
Input validation (structure, repetition, vowel/consonant balance)
Automatic directory creation
Predefined project structure setup

📂 Project Structure
attendance_tracker_{input}/
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
   └── reports.log

⚙️ Usage
Run the script:
bash setup_project.sh

▶️ Example
Enter name: Grace

Valid name: Grace
Creating project: attendance_tracker_Grace

❌ Invalid Input Example
Enter name: fghjkl

Invalid name: must contain at least one vowel

🧠 Validation Rules
The input:
Must not be empty
Must contain only letters and spaces
Must include at least one vowel
Must not contain excessive repetition
Must follow a natural letter pattern

📦 Requirements
Bash (Linux / WSL / Unix)
Standard utilities: grep, tr, mkdir, cat

📌 Purpose
This project demonstrates:
Bash scripting
Input validation
File system automation
Project setup automation 
