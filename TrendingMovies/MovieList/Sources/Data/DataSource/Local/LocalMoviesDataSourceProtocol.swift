//
//  LocalMoviesDataSourceProtocol.swift
//  MovieList
//
//  Created by Mohannad on 27/04/2026.
//

protocol LocalMoviesDataSourceProtocol: Sendable {
    func fetchMovies(page: Int) async throws -> [Movie]
    func saveMovies(_ movies: [Movie], page: Int) async throws
    func fetchMaxStoredPage() async throws -> Int
    func fetchGenres() async throws -> [Genre]
    func saveGenres(_ genres: [Genre]) async throws
}
