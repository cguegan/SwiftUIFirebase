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
    @AppStorage("preferredColorScheme") private var preferredColorScheme: String = "system"
    
    /// Main Body
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // User Info Section
                if let user = authService.user {
                    VStack(spacing: 8) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        
                        Text(user.email ?? "No email")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 40)
                }
                
                Spacer()
                
                // Settings Options
                VStack(spacing: 12) {
                    // Appearance Section
                    VStack(spacing: 0) {
                        HStack {
                            Label("Appearance", systemImage: "moon.circle")
                                .foregroundColor(.primary)
                            Spacer()
                            Picker("Theme", selection: $preferredColorScheme) {
                                Label("System", systemImage: "gear").tag("system")
                                Label("Light", systemImage: "sun.max").tag("light")
                                Label("Dark", systemImage: "moon").tag("dark")
                            }
                            .pickerStyle(.menu)
                            .tint(.blue)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    // Account Section
                    VStack(spacing: 0) {
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
                            .padding()
                            .background(Color(.systemBackground))
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Log Out", isPresented: $showLogoutConfirmation) {
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
