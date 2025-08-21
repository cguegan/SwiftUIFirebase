//
//  NotesListing.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct NotesListing: View {
    
    @Environment(NoteRepo.self) private var repo
    @Environment(AlertService.self) private var alertService

    @State var showEditSheet: Bool = false
    @State private var error: FirebaseError? = nil
    
    /// The main view for listing notes
    var body: some View {
        List {
            ForEach(repo.notes) { note in
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
        .onChange(of: repo.error) { _, newError in
            if let error = newError {
                alertService.showAlert( title: "Notes Error",
                                        message: error.localizedDescription )
            }
        }
    }

}


// MARK: - Methods
// ———————————————

extension NotesListing {
   
    /// Remove items at specified offsets
    func removeItems(at offsets: IndexSet) {
        Task {
            for index in offsets {
                let note = repo.notes[index]
                await repo.delete(note)
            }
        }
    }

}


// MARK: - Preview
// ———————————————

#Preview {
    NotesListing()
        .environment(NoteRepo())
        .environment(AlertService())
}
