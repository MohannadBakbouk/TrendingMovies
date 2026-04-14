//
//  RemoteMoviesDataSourceTests.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//


import Testing
@testable import MovieList

@Suite("RemoteMoviesDataSource")
@MainActor
struct RemoteMoviesDataSourceTests {
    
    @Test("getMovies forwards params and returns DTO")
    func getMoviesForwardsAndReturnsDTO() async throws {
        var service = MoviesServiceMock()
        let expected = MoviesResponseDTO.make()
        service.moviesResult = .success(expected)
        let dataSource = RemoteMoviesDataSource(service: service)
        let result = try await dataSource.getMovies(page: 1, criteria: nil)
        #expect(result == expected)
    }
    
    @Test("getGenres forwards and returns DTO")
    func getGenresForwardsAndReturnsDTO() async throws {
        var service = MoviesServiceMock()
        let expected = GenreResponseDTO.make(items: Samples.genres)
        service.genresResult = .success(expected)
        let dataSource = RemoteMoviesDataSource(service: service)
        let result = try await dataSource.getGenres()
        #expect(result == expected)
    }
}
