# SwiftUI + Firebase App

## Overview

This project is a modern and opinionated SwiftUI architecture scaffolding for applications that integrates with Firebase for backend services. It serves as a template for building iOS applications using modern SwiftUI practices and Firebase functionalities.

## Features

- 🔐 **Authentication**: Email/password authentication with Firebase Auth
- 📝 **Notes Management**: Create, read, update, and delete notes with Firestore
- 🏗️ **Modern Architecture**: Observable Service pattern with SwiftUI's Observable macro
- 🎨 **Beautiful UI**: Glass morphism effects and modern SwiftUI components
- 📱 **iOS 26.0+**: Built with the latest iOS APIs and SwiftUI features
- 🔄 **Firebase Sync**: Automatic data synchronization with Firestore

## Getting Started

### Prerequisites
- Xcode 16.0 or later (26.0 recommended)
- Swift 5.0 or later (Swift 6.0 recommended)
- Firebase account and project set up
- Swift Package Manager: [firebase-ios-sdk](https://github.com/firebase/firebase-ios-sdk) with the following dependencies:
    - FirebaseCore
    - FirebaseAuth
    - FirebaseFirestore

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd SwiftUIFirebase
   ```

2. **Open in Xcode**
   ```bash
   open SwiftUIFirebase.xcodeproj
   ```

3. **Configure Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add an iOS app to your Firebase project
   - Download `GoogleService-Info.plist`
   - Add the file to the project root (next to `SwiftUIFirebaseApp.swift`)
   - Enable Email/Password authentication in Firebase Console
   - Create a Firestore database

4. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd+R` or click the Run button

## Project Structure

```
SwiftUIFirebase/
├── App/                          # App configuration and entry point
│   ├── SwiftUIFirebaseApp.swift # Main app with Firebase setup
│   └── GoogleService-Info.plist # Firebase config (add your own)
├── Modules/                      # Feature modules
│   ├── Auth/                    # Authentication module
│   │   ├── Services/           # AuthService with Firebase Auth
│   │   └── Views/              # Login, Registration, UI components
│   ├── Navigation/              # App navigation
│   │   └── Views/              # ContentView, MainView
│   └── Notes/                   # Notes feature
│       ├── Models/              # Note data model
│       ├── Services/            # NoteService with Firestore
│       └── Views/               # Notes listing, detail, edit
├── Shared/                       # Shared code
│   └── Extensions/              # String extensions, utilities
└── Preview Assets/               # SwiftUI preview support
    └── Mocks/                    # Mock data for previews
```

## Architecture

### Design Patterns
- **MVVM with Observable**: Services Managers using `@Observable` macro
- **Dependency Injection**: Services injected through SwiftUI's environment
- **Modular Architecture**: Features organized in self-contained modules

### Data Flow
```
User Input → View → Service (Observable) → Firebase → Service → View Update
```

### Key Components

#### AuthService
- Manages user authentication state
- Handles login, registration, and logout
- Persists authentication across app launches

#### NoteService
- CRUD operations for notes
- Real-time synchronization with Firestore
- User-scoped data storage

## Usage

### Authentication
```swift
// Login
await authService.login(email: email, password: password)

// Register
await authService.register(email: email, password: password)

// Logout
authService.logout()
```

### Notes Management
```swift
// Create note
await noteService.createNote(title: title, content: content)

// Update note
await noteService.updateNote(note)

// Delete note
await noteService.deleteNote(note)
```

## Development

### Building
```bash
# Build from command line
xcodebuild -scheme SwiftUIFirebase build

# Or use Xcode
# Cmd+B to build
```

### Running
```bash
# Open in Xcode and run
open SwiftUIFirebase.xcodeproj
# Then Cmd+R to run
```

### Code Style
- Follow Swift API Design Guidelines
- Use SwiftUI's declarative syntax
- Leverage async/await for asynchronous operations
- Keep views simple and move logic to services

## Requirements

- iOS 26.0+
- Xcode 16.0+
- Swift 5.0+

## License

This project is available as a template for building iOS applications.

## Contributing

Feel free to submit issues and enhancement requests!

## Acknowledgments

- Built with [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- Powered by [Firebase](https://firebase.google.com/)
- Modern Swift concurrency with async/await
