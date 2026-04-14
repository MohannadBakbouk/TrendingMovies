//
//  UITestFetchGenresUseCase.swift
//  TrendingMovies
//
//  Created by Mohannad on 14/04/2026.
//

import Foundation
import Core
import MovieList

struct UITestFetchGenresUseCase: FetchGenresUseCaseProtocol {
    func execute() async throws -> [Genre] {
        [
            Genre(id: 16, name: "Animation"),
            Genre(id: 28, name: "Action"),
            Genre(id: 30, name: "Comedy"),
            Genre(id: 31, name: "Drama"),
            Genre(id: 32, name: "Romance"),
            Genre(id: 33, name: "Adventure")
        ]
    }
}
