//
//  Movie.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation

public struct Movie: Equatable, Sendable {
    let uuid: UUID
    let id: Int
    let title, description: String
    let image: URL?
    let year: String
    let genreIds: [Int]
    
    public init(uuid: UUID, id: Int, title: String, description: String, image: URL?, year: String, genreIds: [Int]) {
        self.uuid = uuid
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.year = year
        self.genreIds = genreIds
    }
}

public extension Movie {
    static func make(
        uuid: UUID = UUID(),
        id: Int = 1,
        title: String = "Sample Movie",
        description: String = "Sample Description",
        image: URL? = nil,
        year: String = "2024",
        genreIds: [Int] = []
    ) -> Movie {
        Movie(
            uuid: uuid,
            id: id,
            title: title,
            description: description,
            image: image,
            year: year,
            genreIds: genreIds
        )
    }
}
