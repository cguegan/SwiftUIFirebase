//
//  NotesListing.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct NotesListing: View {
    
    @Environment(NoteRepo.self) private var noteService
    @State var showEditSheet: Bool = false
    
    /// The main view for listing notes
    var body: some View {
        List {
            ForEach(noteService.notes) { note in
                NavigationLink(destination: NoteDetailView(note: note)) {
                    Text(note.title)
                }
            }
            .onDelete(perform: removeItems)
        }
        .navigationTitle("Notes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showEditSheet.toggle() } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            NoteEditSheet(note: nil)
        }
    }
    
    /// Add a new note
    func addNote() {
        do {
            try noteService.add(Note(title: "New Note", content: ""))
        } catch {
            print("Error adding note: \(error)")
        }
    }
    
    /// Remove items at specified offsets
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let note = noteService.notes[index]
            do {
                try noteService.delete(note)
            } catch {
                print("Error deleting note: \(error)")
            }
        }
    }
}

// MARK: - Preview
// ———————————————

#Preview {
    NotesListing()
        .environment(NoteRepo())
}
