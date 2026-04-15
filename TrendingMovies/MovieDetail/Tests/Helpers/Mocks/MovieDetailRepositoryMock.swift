//
//  MovieDetailRepositoryMock.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//

@testable import MovieDetail

final class MovieDetailRepositoryMock: MovieDetailRepositoryProtocol, @unchecked Sendable{
    var result: Result<MovieDetail, Error>
    var getMovieDetailsCallCount = 0
    
    init(result: Result<MovieDetail, Error>, getMovieDetailsCallCount: Int = 0) {
        self.result = result
        self.getMovieDetailsCallCount = getMovieDetailsCallCount
    }
    
    func getMovieDetail(id: Int) async throws -> MovieDetail {
        getMovieDetailsCallCount += 1
        return try result.get()
    }
}
