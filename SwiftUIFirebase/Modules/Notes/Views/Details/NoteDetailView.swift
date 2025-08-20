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
        NoteDetailView(
            note: Note.mock(
                id: "preview-1",
                title: "Sample Note",
                content: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Suspendisse potenti. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
"""
            )
        )
    }
}
