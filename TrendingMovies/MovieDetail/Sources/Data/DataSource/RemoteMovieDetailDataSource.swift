//
//  RemoteMovieDetailDataSource.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

struct RemoteMovieDetailDataSource: RemoteMovieDetailDataSourceProtocol {
    
    private let service: MovieDetailServiceProtocol
    
    init(service: MovieDetailServiceProtocol) {
        self.service = service
    }
    
    func getMovieDetail(id: Int) async throws -> MovieDetailResponseDTO{
        try await service.fetchMovieDetail(id: id)
    }
}
