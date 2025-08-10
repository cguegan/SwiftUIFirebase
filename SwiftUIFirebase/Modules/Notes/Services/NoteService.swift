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
class NoteService {
    
    /// Observable Properties
    var notes: [Note] = []
    
    private var db = Firestore.firestore()
    private var collectionName = "notes"
    
    var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    
    var dbCollection: CollectionReference? {
        guard let userID = currentUserID else { return nil }
        return db.collection("users").document(userID).collection(collectionName)
    }
    
    // Initialize the service
    init() {
        Task {
            try await self.fetchAll()
        }
        
        #if DEBUG
        // For debugging purposes, you can add some sample data
        notes = Note.mocks
        #endif
    }
    
    // Fetch all items
    func fetchAll() async throws  {
        guard let dbCollection = dbCollection else {
            throw FirebaseError.notAuthenticated
        }
        
        do {
            let snapshot = try await dbCollection.order(by: "title").getDocuments()
            self.notes = snapshot.documents.compactMap { document in
                return try? document.data(as: Note.self)
            }
        } catch {
            print("Error fetching documents: \(error)")
            throw FirebaseError.fetchAllFailed
        }
    }
    
    // Add an item
    func add(_ note: Note) throws {
        guard let dbCollection = dbCollection else {
            throw FirebaseError.notAuthenticated
        }
        
        do {
            _ = try dbCollection.addDocument(from: note)
            self.notes.append(note)
        } catch {
            print("Error adding document: \(error.localizedDescription)")
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
            if let index = notes.firstIndex(where: { $0.id == noteID }) {
                notes[index] = note
            } else {
                throw FirebaseError.documentNotFound
            }
        } catch {
            print("Error updating document: \(error)")
            throw FirebaseError.updateDocumentFailed
        }
    }
        
    // Delete an item
    func delete(_ note: Note) throws {
        guard let dbCollection = dbCollection else {
            throw FirebaseError.notAuthenticated
        }
        
        guard let noteID = note.id else {
            throw FirebaseError.deleteDocumentFailed
        }
        
        if let index = notes.firstIndex(where: { $0.id == noteID }) {
            notes.remove(at: index)
        } else {
            throw FirebaseError.documentNotFound
        }
        
        dbCollection.document(noteID).delete { error in
            if let error = error {
                print("Error deleting note: \(error)")
            }
        }
    }
    
}

enum FirebaseError: Error {
    case notAuthenticated
    case documentNotFound
    case fetchAllFailed
    case addDocumentFailed
    case updateDocumentFailed
    case deleteDocumentFailed
    case unknownError(String)
    
    var localizedDescription: String {
        switch self {
        case .notAuthenticated:
            return "User is not authenticated."
        case .documentNotFound:
            return "Document not found."
        case .fetchAllFailed:
            return "Failed to fetch all documents."
        case .addDocumentFailed:
            return "Failed to add document."
        case .updateDocumentFailed:
            return "Failed to update document."
        case .deleteDocumentFailed:
            return "Failed to delete document."
        case .unknownError(let message):
            return message
        }
    }
}
