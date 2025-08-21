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
    
}
