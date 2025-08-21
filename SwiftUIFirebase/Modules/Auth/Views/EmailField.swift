//
//  EmailField.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct EmailField: View {
    
    var placeholder: String = "Email"
    @Binding var email: String
    
    /// Main View Body
    var body: some View {
        TextField(placeholder, text: $email)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
    }
}


// MARK: - Preview
// —-—————————————

#Preview {
    EmailField(email: .constant("test@test.com"))
}
