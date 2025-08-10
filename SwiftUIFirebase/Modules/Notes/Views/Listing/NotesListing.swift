//
//  NotesListing.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct NotesListing: View {
    
    @Environment(NoteService.self) private var noteService

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
                Button { addNote() } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
    }
    
    func addNote() {
        do {
            try noteService.add(Note(title: "New Note", content: ""))
        } catch {
            print("Error adding note: \(error)")
        }
    }
    
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

#Preview {
    NotesListing()
}
