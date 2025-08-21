//  LoginView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AuthService.self) private var auth: AuthService
    
    @State private var email    = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case email
        case password
    }

    var formIsValid: Bool {
        !email.isEmpty &&
        email.isValidEmail() &&
        password.count >= 6
    }
    
    /// View Body
    var body: some View {
        NavigationStack {
            VStack() {
                
                AppLogoView()
                    .padding(.top, 100)
                
                Text("Login")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 5)
                
                Text("Please enter your credentials to continue")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 30)
                
                EmailField( placeholder:"Your email",
                            email: $email )
                    .focused($focusedField, equals: .email)
                
                PasswordField( placeholder: "Your password",
                               password: $password )
                    .focused($focusedField, equals: .password)
                
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
                    RegistrationView().navigationBarBackButtonHidden(true)
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
            .onAppear {
                focusedField = .email
            }
        }
    }
    
    /// Private Methods
    private func signIn() {
        Task { await auth.signIn(email: email, password: password) }
    }
}


// MARK: - Preview
// —-—————————————

#Preview {
    LoginView()
        .environment(AuthService())
}
