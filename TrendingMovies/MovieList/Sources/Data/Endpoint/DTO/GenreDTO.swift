//
//  GenreDTO.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

// MARK: - Genre
struct GenreDTO: Codable, Equatable {
    let id: Int
    let name: String
}

extension GenreDTO{
    func toDomain() -> Genre {
        Genre(id: id, name: name)
    }
}


struct GenreResponseDTO: Codable, Equatable{
    let genres: [GenreDTO]
}

extension GenreResponseDTO{
    static func make(items: [Genre] = []) -> GenreResponseDTO {
        return GenreResponseDTO(genres: items.map{ GenreDTO(id: $0.id, name: $0.name)})
    }
}
