//
//  MoviesListPage.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation

public struct MoviesListPage: Sendable, Equatable {
    let movies: [Movie]
    let page: Int
    let totalPages: Int
    
    public init(movies: [Movie], page: Int = 1, totalPages: Int = 1) {
        self.movies = movies
        self.page = page
        self.totalPages = totalPages
    }

    var hasMorePages: Bool { page < totalPages }
}
