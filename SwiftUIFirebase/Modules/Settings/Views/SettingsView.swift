//
//  SettingsView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 20/08/2025.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    /// Environment property
    @Environment(AuthService.self) private var authService
    @Environment(\.colorScheme) private var systemColorScheme
    
    /// App information
    @State private var showLogoutConfirmation = false
    @AppStorage("colorScheme") private var colorScheme: String = "system"
    
    /// Main Body
    var body: some View {
        Form {
                
            // User Info Section
            if let user = authService.user {
                Section {
                    VStack(spacing: 8) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        
                        Text(user.email ?? "No email")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            // Appearance Section
            Section(header: Text("Appearance")) {
                Picker("Theme", selection: $colorScheme) {
                    Text("System").tag("system")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                .tint(.black)
                .pickerStyle(.segmented)
            }
            
            // Logout Button
            Button {
                showLogoutConfirmation = true
            } label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                    Text("Log Out")
                        .foregroundColor(.red)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
                
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Log Out",
               isPresented: $showLogoutConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Log Out", role: .destructive) {
                authService.signOut()
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
    }
    
}


// MARK: - Preview
// ———————————————

#Preview {
    NavigationStack {
        SettingsView()
            .environment(AuthService())
    }
}

