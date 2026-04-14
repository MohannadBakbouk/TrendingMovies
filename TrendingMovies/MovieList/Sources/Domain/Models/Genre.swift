//
//  Genre.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

// MARK: - Genre
public struct Genre: Equatable, Sendable {
    let id: Int
    let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
