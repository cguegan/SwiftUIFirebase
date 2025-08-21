//
//  FirebaseError.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 20/08/2025.
//

import Foundation

enum FirebaseError: Error, Equatable, Identifiable {
    
    case notAuthenticated
    case documentNotFound
    case listenerFailed
    case fetchAllFailed
    case addDocumentFailed
    case updateDocumentFailed
    case deleteDocumentFailed
    case unknownError(String)
    
    var id: String {
        self.localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .notAuthenticated:
            return "User is not authenticated."
        case .documentNotFound:
            return "Document not found."
        case .listenerFailed:
            return "Failed to create a snapshot listener."
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
