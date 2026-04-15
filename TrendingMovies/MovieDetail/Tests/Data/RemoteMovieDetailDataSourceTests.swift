//
//  RemoteMovieDetailDataSourceTests.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//
import Testing
@testable import MovieDetail

@Suite("RemoteMovieDetailDataSource")
struct RemoteMovieDetailDataSourceTests {
    
    @Test("Get MovieDetail returns dto object")
    func fetchMovieDetailReturnsDTO() async throws {
        let expected = Samples.movieDetail1
        let service = MovieDetailServiceMock(result: .success(expected))
        let dataSource = RemoteMovieDetailDataSource(service: service)
        let result = try await dataSource.getMovieDetail(id: 1)
        #expect(expected.id == result.id)
        #expect(expected.title == result.title)
    }
    
    @Test("Get MovieDetail throw error")
    func fetchMovieDetailThrowsError() async throws {
        let expected = MockError.someError
        let service = MovieDetailServiceMock(result: .failure(expected))
        let dataSource = RemoteMovieDetailDataSource(service: service)
        await #expect(throws: expected) {
            _ =  try await dataSource.getMovieDetail(id: 1)
        }
    }
}
