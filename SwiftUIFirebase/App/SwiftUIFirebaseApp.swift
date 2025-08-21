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
    
    @State private var noteService: NoteRepo
    @State private var alertService: AlertService
    
    init() {
        FirebaseApp.configure()
        
        /// Initialize services that need to be started after Firebase is configured
        _noteService = State(initialValue: NoteRepo())
        _alertService = State(initialValue: AlertService())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(noteService)
                .environment(alertService)
        }
    }
}
