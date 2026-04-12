//
//  RemoteMoviesDataSourceProtocol.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

protocol RemoteMoviesDataSourceProtocol: Sendable {
    func getMovies(page: Int, criteria: MovieListParams?) async throws -> MoviesResponseDTO
    func getGenres() async throws -> GenreResponseDTO
}
