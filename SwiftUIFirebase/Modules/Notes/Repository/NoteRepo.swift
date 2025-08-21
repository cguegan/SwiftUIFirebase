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
    var error: FirebaseError?
        
    private var listener: ListenerRegistration?
    
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
            self.error = FirebaseError.listenerFailed
            return
        }
        
        self.listener = dbCollection.order(by: "title").addSnapshotListener { snapshot, error in
            
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                self.error = FirebaseError.listenerFailed
                return
            }

            self.notes = documents.compactMap { document in
                try? document.data(as: Note.self)
            }
        }
    }
    
    /// Stop listening to the collection
    func stopListening() {
        listener?.remove()
    }
    
    // Add an item
    func add(_ note: Note) {
        guard let dbCollection = dbCollection else {
            self.error = FirebaseError.notAuthenticated
            return
        }
        
        do {
            _ = try dbCollection.addDocument(from: note)
        } catch {
            self.error = FirebaseError.addDocumentFailed
        }
    }
        
    // Update an item
    func update(_ note: Note) {
        guard let dbCollection = dbCollection else {
            self.error = FirebaseError.notAuthenticated
            return
        }
        
        guard let noteID = note.id else {
            self.error = FirebaseError.updateDocumentFailed
            return
        }
        
        do {
            try dbCollection.document(noteID).setData(from: note)
        } catch {
            self.error = FirebaseError.updateDocumentFailed
            return
        }
    }
        
    /// Delete an item
    func delete(_ note: Note) async  {
        guard let dbCollection = dbCollection else {
            self.error = FirebaseError.notAuthenticated
            return
        }
        
        guard let noteID = note.id else {
            self.error = FirebaseError.documentNotFound
            return
        }
        
        do {
            try await dbCollection.document(noteID).delete()
        } catch {
            self.error = FirebaseError.deleteDocumentFailed
            return
        }
        
    }
    
}
