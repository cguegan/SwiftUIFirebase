//
//  PasswordField.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
    }
}

#Preview {
    PasswordField(password: .constant("password"))
}
