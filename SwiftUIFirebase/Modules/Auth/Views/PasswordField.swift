//
//  PasswordField.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct PasswordField: View {
    
    var placeholder: String = "Password"
    @Binding var password: String
    
    var body: some View {
        SecureField(placeholder, text: $password)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
    }
}

#Preview {
    PasswordField(password: .constant("password"))
}
