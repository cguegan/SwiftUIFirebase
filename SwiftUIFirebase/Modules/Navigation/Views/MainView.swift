//
//  MainView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {   
            NotesListing()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            Button("Settings") {
                                // Action for settings
                            }
                            Button("About") {
                                // Action for about
                            }
                        } label: {
                            Label("Menu", systemImage: "ellipsis")
                        }
                    }
                }
        }
        
    }
}

#Preview {
    MainView()
}
