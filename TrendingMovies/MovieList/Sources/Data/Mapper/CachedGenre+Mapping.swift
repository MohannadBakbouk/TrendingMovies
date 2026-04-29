//
//  CachedGenre+Mapping.swift
//  MovieList
//
//  Created by Mohannad on 27/04/2026.
//
import Core
import CoreData

extension CachedGenre {
    func updateGenre(from: Genre) {
        self.id = Int64(from.id)
        self.name = from.name
    }
    
    func toDomain() -> Genre {
        Genre(id: Int(id), name: name)
    }
}
