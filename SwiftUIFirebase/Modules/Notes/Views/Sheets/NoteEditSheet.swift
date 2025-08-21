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
    @Environment(NoteRepo.self) private var repo
    @Environment(AlertService.self) private var alertService
    
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
                    .fill(Color(.systemGray6))
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 6) {
                    TextField("Title", text: $note.title)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(16)
                    
                    TextEditor( text: $note.content )
                    .multilineTextAlignment(.leading)
                    .frame(maxHeight: .infinity)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(16)
                    
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
                                repo.add(note)
                            } else {
                                repo.update(note)
                            }
                            dismiss()
                        }
                        .disabled(note.title.isEmpty)
                    }
                }
                .onChange(of: repo.error) { _, newError in
                    if let error = newError {
                        alertService.showAlert(
                            title: "Note Error",
                            message: error.localizedDescription)
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
        .environment(AlertService())
}
