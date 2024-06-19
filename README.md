# 🎉 Farewell Party Management System

Welcome to the **Farewell Party Management System** project! This comprehensive platform is tailored to help junior students organize a memorable farewell event for their seniors, with participation from teachers and their families.

## 📑 Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [System Requirements](#system-requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Database Schema](#database-schema)
- [Contributing](#contributing)
- [License](#license)

## 🌟 Introduction

The Farewell Party Management System simplifies event planning by offering functionalities like attendee management, task assignments, budget tracking, and detailed planning for dinner, stage performances, decorations, and venue arrangements.

## ✨ Features

- **Student Registration/Login**: Register and log in to participate in the farewell party.
- **Menu Suggestions**: Suggest and vote for dinner menu items.
- **Performance Volunteer**: Propose and vote for stage performances.
- **Teachers and Family Registration**: Register teachers and their families for the event.
- **Task Assignment**: Assign and track tasks related to event organization.
- **Attendance Tracking**: Monitor attendance of students, teachers, and their families.
- **Budget Tracking**: Track and manage the event budget.

## 🛠 Technologies Used

- **Front End**: HTML, CSS, JavaScript (optional), Bootstrap (optional)
- **Back End**: NodeJS, MySQL

## 💻 System Requirements

- NodeJS
- MySQL
- Any modern web browser

## 🚀 Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/farewell-party-management.git
    cd farewell-party-management
    ```

2. **Install NodeJS dependencies**:
    ```bash
    npm install express
    ```

3. **Set up MySQL database**:
    - Import the provided SQL file (`databaseSQL.sql`) into your MySQL server.
    - run all the tables and insert the data

4. **Run the application**:
    ```bash
    node JsFile.js
    ```

## 📖 Usage

1. **Register/Login**: Students and teachers can register and log in.
2. **Menu Suggestions**: Suggest and vote for menu items.
3. **Performance Proposals**: Propose and vote for performances.
4. **Task Management**: Assign and track tasks for event preparations.
5. **Budget Tracking**: Monitor the event budget and expenses.

## 📊 Database Schema

The database schema includes the following tables:

- **Students**: Stores student details.
- **Teachers**: Stores teacher details.
- **FamilyMembers**: Stores details of family members.
- **MenuItems**: Stores dinner menu suggestions.
- **Performances**: Stores performance proposals.
- **Tasks**: Stores task assignments.
- **Attendance**: Tracks attendance of all participants.
- **Budget**: Tracks event budget and expenses.

## 🤝 Contributing

We welcome contributions to improve this project. Please fork the repository and create a pull request with your changes. Ensure your code follows the project's coding guidelines.

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
