//
//  MoviesRepositoryProtocol.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//


protocol MoviesRepositoryProtocol: Sendable {
    func getMovies(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage
    func getGenres() async throws -> [Genre]
}
