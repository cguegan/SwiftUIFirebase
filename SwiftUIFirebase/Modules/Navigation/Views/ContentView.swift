//
//  ContentView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AlertService.self) private var alertService
    
    @State private var authManager = AuthService()
    @AppStorage("colorScheme") private var colorScheme: String = "system"
    
    /// Main View Body
    var body: some View {
        WithAlertView {
            Group {
                switch authManager.status {
                case .unknown:
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                case .signedIn:
                    MainView()
                case .signedOut:
                    LoginView()
                case .error(let string):
                    LoginView()
                        .onAppear() {
                            alertService.showAlert( title: "Login Error",
                                                    message: string )
                        }
                }
            }
            .environment(authManager)
            .task {
                authManager.refreshUser()
            }
            .preferredColorScheme(colorSchemeFromString(colorScheme))
        }
    }
}

// MARK: - Methods
// ———————————————
extension ContentView {
    
    private func colorSchemeFromString(_ scheme: String) -> ColorScheme? {
        switch scheme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil // System default
        }
    }
    
}

// MARK: - Preview
// ———————————————
#Preview {
    ContentView()
        .environment(AlertService())
}
