//
//  MovieDetailRepositoryTests.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//

import Testing
@testable import MovieDetail

@Suite("MovieDetailRepository")
struct MovieDetailRepositoryTests {

    @Test("getMovieDetail maps DTO response to domain")
    func getMovieDetailMapsToDomain() async throws {
        let expected = Samples.movieDetail1
        let dataSource = RemoteMovieDetailDataSourceMock(result: .success(expected))
        let repository = MovieDetailRepository(dataSource: dataSource)
        let result = try await repository.getMovieDetail(id: 1)
        #expect(result.id == expected.id)
        #expect(result.title == expected.title)
        #expect(result.overview == expected.overview)
    }
    
    
    @Test("getMovieDetail throws error properly")
    func getMovieDetailThrowsError() async throws {
        let expected = MockError.someError
        let dataSource = RemoteMovieDetailDataSourceMock(result: .failure(expected))
        let repository = MovieDetailRepository(dataSource: dataSource)
        await #expect(throws: expected) {
            try await repository.getMovieDetail(id: 1)
        }
    }
}
