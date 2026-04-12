//
//  Movie.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation

struct Movie {
    let uuid: UUID
    let id: Int
    let title, description: String
    let image: URL?
    let year: String
    let genreIds: [Int]
}
