//
//  SwiftUIFirebaseApp.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI
import Firebase


@main
struct SwiftUIFirebaseApp: App {
    
    @State private var noteService: NoteService
    
    init() {
        FirebaseApp.configure()
        
        /// Initialize services that need to be started after Firebase is configured
        _noteService = State(initialValue: NoteService())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(noteService)
        }
    }
}
