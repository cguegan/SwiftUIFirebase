//
//  NoteEditSheet.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct NoteEditSheet: View {
    
    /// Environment variables to handle dismissal and note service
    @Environment(\.dismiss) private var dismiss
    @Environment(NoteRepo.self) private var noteService
    
    /// State property to hold the note being edited
    @State var note: Note = Note(title: "", content: "")
    
    /// Initialize with an optional note
    init(note: Note? = nil) {
        if let note = note {
            self._note = State(initialValue: note)
        }
    }
    
    /// Main View
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Title", text: $note.title)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                    
                    TextEditor( text: $note.content )
                    .multilineTextAlignment(.leading)
                    .frame(maxHeight: .infinity)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    
                }
                .padding()
                .navigationTitle(note.id == nil ? "New Note" : "Edit Note")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            if note.id == nil {
                                try? noteService.add(note)
                            } else {
                                try? noteService.update(note)
                            }
                            dismiss()
                        }
                    }
                }
            }
        }
        
    }
}


// MARK: - Preview
// ———————————————
#Preview {
    NoteEditSheet()
        .environment(NoteRepo())
}
