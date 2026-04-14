//
//  FetchMoviesUseCaseMock.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//

@testable import MovieList

struct FetchMoviesUseCaseMock: FetchMoviesUseCaseProtocol {
    var result: Result<MoviesListPage, Error>

    init(result: Result<MoviesListPage, Error>) {
        self.result = result
    }

    func execute(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage {
        try result.get()
    }
}
