# Euro2024App

**Euro2024App** is an iOS application developed for the UEFA European Football Championship. It allows users to view match details, team statistics, and player information. It is built with SwiftUI and Firebase, showcasing a modern software architecture.

---

## 🎯 Purpose
This project is designed to showcase iOS application development and the effective use of modern backend technologies like Firebase. **Euro2024App** provides a user-friendly interface and a robust data infrastructure to demonstrate the skills required to build a sports-themed application.

---

## 🚀 Technical Features
- **Dynamic Interfaces with SwiftUI:** User-friendly and modern design.
- **Firebase Integration:**
  - Real-time database (Firestore).
  - User authentication (Firebase Authentication).
- **Data Management with JSON:** Storage and usage of team, match, and player data in JSON format.
- **Modular Structure with Xcode:** Each feature is managed with separate modules (e.g., Teams, Players, User Profile).
- **Custom Components:**
  - Keyboard management with `DismissingKeyboard Modifier`.
  - Custom input fields with `CustomFields`.

---

## 📦 Content
1. **Players and Teams:**
   - Detailed profiles of players and teams.
2. **Match Details:**
   - Dates, scores, and event details.
3. **Firebase Usage:**
   - Database operations and secure user authentication.
4. **JSON Files:**
   - `euro2024_matches.json`, `euro2024_teams.json`, `euro2024_players.json`, `euro2024_events.json`.

---

## 💼 Scope
This project is designed to demonstrate expertise in modern mobile application development with a focus on:

iOS development using best practices and modern tools.
Seamless backend integration with Firebase for real-time data management and authentication.
Efficient handling and processing of structured data using JSON files.


---

## 🛠️ Development Environment
- **Language:** Swift
- **IDE:** Xcode
- **Dependencies:**
  - Firebase SDK
  - SwiftUI Framework

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


---

## 📂 Project Structure
```
Euro2024App/
├── Assets/
│   ├── Images/           # Player and team images
│   └── JSON/             # Preloaded data for matches, teams, and players
├── Firebase/
│   ├── FirebaseManager.swift # Firebase integration logic
├── App/
│   ├── Views/            # SwiftUI views for the user interface
│   ├── Models/           # Data models for matches, teams, and players
│   └── ViewModels/       # Logic for connecting models and views
```
---

## 🔒 Data Privacy and Security

User data security is a priority in Euro2024App. Here are the measures implemented:

Secure Authentication: Firebase Authentication ensures secure user sign-in with email and password.

Real-Time Database Rules: Firestore is configured with strict rules to prevent unauthorized access.

Data Encryption: All communication with Firebase is encrypted using HTTPS.

Ensure your Firebase rules are properly configured for maximum security. For example:

  ```json
    {
    "rules": {
    "users": {
      "$uid": {
        ".read": "auth != null && auth.uid == $uid",
        ".write": "auth != null && auth.uid == $uid"
      }
    }
    }
    }
```

---

## 📲 Installation
Follow these steps to set up and run the project:

1. Clone the Repository

git clone https://github.com/erturkeryavuz/Euro2024App.git
cd Euro2024App

2. Configure Firebase

Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.

Download the GoogleService-Info.plist file from the Firebase settings for your project.

Add the GoogleService-Info.plist file to the root directory of your Xcode project.

3. Install Dependencies

Ensure you have Xcode and CocoaPods installed:

sudo gem install cocoapods
pod install

Open the .xcworkspace file in Xcode:

open Euro2024App.xcworkspace

4. Run the Application

Select a simulator or a connected device in Xcode, then click the Run button or use the shortcut Cmd+R.

---

## 📧 Contact

If you have any questions or suggestions about this project, feel free to reach out:

- **GitHub**: [@erturkeryavuz](https://github.com/erturkeryavuz)
- **Email**: [erturkeryavuz@gmail.com](mailto:erturkeryavuz@gmail.com)
- **LinkedIn**: [Ertürk Eryavuz](https://www.linkedin.com/in/ertürk-eryavuz-083b76282)
