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
            Note(title: "First Note", content: "Content of the first note."),
            Note(title: "Second Note", content: "Content of the second note."),
            Note(title: "Third Note", content: "Content of the third note.")
        ]
    }
}

