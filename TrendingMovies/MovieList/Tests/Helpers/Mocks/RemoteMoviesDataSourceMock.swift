//
//  RemoteMoviesDataSourceMock.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//

@testable import MovieList

struct RemoteMoviesDataSourceMock: RemoteMoviesDataSourceProtocol {
    var moviesResult: Result<MoviesResponseDTO, Error> = .failure(MockError.someError)
    var genresResult: Result<GenreResponseDTO, Error> = .failure(MockError.someError)

    func getMovies(page: Int, criteria: MovieListParams?) async throws -> MoviesResponseDTO {
        return try moviesResult.get()
    }

    func getGenres() async throws -> GenreResponseDTO {
        return try genresResult.get()
    }
}
