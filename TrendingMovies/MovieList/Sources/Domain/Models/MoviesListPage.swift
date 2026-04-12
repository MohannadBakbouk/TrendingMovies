//
//  MoviesListPage.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation

struct MoviesListPage: Sendable {
    let movies: [Movie]
    let page: Int
    let totalPages: Int

    var hasMorePages: Bool { page < totalPages }
}
