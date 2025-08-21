//
//  MainView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct MainView: View {
    @State private var showAbout = false
    
    /// Main View Body
    var body: some View {
        NavigationStack {   
            NotesListing()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            NavigationLink(destination: SettingsView()) {
                                Label("Settings", systemImage: "gear")
                            }
                            Button {
                                showAbout = true
                            } label: {
                                Label("About", systemImage: "info.circle")
                            }
                        } label: {
                            Label("Menu", systemImage: "ellipsis")
                        }
                    }
                }
                .sheet(isPresented: $showAbout) {
                    AboutView()
                }
        }
        
    }
}

// MARK: - Preview
// —-—————————————
#Preview {
    MainView()
}
