//
//  LoginView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AuthService.self) private var auth: AuthService
    
    @State private var email = ""
    @State private var password = ""
    
    var formIsValid: Bool {
        !email.isEmpty &&
        !password.isEmpty &&
        email.contains("@") &&
        password.count >= 6
    }
    
    /// View Body
    var body: some View {
        
        VStack() {
            
            Spacer()
            
            EmailField(email: $email)
            PasswordField(password: $password)
            
            Button {
                signIn()
            } label: {
                AuthButtonLabel(text: "Login")
            }
            .disabled(!formIsValid)
            .opacity(!formIsValid ? 0.5 : 1)
            
            Spacer()
            
            /// Sign Up Navigation Link
            Divider()
            NavigationLink {
                SignUpView().navigationBarBackButtonHidden(true)
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                    Text("Sign Up here")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .padding(.top, 8)
                }
            }
        }
    }
    
    /// Private Methods
    private func signIn() {
        Task { await auth.signIn(email: email, password: password) }
    }
}

#Preview {
    LoginView()
        .environment(AuthService())
}
