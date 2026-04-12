//
//  MovieDetailService.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

import Core

protocol MovieDetailServiceProtocol: Sendable {
   func fetchMovieDetail(id: Int) async throws -> MovieDetailResponseDTO
}

struct MovieDetailService: MovieDetailServiceProtocol{
    
    let networkManager: NetworkManagerProtocol
   
    init(networkManager: NetworkManagerProtocol = NetworkManager(baseURL: Constants.baseUrl)){
        self.networkManager = networkManager
    }
    
    func fetchMovieDetail(id: Int) async throws -> MovieDetailResponseDTO {
        let endpoint: MovieDetailEndpoint = .movieDetail(id: id)
        return try await networkManager.request(endpoint: endpoint)
    }
}
