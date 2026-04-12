//
//  GenreDTO.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

// MARK: - Genre
struct GenreDTO: Codable {
    let id: Int
    let name: String
}

struct GenreResponseDTO: Codable{
    let genres: [GenreDTO]
}

extension GenreDTO{
    func toDomain() -> Genre {
        Genre(id: id, name: name)
    }
}
