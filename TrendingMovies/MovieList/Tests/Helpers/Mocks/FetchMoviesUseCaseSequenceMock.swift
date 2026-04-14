//
//  FetchMoviesUseCaseSequenceMock.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//
@testable import MovieList

@MainActor
final class FetchMoviesUseCaseSequenceMock: FetchMoviesUseCaseProtocol {

    private var results: [Result<MoviesListPage, Error>]

    init(results: [Result<MoviesListPage, Error>]) {
        self.results = results
    }

    func execute(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage {
        guard !results.isEmpty else {
            throw MockError.someError
        }

        return try results.removeFirst().get()
    }
}
 enum MockError: Error {
    case someError
    case invalidMockValue
}
