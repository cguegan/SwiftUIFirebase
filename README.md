# SwiftUI + Firebase App

## Overview

This project is a modern and opinionated SwiftUI architecture scaffolding for applications that integrates with Firebase for backend services. It serves as a template for building iOS applications using modern SwiftUI practices and Firebase functionalities.

## Features

- 🔐 **Authentication**: Email/password authentication with Firebase Auth
- 📝 **Notes Management**: Create, read, update, and delete notes with Firestore
- ⚙️ **Settings Module**: User profile display, theme switching, and logout functionality
- 🚨 **Alert System**: Centralized alert management with AlertService
- 🌓 **Theme Support**: Light/Dark/System theme modes with persistence
- 🏗️ **Modern Architecture**: Observable pattern with SwiftUI's @Observable macro
- 🎨 **Beautiful UI**: Clean design with customizable themes
- 📱 **iOS 17.0+**: Built with the latest iOS APIs and SwiftUI features
- 🔄 **Real-time Sync**: Automatic data synchronization with Firestore listeners

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
│   │   ├── Services/           # AlertService for app-wide alerts
│   │   └── Views/              # ContentView, MainView, AboutView
│   ├── Notes/                   # Notes feature
│   │   ├── Models/              # Note data model
│   │   ├── Repository/          # NoteRepo with Firestore operations
│   │   └── Views/               # Notes listing, detail, edit sheets
│   └── Settings/                # Settings module
│       └── Views/               # SettingsView with theme toggle and logout
├── Shared/                       # Shared code
│   ├── Enums/                   # FirebaseError enum with Identifiable
│   └── Extensions/              # String extensions (email validation)
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
- Error state management

#### NoteRepo
- CRUD operations for notes with Firestore
- Real-time synchronization via listeners
- User-scoped data storage (users/{uid}/notes)
- Error handling with FirebaseError

#### AlertService
- Centralized alert management system
- Observable service for app-wide alerts
- WithAlertView wrapper for consistent UI
- Automatic error display handling

## Usage

### Authentication
```swift
// Login
await authService.signIn(email: email, password: password)

// Register
await authService.signUp(email: email, password: password)

// Logout
authService.signOut()
```

### Notes Management
```swift
// Add note
noteRepo.add(note)

// Update note
noteRepo.update(note)

// Delete note
await noteRepo.delete(note)
```

### Alert System
```swift
// Show alert from anywhere
alertService.showAlert(title: "Error", message: "Something went wrong")

// Wrap views with alert support
WithAlertView {
    YourContentView()
}
```

### Theme Management
```swift
// Access theme preference
@AppStorage("colorScheme") private var colorScheme: String = "system"

// Apply theme
.preferredColorScheme(colorSchemeFromString(colorScheme))
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
