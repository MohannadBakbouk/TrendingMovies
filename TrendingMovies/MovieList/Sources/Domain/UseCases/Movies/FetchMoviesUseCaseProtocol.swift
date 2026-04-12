//
//  FetchMoviesUseCaseProtocol.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

protocol FetchMoviesUseCaseProtocol: Sendable {
    func execute(page: Int, criteria: MovieListParams) async throws -> MoviesListPage
}
