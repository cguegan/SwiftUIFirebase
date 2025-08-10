//
//  MainView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {   
            NotesListing()
        }
    }
}

#Preview {
    MainView()
}
