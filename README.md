
📊 Attendance Tracker Project Generator
📜 Project Overview

The Attendance Tracker Project Generator is a Bash-based automation script designed to streamline the creation of a fully structured attendance tracking workspace.

This project demonstrates practical shell scripting by combining input validation, file system automation, and process handling into a single executable script. It eliminates repetitive manual setup and ensures consistency across all generated projects.

The script dynamically creates a project directory, organizes required resources, and prepares an environment ready for immediate use.

🗺️ Project Workflow (Execution Flow)
🔹 1. Input Acquisition

The script prompts the user to enter a project name.

Input is normalized (converted to lowercase)
Ensures consistency across generated directories
🔹 2. Validation Engine

User input is validated to ensure:

It is not empty
It follows acceptable naming conventions
It avoids invalid or problematic patterns

Invalid input is rejected and the user is prompted again.

🔹 3. Dynamic Project Generation

A new workspace is created using the format:
attendance_tracker_<name>/

🔹 4. Directory Structuring

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
🔹 5. Resource Deployment

Pre-existing files are copied into the new structure:

attendance_checker.py
assets.csv
config.json
reports.log





