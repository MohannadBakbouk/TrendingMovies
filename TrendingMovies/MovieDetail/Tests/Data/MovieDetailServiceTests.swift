//
//  MovieDetailServiceTests.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//
import Testing
@testable import MovieDetail

@Suite("MovieDetailService")
struct MovieDetailServiceTests {
    
    @Test("Test Movie Detail select endpoint properly")
    func testMovieDetailSelectEndpointCorrectly() async throws {
        let networkManager = NetworkManagerMock()
        networkManager.result = .success(Samples.movieDetail1)
        let service = MovieDetailService(networkManager: networkManager)
        _ = try await service.fetchMovieDetail(id: 1)
        guard let endpoint = networkManager.receivedEndpoints.first as? MovieDetailEndpoint else {
            Issue.record("Endpoint is not MovieDetailEndpoint")
            return
        }
        #expect(endpoint == .movieDetail(id: 1))
    }
    
    @Test("Test Movie Detail returns valid result")
    func testMovieDetailReturnsValidResult() async throws {
        let expected = Samples.movieDetail1
        let networkManager = NetworkManagerMock()
        networkManager.result = .success(expected)
        let service = MovieDetailService(networkManager: networkManager)
        let result = try await service.fetchMovieDetail(id: 1)
        #expect(expected.id == result.id)
        #expect(expected.title == result.title)
        #expect(expected.overview == result.overview)
        #expect(expected.posterPath == result.posterPath)
    }
    
    @Test("Test Movie Detail throw error")
    func testMovieDetailThrowsError() async throws {
        let expected = MockError.someError
        let networkManager = NetworkManagerMock()
        networkManager.result = .failure(expected)
        let service = MovieDetailService(networkManager: networkManager)
        await #expect(throws: expected) {
           try await service.fetchMovieDetail(id: 1)
        }
    }
}
