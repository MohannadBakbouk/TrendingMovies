//
//  MovieListCriteria.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation

struct MovieListParams: Equatable, Sendable {
    var genreId: Int?
    var searchQuery: String?

    static let `default` = MovieListParams(genreId: nil, searchQuery: nil)
}
