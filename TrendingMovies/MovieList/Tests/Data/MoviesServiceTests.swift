//
//  MoviesServiceTests.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//


import Testing
@testable import MovieList

@Suite("MoviesService")
struct MoviesServiceTests {
    
    @Test("fetchGenres uses genres endpoint")
    func fetchGenresUsesGenresEndpoint() async throws {
        let networkManager = NetworkManagerMock()
        let expected = GenreResponseDTO.make(items: Samples.genres)
        networkManager.result = .success(expected)
        let serivce = MoviesService(networkManager: networkManager)
        let _ = try await serivce.fetchGenres()
        guard let endpoint = networkManager.receivedEndpoints.first as? MoviesEndpoint else {
            Issue.record("Expected a MoviesEndpoint")
            return
        }
        #expect(endpoint == MoviesEndpoint.genres)
    }
    
    @Test("fetchGenres returns genres set by the network")
    func fetchGenresReturnsGenres() async throws {
        let networkManager = NetworkManagerMock()
        let expected = GenreResponseDTO.make(items: Samples.genres)
        networkManager.result = .success(expected)
        let serivce = MoviesService(networkManager: networkManager)
        let result = try await serivce.fetchGenres()
        #expect(networkManager.requestCallCount == 1)
        #expect(result == expected)
    }
    
    @Test("fetchMovies uses movies endpoint")
    func fetchMoviesUsesMoviesEndpoint() async throws {
        let networkManager = NetworkManagerMock()
        let expected = MoviesResponseDTO.make()
        networkManager.result = .success(expected)
        let serivce = MoviesService(networkManager: networkManager)
        let _ = try await serivce.fetchMovies(page: 1, criteria: nil)
        guard let endpoint = networkManager.receivedEndpoints.first as? MoviesEndpoint else {
            Issue.record("Expected a MoviesEndpoint")
            return
        }
        #expect(endpoint == MoviesEndpoint.discover(page: 1, genreId: nil))
    }
    
    
    @Test("fetchMovies returns movies list")
    func fetchMoviesReturnsMovieList() async throws {
        let networkManager = NetworkManagerMock()
        let expected = MoviesResponseDTO.make(page: 1, results:[MovieDTO.make(id: 1, title: "A")])
        networkManager.result = .success(expected)
        let serivce = MoviesService(networkManager: networkManager)
        let result = try await serivce.fetchMovies(page: 1, criteria: nil)
        #expect(networkManager.requestCallCount == 1)
        #expect(result == expected)
    }
}
    
