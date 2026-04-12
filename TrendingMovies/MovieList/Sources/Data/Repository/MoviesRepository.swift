//
//  MoviesRepository.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

struct MoviesRepository: MoviesRepositoryProtocol {
    let dataSource: RemoteMoviesDataSourceProtocol
    
    init(dataSource: RemoteMoviesDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getMovies(page: Int, criteria: MovieListParams) async throws -> MoviesListPage {
        let response = try await dataSource.getMovies(page: page, criteria: criteria)
        let movies = response.results.map { $0.toDomain() }
        return MoviesListPage(movies: movies, page: response.page, totalPages: response.totalPages)
    }
    
    func getGenres() async throws -> [Genre] {
        let response = try await dataSource.getGenres()
        return response.genres.map{$0.toDomain()}
    }
}
