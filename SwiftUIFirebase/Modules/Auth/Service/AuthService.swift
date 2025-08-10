//
//  AuthService.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import Foundation
import FirebaseAuth

@MainActor
@Observable
class AuthService {
    var user: User? = nil
    var status: SignInStatus = .unknown
    
    enum SignInStatus {
        case unknown
        case signedIn
        case signedOut
        case error(String)
    }

    init() {
        self.user = Auth.auth().currentUser
        self.status = user != nil ? .signedIn : .signedOut
    }

    func refreshUser() {
        if let currentUser = Auth.auth().currentUser {
            print("✅ Current user found: \(currentUser.email ?? "No email")")
            self.user = currentUser
            self.status = .signedIn
        } else {
            print("❌ No current user found")
            self.status = .signedOut
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.user = result.user
            self.status = .signedIn
        } catch {
            print("Sign Up Error: \(error.localizedDescription)")
            self.status = .error(error.localizedDescription)
        }
    }

    func signIn(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.user = result.user
            self.status = .signedIn
        } catch {
            print("Sign In Error: \(error.localizedDescription)")
            self.status = .error(error.localizedDescription)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.status = .signedOut
        } catch {
            print("Sign Out Error: \(error.localizedDescription)")
            self.status = .error(error.localizedDescription)
        }
    }
}
