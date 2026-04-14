//
//  UITestFetchMoviesUseCase.swift
//  TrendingMovies
//
//  Created by Mohannad on 13/04/2026.
//

import Foundation
import Core
import MovieList


struct UITestFetchMoviesUseCase: FetchMoviesUseCaseProtocol {
    func execute(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage {
        if page == 1 {
            return MoviesListPage(
                movies: (1...20).map {
                    Movie(
                        uuid: UUID(),
                        id: $0,
                        title: "Movie \($0)",
                        description: "",
                        image: nil,
                        year: "202\($0)",
                        genreIds: []
                    )
                },
                page: 1,
                totalPages: 2
            )
        } else {
            return MoviesListPage(
                movies: (21...40).map {
                    Movie(
                        uuid: UUID(),
                        id: $0,
                        title: "Movie \($0)",
                        description: "",
                        image: nil,
                        year: "202\($0)",
                        genreIds: []
                    )
                },
                page: 2,
                totalPages: 2
            )
        }
    }
}
