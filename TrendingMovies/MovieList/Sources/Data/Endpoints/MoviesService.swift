//
//  MoviesService.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation
import Core

protocol MoviesServiceProtocol: Sendable {
    func fetchMovies(page: Int, criteria: MovieListParams?) async throws -> MoviesResponseDTO
    func fetchGenres() async throws -> GenreResponseDTO
}

struct MoviesService: MoviesServiceProtocol{
    
    let networkManager: NetworkManagerProtocol
   
    init(networkManager: NetworkManagerProtocol = NetworkManager(baseURL: Constants.baseUrl)){
        self.networkManager = networkManager
    }
    
    func fetchMovies(page: Int, criteria: MovieListParams?) async throws -> MoviesResponseDTO {
        let trimmed = criteria?.searchQuery?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let endpoint: MoviesEndpoint
        if !trimmed.isEmpty {
            endpoint = .searchMovie(query: trimmed, page: page)
        } else {
            endpoint = .discover(page: page, genreId: criteria?.genreId)
        }
        return try await networkManager.request(endpoint: endpoint)
    }
    
    func fetchGenres() async throws -> GenreResponseDTO {
        let endpoint: MoviesEndpoint = .genres
        return try await networkManager.request(endpoint: endpoint)
    }
}
