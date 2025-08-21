//
//  ContentView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var authManager = AuthService()
    @AppStorage("colorScheme") private var colorScheme: String = "system"

    var body: some View {
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
                Text("Error: \(string)")
            }
        }
        .environment(authManager)
        .task {
            authManager.refreshUser()
        }
        .preferredColorScheme(colorSchemeFromString(colorScheme))
    }
    
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

#Preview {
    ContentView()
}
