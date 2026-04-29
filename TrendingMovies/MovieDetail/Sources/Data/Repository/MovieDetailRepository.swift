//
//  MovieDetailRepository.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

//
//  MovieDetailRepository.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

struct MovieDetailRepository: MovieDetailRepositoryProtocol{
    
    let remoteDataSource: RemoteMovieDetailDataSourceProtocol
    let localDataSource: LocalMovieDetailDataSourceProtocol
    
    init(remoteSource: RemoteMovieDetailDataSourceProtocol,
         localSource: LocalMovieDetailDataSourceProtocol) {
        self.remoteDataSource = remoteSource
        self.localDataSource = localSource
    }
    
    func getMovieDetail(id: Int) async throws -> MovieDetail {
        do {
            let response = try await remoteDataSource.getMovieDetail(id: id)
            let mappedDetail = response.toDomain()
            try? await localDataSource.saveMovieDetail(value: mappedDetail)
            return mappedDetail
        }
        catch{
            guard let cachedDetail = try? await localDataSource.getMovieDetail(id: id) else {throw error}
            return cachedDetail
        }
    }
}
