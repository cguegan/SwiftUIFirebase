//
//  AboutView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 20/08/2025.
//

import SwiftUI

struct AboutView: View {
    
    /// Environment property
    @Environment(\.dismiss) private var dismiss
    
    /// App information
    private let appName = "SwiftUIFirebase"
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    private let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    private let contactEmail = "support@swiftuifirebase.app"
    
    /// Main View Body
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    
                    // App Logo
                    VStack(spacing: 20) {
                        AppLogoView()
                            .scaleEffect(1.0)
                        
                        Text(appName)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 60)
                    
                    // Version Information
                    VStack(spacing: 8) {
                        Text("Version \(appVersion)")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("Build \(buildNumber)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // Description
                    Text("A modern SwiftUI template with Firebase integration for building iOS applications")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    // Contact Information
                    VStack(spacing: 20) {
                        Divider()
                            .padding(.horizontal, 40)
                        
                        VStack(spacing: 12) {
                            Text("Contact Us")
                                .font(.headline)
                            
                            Link(destination: URL(string: "mailto:\(contactEmail)")!) {
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(.blue)
                                    Text(contactEmail)
                                        .foregroundColor(.blue)
                                }
                                .font(.footnote)
                            }
                        }
                        
                        Text("© 2025 SwiftUIFirebase")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
// ———————————————
#Preview {
    AboutView()
}
