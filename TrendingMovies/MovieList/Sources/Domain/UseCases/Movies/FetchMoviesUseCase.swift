//
//  FetchMoviesUseCase.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//


import Foundation

struct FetchMoviesUseCase: FetchMoviesUseCaseProtocol {
    private let repository: MoviesRepositoryProtocol

    init(repository: MoviesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage {
        try await repository.getMovies(page: page, criteria: criteria)
    }
}
