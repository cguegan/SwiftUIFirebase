//
//  NoteDetailView.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct NoteDetailView: View {
    
    var note: Note
    @State var showEditSheet: Bool = false
    
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
            
            Spacer()
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

#Preview {
    NavigationStack {
        NoteDetailView(
            note: Note(
                id: "1",
                title: "Sample Note",
                content: "This is a sample note content.",
                createdAt: Date(),
                updatedAt: Date()
            )
        )
    }
}
