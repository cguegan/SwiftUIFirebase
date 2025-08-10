//
//  AuthButtonLabel.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct AuthButtonLabel: View {
    
    var text: String = "Login"
    
    var body: some View {
        HStack {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
            Image(systemName: "arrow.right")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(Color.primary)
        .cornerRadius(8)
        .padding()
    }
}

#Preview {
    AuthButtonLabel()
}
