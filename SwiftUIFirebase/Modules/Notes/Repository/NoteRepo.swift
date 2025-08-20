//
//  NoteService.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import Foundation
import Observation
import FirebaseFirestore
import FirebaseAuth

@MainActor
@Observable
class NoteRepo {
    
    /// Observable Properties
    var notes: [Note] = [Note]()
        
    /// Firebase Firestore Database Reference
    private var db = Firestore.firestore()
    private var collectionName = "notes"
    
    var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    
    var dbCollection: CollectionReference? {
        guard let userID = currentUserID else { return nil }
        return db.collection("users").document(userID).collection(collectionName)
    }
    
    /// Initialize the service
    init() {
        self.getNotes()
        
        #if DEBUG
        /// For debugging purposes, you can add some sample data
        notes = Note.mocks
        #endif
    }
    
    /// Listen to the collection
    func getNotes() {
        guard let dbCollection = dbCollection else {
            print("User is not authenticated or collection does not exist.")
            return
        }
        
        dbCollection.order(by: "title").addSnapshotListener { snapshot, error in
            if let error = error {
                print("❌ Error getting notes: \(error)")
                return
            }
            
            self.notes = snapshot?.documents.compactMap { document in
                try? document.data(as: Note.self)
            } ?? []
        }
    }
    
    // Add an item
    func add(_ note: Note) throws {
        guard let dbCollection = dbCollection else {
            throw FirebaseError.notAuthenticated
        }
        
        do {
            _ = try dbCollection.addDocument(from: note)
        } catch {
            print("❌ Error adding document: \(error.localizedDescription)")
            throw FirebaseError.addDocumentFailed
        }
    }
        
    // Update an item
    func update(_ note: Note) throws {
        guard let dbCollection = dbCollection else {
            throw FirebaseError.notAuthenticated
        }
        
        guard let noteID = note.id else {
            throw FirebaseError.updateDocumentFailed
        }
        
        do {
            try dbCollection.document(noteID).setData(from: note)
        } catch {
            print("❌ Error updating note: \(error)")
        }
    }
        
    /// Delete an item
    func delete(_ note: Note) throws {
        guard let dbCollection = dbCollection else {
            throw FirebaseError.notAuthenticated
        }
        
        guard let noteID = note.id else {
            throw FirebaseError.deleteDocumentFailed
        }
        
        dbCollection.document(noteID).delete { error in
            if let error = error {
                print("❌ Error deleting note: \(error)")
            }
        }
    }
    
}
