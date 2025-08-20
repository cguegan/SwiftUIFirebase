//
//  Note.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import Foundation
import FirebaseFirestore

struct Note: Codable, Identifiable {
    
    @DocumentID
    var id: String?
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date
    
    init(
        title: String,
        content: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    // Private init for creating mock data with IDs
    // This avoids the @DocumentID warning while allowing preview data
    private init(
        mockId: String,
        title: String,
        content: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self._id = DocumentID(wrappedValue: mockId)
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    // Static factory method for creating mock notes with IDs
    static func mock(
        id: String,
        title: String,
        content: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) -> Note {
        return Note(
            mockId: id,
            title: title,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
