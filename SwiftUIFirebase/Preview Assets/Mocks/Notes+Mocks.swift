//
//  Notes+Mocks.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 10/08/2025.
//

import Foundation

extension Note {
    static var mocks: [Note] {
        return [
            Note(id: "1", title: "First Note", content: "Content of the first note.", createdAt: Date(), updatedAt: Date()),
            Note(id: "2", title: "Second Note", content: "Content of the second note.", createdAt: Date(), updatedAt: Date()),
            Note(id: "3", title: "Third Note", content: "Content of the third note.", createdAt: Date(), updatedAt: Date())
        ]
    }
}
