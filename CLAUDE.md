# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
SwiftUI + Firebase iOS app template with authentication, notes management, and centralized alert system. Modern SwiftUI architecture using Observable pattern, async/await, theme support, and modular organization.

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
- **Navigation Module** (`Modules/Navigation/`): Root navigation, alerts, and authenticated state management
- **Settings Module** (`Modules/Settings/`): User profile, theme switching, and logout functionality

### Key Architectural Patterns
1. **MVVM with Observable**: Services act as ViewModels using `@Observable` macro
2. **Environment Injection**: Services injected via SwiftUI environment
3. **Async/Await**: All Firebase operations use modern Swift concurrency
4. **User-scoped Data**: Notes stored in Firestore subcollections (`users/{uid}/notes`)
5. **Centralized Alerts**: AlertService with WithAlertView wrapper
6. **Repository Pattern**: NoteRepo for data access abstraction

### Firebase Integration
- Configuration: `GoogleService-Info.plist` required (not in repo)
- Services: FirebaseAuth for authentication, Firestore for data persistence
- Initialization: `FirebaseApp.configure()` in `SwiftUIFirebaseApp.swift`

### State Management Flow
```
ContentView (auth router) -> AuthService (observable)
    ├── Not authenticated -> Login/Registration views
    └── Authenticated -> MainView -> NoteRepo (observable) -> Notes views
                              ├────> Settings (via menu) -> Logout action
                              └────> About (via menu sheet) -> App info display
```

## Important Implementation Details

### Authentication
- `AuthService` manages Firebase Auth state and operations
- Email validation via `String+EmailValidation` extension
- Password validation helper in `String+EmailValidation` extension
- Form validation in login/registration views
- User state persisted across app launches

### Notes Management
- `NoteRepo` handles Firestore CRUD operations
- Real-time updates via Firestore listeners with proper cleanup
- Each note has: id, title, content, createdAt, updatedAt
- Navigation uses SwiftUI's `NavigationStack` with value-based routing
- Error handling with FirebaseError enum
- Mock data support for previews and DEBUG mode

### UI Components
- Clean design with customizable themes (Light/Dark/System)
- Custom toolbar configurations in `MainView` with menu navigation
- Sheet presentations for note editing and about view
- Focus state management for form inputs
- Settings accessed via NavigationLink from menu
- Theme persistence using @AppStorage("colorScheme")
- WithAlertView wrapper for consistent alert presentation

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

### Recent Updates
- **Alert System**: Added centralized AlertService with WithAlertView wrapper
- **Theme Management**: Implemented theme switching (Light/Dark/System) with persistence
- **Settings Module**: Enhanced with segmented picker for theme selection
- **Repository Pattern**: Refactored NoteService to NoteRepo for better abstraction
- **Error Handling**: Improved with FirebaseError enum (Identifiable, Equatable)
- **UI Improvements**: Updated Settings to use Form layout, cleaner note editing sheets
- **Navigation**: AboutView moved to Navigation module, accessed via sheet
- **Code Organization**: Better separation of concerns with MARK comments

### Working with Firebase
- Always use async/await for Firebase operations
- Handle errors with `FirebaseError` enum
- Use subcollections for user-specific data
- Test with Firebase Emulator Suite when possible

### Preview & Mocks
- Mock data in `Preview Assets/Mocks/`
- Use `#if DEBUG` for preview-specific code
- Inject mock services for SwiftUI previews
- Note.mocks provides sample data for previews

## Troubleshooting & Common Issues

### Known Issues & Solutions

#### 1. App Delegate Warning
**Issue**: "App Delegate does not conform to UIApplicationDelegate protocol"
**Solution**: This is harmless in SwiftUI apps - Firebase works correctly without traditional AppDelegate

#### 2. Firestore Path Issues
**Issue**: Notes not scoped to user or update fails
**Solution**: Always use `dbCollection` computed property that includes user ID path

## Code Patterns & Best Practices

### Repository Pattern Example
```swift
@MainActor
@Observable
class RepoName {
    var data: [Model] = []
    var error: FirebaseError?
    private var listener: ListenerRegistration?
    
    private var db = Firestore.firestore()
    
    var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    
    var dbCollection: CollectionReference? {
        guard let userID = currentUserID else { return nil }
        return db.collection("users").document(userID).collection("collection_name")
    }
    
    func stopListening() {
        listener?.remove()
    }
}
```

### View with Environment Service
```swift
struct ViewName: View {
    @Environment(RepoName.self) private var repo
    
    var body: some View {
        // View content
    }
}
```

### Alert System Pattern
```swift
// In App
@State private var alertService = AlertService()

// In ContentView
WithAlertView {
    YourContent()
        .environment(alertService)
}

// In any view
@Environment(AlertService.self) private var alertService
alertService.showAlert(title: "Error", message: error.localizedDescription)
```

### Navigation Pattern
```swift
NavigationStack {
    ContentView()
        .toolbar {
            Menu {
                NavigationLink(destination: TargetView()) {
                    Label("Item", systemImage: "icon")
                }
            } label: {
                Label("Menu", systemImage: "ellipsis")
            }
        }
}
```

### Theme Management Pattern
```swift
// In Settings View
@AppStorage("colorScheme") private var colorScheme: String = "system"

Picker("Theme", selection: $colorScheme) {
    Text("System").tag("system")
    Text("Light").tag("light")
    Text("Dark").tag("dark")
}
.pickerStyle(.segmented)

// In ContentView
@AppStorage("colorScheme") private var colorScheme: String = "system"
.preferredColorScheme(colorSchemeFromString(colorScheme))
```

## File Naming Conventions
- Views: `FeatureNameView.swift`
- Services/Repos: `FeatureRepo.swift` or `FeatureService.swift`
- Models: `ModelName.swift`
- Extensions: `Type+Functionality.swift`
- Mocks: `Model+Mocks.swift`

## SwiftUI Best Practices
1. Use `@Environment` for dependency injection
2. Prefer `NavigationStack` over deprecated `NavigationView`
3. Use `@Observable` macro for services (iOS 17+)
4. Handle async operations with `.task` modifier
5. Use `@FocusState` for form field management
6. Apply `.sheet` and `.alert` modifiers at appropriate view levels

## Firebase Best Practices
1. Initialize Firebase in app's `init()` method
2. Use async/await for all Firebase operations
3. Implement proper error handling with custom error enums
4. Use Firestore listeners for real-time updates
5. Structure data with user subcollections for security
6. Never expose Firebase configuration in version control

## Security Considerations
1. Never commit `GoogleService-Info.plist` to repository
2. Use Firebase Security Rules for data access control
3. Validate user input on both client and server
4. Store sensitive data only in secure Firebase collections
5. Implement proper authentication state management
