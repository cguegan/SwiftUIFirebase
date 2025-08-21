//
//  NotesListing.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import SwiftUI

struct NotesListing: View {
    
    @Environment(NoteRepo.self) private var repo
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
        .alert(item: $error) { error in
            Alert( title: Text("Error"),
                   message: Text(error.localizedDescription),
                   dismissButton: .default(Text("OK")) )
        }
        .onChange(of: repo.error) { _, newError in
            if let error = newError {
                self.error = error
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
}
