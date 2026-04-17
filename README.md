📊 Attendance Tracker Project Generator

📜 Project Overview

The Attendance Tracker Project Generator is a Bash-based automation script designed to streamline the creation of a fully structured attendance tracking workspace.

This project demonstrates practical shell scripting by combining input validation, file system automation, and process handling into a single executable script. It eliminates repetitive manual setup and ensures consistency across all generated projects.

The script dynamically creates a project directory, organizes required resources, and prepares an environment ready for immediate use.

🗺️ Project Workflow (Execution Flow)

1. Input Acquisition

The script prompts the user to enter a project name.
Input is normalized (converted to lowercase)
Ensures consistency across generated directories

2. Validation Engine
   
User input is validated to ensure:
It is not empty
It follows acceptable naming conventions
It avoids invalid or problematic patterns
Invalid input is rejected and re-prompted.

3.Dynamic Project Generation

A new workspace is created using the format:
attendance_tracker_<name>/

4. Directory Structuring
The script automatically builds the required folder hierarchy:

```bash
attendance_tracker_<name>/
│
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
│
└── reports/
    └── reports.log
```

5. Resource Deployment

Pre-existing files are copied into the new structure:

attendance_checker.py
assets.csv
config.json
reports.log
This ensures the project is immediately functional after setup.

6. Configuration Layer

The user is prompted to optionally update system settings:
Do you want to update attendance thresholds? (y/n):
Input is standardized
Only valid responses are accepted

7. Signal & Process Control

The script includes interruption handling (Ctrl + C):

Gracefully terminates execution
Prevents incomplete or corrupted project setups

🛠️ Installation & Usage

To run this project, ensure your system meets the requirements:

Bash shell
Python 3

Clone the Repository
git clone <repository-url>
cd <repository-folder>

Make the Script Executable
chmod +x setup_project.sh

Execute the Script
./setup_project.sh

🧪 Example Execution
Enter name: school1
Valid name: school1
Creating project: attendance_tracker_school1
Do you want to update attendance thresholds? (y/n): y

🛡️ Engineering Practices

This project follows key scripting and software engineering principles:

Automation First: Eliminates repetitive manual setup tasks
Input Integrity: Ensures all user input is validated before processing
Structured Design: Maintains a consistent and logical file hierarchy
Error Handling: Manages invalid input and unexpected interruptions
Maintainability: Uses clear logic and readable scripting practices

📌 Final Note

The Attendance Tracker Project Generator reflects a practical approach to real-world automation using Bash scripting. It combines validation, structure, and system awareness to produce a reliable and reusable project setup tool.
