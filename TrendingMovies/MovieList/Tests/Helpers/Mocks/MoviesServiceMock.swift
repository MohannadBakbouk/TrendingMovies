//
//  MoviesServiceMock.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//


@testable import MovieList

struct MoviesServiceMock: MoviesServiceProtocol {
    var moviesResult: Result<MoviesResponseDTO, Error> = .failure(MockError.someError)
    var genresResult: Result<GenreResponseDTO, Error> = .failure(MockError.someError)

    func fetchMovies(page: Int, criteria: MovieListParams?) async throws -> MoviesResponseDTO {
        return try moviesResult.get()
    }

    func fetchGenres() async throws -> GenreResponseDTO {
        return try genresResult.get()
    }
}
