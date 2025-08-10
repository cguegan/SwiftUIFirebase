# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
SwiftUI + Firebase iOS app template with authentication and notes management. Modern SwiftUI architecture using Observable pattern, async/await, and modular organization.

## Development Commands

### Build & Run
- **Build**: `Cmd+B` in Xcode or `xcodebuild -scheme SwiftUIFirebase build`
- **Run**: `Cmd+R` in Xcode or open `SwiftUIFirebase.xcodeproj` and run on simulator/device
- **Clean Build**: `Cmd+Shift+K` in Xcode or `xcodebuild -scheme SwiftUIFirebase clean`

### Testing
No test infrastructure currently exists. When implementing tests:
- Add test files to `SwiftUIFirebaseTests` target
- Run tests with `Cmd+U` in Xcode

### Code Quality
- **SwiftLint**: Not configured. Consider adding if needed
- **Format**: Use Xcode's built-in formatter (`Ctrl+I` for indentation)

## Architecture & Code Organization

### Module Structure
The app follows a **feature-based modular architecture**:
- **Auth Module** (`Modules/Auth/`): Firebase authentication with email/password
- **Notes Module** (`Modules/Notes/`): CRUD operations for notes using Firestore
- **Navigation Module** (`Modules/Navigation/`): Root navigation and authenticated state management

### Key Architectural Patterns
1. **MVVM with Observable**: Services act as ViewModels using `@Observable` macro
2. **Environment Injection**: Services injected via SwiftUI environment
3. **Async/Await**: All Firebase operations use modern Swift concurrency
4. **User-scoped Data**: Notes stored in Firestore subcollections (`users/{uid}/notes`)

### Firebase Integration
- Configuration: `GoogleService-Info.plist` required (not in repo)
- Services: FirebaseAuth for authentication, Firestore for data persistence
- Initialization: `FirebaseApp.configure()` in `SwiftUIFirebaseApp.swift`

### State Management Flow
```
ContentView (auth router) -> AuthService (observable)
    ├── Not authenticated -> Login/Registration views
    └── Authenticated -> MainView -> NoteService (observable) -> Notes views
```

## Important Implementation Details

### Authentication
- `AuthService` manages Firebase Auth state and operations
- Email validation via `String+EmailValidation` extension
- Form validation in login/registration views
- User state persisted across app launches

### Notes Management
- `NoteService` handles Firestore CRUD operations
- Real-time updates via Firestore listeners
- Each note has: id, title, content, createdAt, updatedAt
- Navigation uses SwiftUI's `NavigationStack` with value-based routing

### UI Components
- Glass effect backgrounds using `Material.ultraThin`
- Custom toolbar configurations in `MainView`
- Sheet presentations for note editing
- Focus state management for form inputs

## Development Requirements
- **Xcode**: 16.0+ (project uses iOS 26.0 deployment target)
- **Swift**: 5.0+ with Swift 6.0 features
- **Firebase Project**: Must be configured with your own `GoogleService-Info.plist`

## Common Tasks

### Adding New Features
1. Create module folder under `Modules/`
2. Add Model, Service (if needed), and Views subfolders
3. Inject service via environment if needed
4. Update `MainView` for navigation integration

### Working with Firebase
- Always use async/await for Firebase operations
- Handle errors with `FirebaseError` enum
- Use subcollections for user-specific data
- Test with Firebase Emulator Suite when possible

### Preview & Mocks
- Mock data in `Preview Assets/Mocks/`
- Use `#if DEBUG` for preview-specific code
- Inject mock services for SwiftUI previews