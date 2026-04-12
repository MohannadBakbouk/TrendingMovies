//
//  MovieDetailRepository.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

struct MovieDetailRepository: MovieDetailRepositoryProtocol{
    
    let dataSource: RemoteMovieDetailDataSourceProtocol
    
    init(dataSource: RemoteMovieDetailDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getMovieDetail(id: Int) async throws -> MovieDetail {
        let response = try await dataSource.getMovieDetail(id: id)
        return response.toDomain()
    }
}
