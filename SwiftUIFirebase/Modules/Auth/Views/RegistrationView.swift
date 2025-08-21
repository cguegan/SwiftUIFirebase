//
//  RegistrationView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthService.self) private var auth: AuthService
    
    @State private var email    = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case email
        case password
        case confirmPassword
    }

    var formIsValid: Bool {
        !email.isEmpty &&
        email.isValidEmail() &&
        password.count >= 6 &&
        password == confirmPassword
    }
    
    /// View Body
    var body: some View {
        VStack() {
            
            AppLogoView()
                .padding(.top, 100)
            
            Text("Sign Up")
                .font(.title)
                .bold()
                .padding(.bottom, 5)
            
            Text("Create a new account to get started")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 30)
            
            EmailField( placeholder: "Your email",
                        email: $email )
                .focused($focusedField, equals: .email)
            
            PasswordField(  placeholder:"Your password",
                            password: $password )
                .focused($focusedField, equals: .password)
            
            PasswordField( placeholder: "Confirm your password",
                           password: $confirmPassword )
                .focused($focusedField, equals: .confirmPassword)
            
            Button {
                signUp()
            } label: {
                AuthButtonLabel(text: "Sign Up")
            }
            .disabled(!formIsValid)
            .opacity(!formIsValid ? 0.5 : 1)
            
            Spacer()
            
            /// Sign Up Navigation Link
            Divider()
            Button { dismiss() } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                    Text("Login")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.blue)
                        .padding(.top, 8)
                }
            }
        }
        .onAppear {
            focusedField = .email
        }
    }
    
    
    /// Private Methods
    private func signUp() {
        Task { await auth.signUp( email: email,
                                  password: password ) }
    }
}


// MARK: - Preview
// —-—————————————

#Preview {
    RegistrationView()
        .environment(AuthService())
}
