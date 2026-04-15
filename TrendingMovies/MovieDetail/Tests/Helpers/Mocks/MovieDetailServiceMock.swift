//
//  MovieDetailServiceMock.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//

@testable import MovieDetail

struct MovieDetailServiceMock: MovieDetailServiceProtocol {
    var result: Result<MovieDetailResponseDTO, Error>
    
    func fetchMovieDetail(id: Int) async throws -> MovieDetailResponseDTO {
       try result.get()
    }
}
