//
//  AppLogoView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct AppLogoView: View {
    
    var color: Color = .black
    
    /// View Body
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(color)
                .frame(width: 140, height: 140)
                .shadow(color: .black.opacity(0.3), radius: 5)
                .shadow(color: color.opacity(0.2), radius: 15)
                .glassEffect(.identity)

            Image(systemName: "eraser")
                .resizable()
                .fontWeight(.light)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .foregroundStyle(.white)
                .padding()
                .padding()
        }
    }
}


// MARK: - Preview
// —-—————————————

#Preview {
    AppLogoView()
}
