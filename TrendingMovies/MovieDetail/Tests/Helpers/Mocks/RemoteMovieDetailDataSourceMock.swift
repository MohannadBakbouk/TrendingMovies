//
//  RemoteMovieDetailDataSourceMock.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//

@testable import MovieDetail

struct RemoteMovieDetailDataSourceMock: RemoteMovieDetailDataSourceProtocol {
    var result: Result<MovieDetailResponseDTO, Error>
    
    func getMovieDetail(id: Int) async throws -> MovieDetailResponseDTO {
        try result.get()
    }
}
