//
//  MoviesRepositoryMock.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//

@testable import MovieList
final class MoviesRepositoryMock: MoviesRepositoryProtocol, @unchecked Sendable {
    var getMoviesCallCount = 0
    var getGenresCallCount = 0
    var receivedPage: Int?
    var moviesResult: Result<MoviesListPage, Error> = .failure(MockError.someError)
    var genresResult :  Result<[Genre], Error> = .failure(MockError.someError)

    func getMovies(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage {
        getMoviesCallCount += 1
        receivedPage = page
        return try moviesResult.get()
    }

    func getGenres() async throws -> [Genre] {
        getGenresCallCount += 1
        return try genresResult.get()
    }
}
