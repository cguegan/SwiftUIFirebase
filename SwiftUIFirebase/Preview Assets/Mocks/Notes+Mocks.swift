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
            Note.mock(id: "mock-1", title: "First Note", content: "Content of the first note."),
            Note.mock(id: "mock-2", title: "Second Note", content: "Content of the second note."),
            Note.mock(id: "mock-3", title: "Third Note", content: "Content of the third note.")
        ]
    }
}
