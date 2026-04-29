//
//  RemoteMoviesDataSource.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

struct RemoteMoviesDataSource: RemoteMoviesDataSourceProtocol {
    private let service: MoviesServiceProtocol
    
    init(service: MoviesServiceProtocol) {
        self.service = service
    }
    
    func getMovies(page: Int, criteria: MovieListParams? = nil) async throws -> MoviesResponseDTO {
        try await service.fetchMovies(page: page, criteria: criteria)
    }
    
    func getGenres() async throws -> GenreResponseDTO {
        try await service.fetchGenres()
    }
}
