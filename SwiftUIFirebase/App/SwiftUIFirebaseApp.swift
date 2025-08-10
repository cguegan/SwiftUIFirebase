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
    
    init() {
        FirebaseApp.configure()
        

    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
