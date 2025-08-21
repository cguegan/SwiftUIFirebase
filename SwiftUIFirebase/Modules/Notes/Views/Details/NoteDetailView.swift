//
//  NoteDetailView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct NoteDetailView: View {
    
    /// Given note to display
    var note: Note
    
    /// State to control the visibility of the edit sheet
    @State var showEditSheet: Bool = false
    
    /// Main Body
    var body: some View {
        ScrollView {
            Text(note.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(note.content)
                .font(.body)
                .padding()
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .navigationTitle(note.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showEditSheet.toggle()
                }) {
                    Image(systemName: "pencil")
                        .imageScale(.large)
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            NoteEditSheet(note: note)
        }
    }
}


// MARK: - Preview
// ———————————————

#Preview {
    NavigationStack {
        NoteDetailView(note: Note.mocks.first!)
    }
}
