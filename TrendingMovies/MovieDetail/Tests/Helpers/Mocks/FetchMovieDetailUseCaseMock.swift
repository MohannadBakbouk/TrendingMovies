//
//  FetchMovieDetailUseCaseMock.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//
@testable import MovieDetail

struct FetchMovieDetailUseCaseMock: FetchMovieDetailUseCaseProtocol {
    var result: Result<MovieDetail, Error>
    let delay: UInt64

    init(result: Result<MovieDetail, Error>, delay: UInt64 = 0) {
        self.result = result
        self.delay = delay
    }
    
    func execute(id: Int) async throws -> MovieDetail{
        if delay > 0{
            try await Task.sleep(nanoseconds: delay)
        }
        return try result.get()
    }
}
